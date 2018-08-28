#ifndef PFPTREE_HPP
#define PFPTREE_HPP

#include <cstdint>
#include <map>
#include <memory>
#include <set>
#include <string>
#include <vector>
#include <utility>

using Item = std::string;
using Transaction = std::vector<Item>;
using TransformedPrefixPath = std::pair<std::vector<Item>, uint64_t>;
using Pattern = std::pair<std::set<Item>, uint64_t>;

struct PFPNode {
    const Item item;
    uint64_t frequency;
    std::shared_ptr<PFPNode> parent;
    std::vector<std::shared_ptr<PFPNode>> children;
    PFPNode(const Item&, const std::shared_ptr<PFPNode>&);
};


struct PFPLeaf{
    std::shared_ptr<PFPNode> value;
    std::shared_ptr<PFPLeaf> next;
    PFPLeaf(const std::shared_ptr<PFPNode>&);
};


struct PFPTree {
    std::shared_ptr<PFPNode> root;
    std::shared_ptr<PFPLeaf> rootFolhas;
    uint64_t minimum_support_threshold;

    PFPTree(const std::vector<Transaction>&, uint64_t);

    bool empty() const;
};


#endif  // PFPTREE_HPP
