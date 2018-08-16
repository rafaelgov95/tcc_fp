#include <iostream>
#include "FPGrowth.h"
#include "FPHeaderTable.h"
#include "FPTransMap.h"
#include <thrust/device_vector.h>
#include <thrust/extrema.h>
#include <algorithm>
#include "numeric"

using namespace cuda_fp_growth;

__global__
void new_header_table( const BitBlock* __restrict__ trans_map, size_type blocks_per_trans,
                       const InnerNode* __restrict__ inner_nodes, const LeafNode* __restrict__ leaf_nodes,
                       const cuda_uint* __restrict__ parent_ht, size_type min_support, index_type node_idx, cuda_uint* output )
{
    FPHeaderTable sub_ht( trans_map, blocks_per_trans, inner_nodes, leaf_nodes, parent_ht, min_support, node_idx );
    cudaDeviceSynchronize();
    size_type ht_size = sub_ht.size(), ia_size = sub_ht.ia_size();
    memcpy( output, sub_ht.data(), HTBufferSize( ht_size, ia_size ) );
}

void test_sub_header_table( const FPTransMap& trans_map, const FPRadixTree& radix_tree, const FPHeaderTable& header_table, size_type min_support,
                            index_type node_idx, Items& items, Sizes& counts, Sizes& ia_sizes, Indices& ia_arrays, Sizes& node_counts, NodeTypes& node_types )
{
    thrust::device_vector<cuda_uint> output( HTBufferSize( header_table.size(), header_table.ia_size() ) / sizeof( cuda_uint ), 0 );
    cuda_uint* _output = output.data().get();
    new_header_table <<< 1, 1 >>>( trans_map.bitmap().data().get(), trans_map.blocks_per_transaction(),
            radix_tree.inner_nodes().data().get(), radix_tree.leaf_nodes().data().get(),
            header_table.data(), min_support, node_idx,  _output );
    cudaDeviceSynchronize();

    std::vector<cuda_uint> data( output.begin(), output.end() );
    size_type ht_size = data[ 0 ], ia_size = data[ 1 ];
    auto current = data.begin() + 2;

    items.clear();
    items.insert( items.end(), current, current + ht_size );
    current += ht_size;

    counts.clear();
    counts.insert( counts.end(), current, current + ht_size );
    current += ht_size;

    ia_sizes.clear();
    ia_sizes.insert( ia_sizes.end(), current, current + ht_size );
    current += ht_size;

    ia_arrays.clear();
    ia_arrays.insert( ia_arrays.end(), current, current + ht_size * ia_size );
    current += ht_size * ia_size;

    node_counts.clear();
    node_counts.insert( node_counts.end(), current, current + ht_size * ia_size );
    current += ht_size * ia_size;

    node_types.resize( ht_size * ia_size );
    std::transform( current, current + ht_size * ia_size, node_types.begin(), []( cuda_uint value ) { return static_cast<NodeType>( value ); } );
}

void sort_results( const Sizes& ia_sizes, Indices& ia_arrays, Sizes& node_counts, NodeTypes& node_types )
{
    for ( index_type i = 0; i < ia_sizes.size(); ++i ) {
        size_type ia_size = ia_sizes[ i ];
        size_type begin_pos = i * ia_size;

        std::vector<index_type> order( ia_size );
        std::iota( order.begin(), order.end(), begin_pos );
        std::sort( order.begin(), order.end(), [&]( index_type idx_a, index_type idx_b ) {
            NodeType type_a = node_types[ idx_a ], type_b = node_types[ idx_b ];
            index_type ia_a = ia_arrays[ idx_a ], ia_b = ia_arrays[ idx_b ];
            return ( type_a < type_b ) || ( type_a == type_b && ia_a < ia_b );
        } );

        Indices ordered_ia_arrays( ia_size );
        Sizes ordered_node_counts( ia_size );
        NodeTypes ordered_node_types( ia_size );
        for ( index_type i = 0; i < order.size(); ++i ) {
            ordered_ia_arrays[ i ] = ia_arrays[ order[ i ] ];
            ordered_node_counts[ i ] = node_counts[ order[ i ] ];
            ordered_node_types[ i ] = node_types[ order[ i ] ];
        }
        std::move( ordered_ia_arrays.begin(), ordered_ia_arrays.end(), ia_arrays.begin() + begin_pos );
        std::move( ordered_node_counts.begin(), ordered_node_counts.end(), node_counts.begin() + begin_pos );
        std::move( ordered_node_types.begin(), ordered_node_types.end(), node_types.begin() + begin_pos );
    }
}
bool pattern_exists( const std::vector<cuda_uint>& buffer, const std::vector<Item>& pattern, const size_type support, const cuda_real confidence = 0.0f )
{
    index_type i = 0;
    while ( i < buffer.size() ) {
        size_type length = buffer[ i ] / sizeof( cuda_uint );
        size_type offset = ( confidence > 0.0f ? 3 : 2 );
        bool exists = true;
        exists &= ( pattern.size() == length - offset );
        exists &= ( buffer[ i + 1 ] == support );
        exists &= ( std::equal( pattern.begin(), pattern.end(), buffer.begin() + i + offset ) );
        if ( confidence > 0.0f ) {
            const cuda_uint* ptr = &buffer[ i + 2 ];
            exists &= ( std::abs( *( reinterpret_cast<const cuda_real*>( ptr ) ) - confidence ) < 0.0001 );
        }
        if ( exists ) return true;

        i += ( buffer[i] / sizeof( cuda_uint ) );
    }
    return false;
}
size_type pattern_count( const std::vector<cuda_uint>& buffer )
{
    index_type i = 0;
    size_type pattern_count = 0;
    while ( i < buffer.size() ) {
        ++pattern_count;
        i += ( buffer[i] / sizeof( cuda_uint ) );
        std::cout<< "AQUI: "<<( buffer[i] / sizeof( cuda_uint ) ) <<std::endl;
    }


    return pattern_count;
}

