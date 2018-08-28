#include <algorithm>
#include <cassert>
#include <cstdint>
#include <utility>
#include <iostream>
#include "PFPTree.hpp"
PFPLeaf::PFPLeaf(const std::shared_ptr<PFPNode> &):
        value( value ), next(next)
{
}

PFPNode::PFPNode(const Item& item, const std::shared_ptr<PFPNode>& parent):
        item( item ), frequency( 1 ),parent( parent ), children(children)
{
}



PFPTree::PFPTree(const std::vector<Transaction>& transactions, uint64_t minimum_support_threshold) :
        root( std::make_shared<PFPNode>( Item{}, nullptr ) ),
        minimum_support_threshold( minimum_support_threshold ),
        rootFolhas(std::make_shared<PFPLeaf>( nullptr ))
{



    std::map<Item, uint64_t> frequency_by_item;
    for ( const Transaction& transaction : transactions ) {
        for ( const Item& item : transaction ) {
            ++frequency_by_item[item];
        }
    }

    // keep only items which have a frequency greater or equal than the minimum support threshold
    for ( auto it = frequency_by_item.cbegin(); it != frequency_by_item.cend(); ) {
        const uint64_t item_frequency = (*it).second;
        if ( item_frequency < minimum_support_threshold ) { frequency_by_item.erase( it++ ); }
        else { ++it; }
    }


    // order items by decreasing frequency
    struct frequency_comparator
    {
        bool operator()(const std::pair<Item, uint64_t> &lhs, const std::pair<Item, uint64_t> &rhs) const
        {
            return   lhs.second > rhs.second   || lhs.second == rhs.second  && lhs.first < rhs.first   ;
        }
    };
    std::set<std::pair<Item, uint64_t>, frequency_comparator> items_ordered_by_frequency(frequency_by_item.cbegin(), frequency_by_item.cend());
//     sort frequent items   // ERRO
//

 auto curr_rootFolhas = rootFolhas;
    // scan the transactions again
    for ( const Transaction& transaction : transactions ) {
        auto curr_fpnode = root;
        const auto curr_fpleaf_new = std::make_shared<PFPLeaf>(nullptr);
        curr_rootFolhas.get()->next = curr_fpleaf_new;
        curr_rootFolhas = curr_fpleaf_new;
        // select and sort the frequent items in transaction according to the order of items_ordered_by_frequency
        for ( const auto& pair : items_ordered_by_frequency ) {
            const Item& item = pair.first;

            // check if item is contained in the current transaction
            if ( std::find( transaction.cbegin(), transaction.cend(), item ) != transaction.cend() ) {
                // insert item in the tree

                // check if curr_fpnode has a child curr_fpnode_child such that curr_fpnode_child.item = item
                const auto it = std::find_if(
                    curr_fpnode->children.cbegin(), curr_fpnode->children.cend(),  [item](const std::shared_ptr<PFPNode>& fpnode) {
                        return fpnode->item == item;
                } );
                if ( it == curr_fpnode->children.cend() ) {
                    // the child doesn't exist, create a new node
                    const auto curr_fpnode_new_child = std::make_shared<PFPNode>( item, curr_fpnode );
                    // add the new node to the tree
                    curr_fpnode->children.push_back( curr_fpnode_new_child );


                    // update the leaf structure
//                    if (curr_fpnode.get()->children.empty()){

//                    }
                    // advance to the next node of the current transaction
                    curr_fpnode = curr_fpnode_new_child;

                    curr_rootFolhas.get()->value = curr_fpnode;
                }
                else {
                    // the child exist, increment its frequency
                    auto curr_fpnode_child = *it;
                    ++curr_fpnode_child->frequency;
                    if (curr_fpnode_child.get()->children.empty()){
                        curr_rootFolhas.get()->value = curr_fpnode_child;
                    }
                    // advance to the next node of the current transaction
                    curr_fpnode = curr_fpnode_child;
                }
            }

        }


    }
}

bool PFPTree::empty() const
{
    assert( root );
    return root->children.size() == 0;
}


