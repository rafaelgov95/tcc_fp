#include <algorithm>
#include <cassert>
#include <cstdint>
#include <utility>

#include "PFPTree.hpp"


FPNode::FPNode(const Item& item, const std::shared_ptr<FPNode>& parent) :
    item( item ), frequency( 1 ), node_link( nullptr ), parent( parent ), children()
{
}

FPTree::FPTree(const std::vector<Transaction>& transactions, uint64_t minimum_support_threshold) :
    root( std::make_shared<FPNode>( Item{}, nullptr ) ), header_table(),
    minimum_support_threshold( minimum_support_threshold )
{
    // scan the transactions counting the frequency of each item
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
            return std::tie(lhs.second, lhs.first) > std::tie(rhs.second, rhs.first);
        }
    };
    std::set<std::pair<Item, uint64_t>, frequency_comparator> items_ordered_by_frequency(frequency_by_item.cbegin(), frequency_by_item.cend());

    // start tree construction

    // scan the transactions again
    for ( const Transaction& transaction : transactions ) {
        auto curr_fpnode = root;

        // select and sort the frequent items in transaction according to the order of items_ordered_by_frequency
        for ( const auto& pair : items_ordered_by_frequency ) {
            const Item& item = pair.first;

            // check if item is contained in the current transaction
            if ( std::find( transaction.cbegin(), transaction.cend(), item ) != transaction.cend() ) {
                // insert item in the tree

                // check if curr_fpnode has a child curr_fpnode_child such that curr_fpnode_child.item = item
                const auto it = std::find_if(
                    curr_fpnode->children.cbegin(), curr_fpnode->children.cend(),  [item](const std::shared_ptr<FPNode>& fpnode) {
                        return fpnode->item == item;
                } );
                if ( it == curr_fpnode->children.cend() ) {
                    // the child doesn't exist, create a new node
                    const auto curr_fpnode_new_child = std::make_shared<FPNode>( item, curr_fpnode );

                    // add the new node to the tree
                    curr_fpnode->children.push_back( curr_fpnode_new_child );

                    // update the node-link structure
                    if ( header_table.count( curr_fpnode_new_child->item ) ) {
                        auto prev_fpnode = header_table[curr_fpnode_new_child->item];
                        while ( prev_fpnode->node_link ) { prev_fpnode = prev_fpnode->node_link; }
                        prev_fpnode->node_link = curr_fpnode_new_child;
                    }
                    else {
                        header_table[curr_fpnode_new_child->item] = curr_fpnode_new_child;
                    }

                    // advance to the next node of the current transaction
                    curr_fpnode = curr_fpnode_new_child;
                }
                else {
                    // the child exist, increment its frequency
                    auto curr_fpnode_child = *it;
                    ++curr_fpnode_child->frequency;

                    // advance to the next node of the current transaction
                    curr_fpnode = curr_fpnode_child;
                }
            }
        }
    }
}

bool FPTree::empty() const
{
    assert( root );
    return root->children.size() == 0;
}