int main() {

    const cuda_fp_growth::Item a = 0, b = 1, c = 2, d = 3, e = 4, f = 5, g = 6, h = 7, i = 8, j = 9, k = 10, l = 11, m = 12, n = 13,
            o = 14, p = 15, q = 16, r = 17, s = 18, t = 19, u = 20, v = 21, w = 22, x = 23, y = 24, z = 25;

    cuda_fp_growth::Items trans {
            f, a, c, d, g, i, m, p,
            a, b, c, f, l, m, o,
            b, f, h, j, o,
            b, c, k, s, p,
            a, f, c, e, l, p, m, n
    };



    // start index of each transaction
    Indices indices { 0, 8, 15, 20, 25 };

    // number of items in each transaction
    Sizes sizes { 8, 7, 5, 5, 8 };

    // construct FPTransactionMap object
    size_type min_support = 3;
    FPTransMap trans_map( trans.cbegin(), indices.cbegin(), sizes.cbegin(), indices.size(), min_support );
    FPRadixTree radix_tree( trans_map );
    FPHeaderTable header_table( trans_map, radix_tree, min_support );
    cudaDeviceSynchronize();


    if(header_table.size() == 6){
        std::cout<<"FOI"<<std::endl;
    }

    Items items;
    Sizes counts, ia_sizes, node_counts;
    Indices ia_arrays;
    NodeTypes node_types;

    test_sub_header_table( trans_map, radix_tree, header_table, min_support, 0, items, counts, ia_sizes, ia_arrays, node_counts, node_types );
    sort_results( ia_sizes, ia_arrays, node_counts, node_types );
    if( items.size() == 6 ){
        std::cout<<"FOI"<<std::endl;
    };
//
//    REQUIRE( inner_nodes.size() == 3 );
//    CHECK( inner_nodes[ 0 ].parent_idx == 0 );
//    CHECK( inner_nodes[ 0 ].range_start == 0 );
//    CHECK( inner_nodes[ 0 ].range_end == 3 );
//    CHECK( inner_nodes[ 0 ].left_is_leaf == false );
//    CHECK( inner_nodes[ 0 ].right_is_leaf == false );
//    CHECK( inner_nodes[ 0 ].left_idx == 1 );
//    CHECK( inner_nodes[ 0 ].right_idx == 2 );
//    CHECK( inner_nodes[ 0 ].prefix_length == 0 );
//    CHECK( inner_nodes[ 0 ].trans_count == 5 );
//
//    CHECK( inner_nodes[ 1 ].parent_idx == 0 );
//    CHECK( inner_nodes[ 1 ].range_start == 0 );
//    CHECK( inner_nodes[ 1 ].range_end == 1 );
//    CHECK( inner_nodes[ 1 ].left_is_leaf == true );
//    CHECK( inner_nodes[ 1 ].right_is_leaf == true );
//    CHECK( inner_nodes[ 1 ].left_idx == 0 );
//    CHECK( inner_nodes[ 1 ].right_idx == 1 );
//    CHECK( inner_nodes[ 1 ].prefix_length == 3 );
//    CHECK( inner_nodes[ 1 ].trans_count == 2 );
//
//    CHECK( inner_nodes[ 2 ].parent_idx == 0 );
//    CHECK( inner_nodes[ 2 ].range_start == 2 );
//    CHECK( inner_nodes[ 2 ].range_end == 3 );
//    CHECK( inner_nodes[ 2 ].left_is_leaf == true );
//    CHECK( inner_nodes[ 2 ].right_is_leaf == true );
//    CHECK( inner_nodes[ 2 ].left_idx == 2 );
//    CHECK( inner_nodes[ 2 ].right_idx == 3 );
//    CHECK( inner_nodes[ 2 ].prefix_length == 1 );
//    CHECK( inner_nodes[ 2 ].trans_count == 3 );
//
//    REQUIRE( leaf_nodes.size() == 4 );
//    CHECK( leaf_nodes[ 0 ].parent_idx == 1 );
//    CHECK( leaf_nodes[ 0 ].trans_count == 1 );
//
//    CHECK( leaf_nodes[ 1 ].parent_idx == 1 );
//    CHECK( leaf_nodes[ 1 ].trans_count == 1 );
//
//    CHECK( leaf_nodes[ 2 ].parent_idx == 2 );
//    CHECK( leaf_nodes[ 2 ].trans_count == 2 );
//
//    CHECK( leaf_nodes[ 3 ].parent_idx == 2 );
//    CHECK( leaf_nodes[ 3 ].trans_count == 1 );

//    CHECK( pattern_exists( buffer, { a }, 3, 1.0 ) );
//    CHECK( pattern_exists( buffer, { c, a }, 3, 1.0 ) );
//    CHECK( pattern_exists( buffer, { f, a }, 3, 1.0 ) );
//    CHECK( pattern_exists( buffer, { f, c }, 3, 1.0 ) );
//    CHECK( pattern_exists( buffer, { f, c, a }, 3, 1.0 ) );
    return 0;
}
//
/*
   Copyright 2016 Frank Ye

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
 */

//#ifndef UNIT_TEST
//
//// This tells Catch to provide a main() - only do this in one cpp file
//#define CATCH_CONFIG_MAIN
//
//#include "unit-test/catch.hpp"
//
//#else
//
//extern "C"
//{
//}
//
//#endif  // UNIT_TEST