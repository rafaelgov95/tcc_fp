#ifndef PFP_TREE_GROWTH_HP
#define PFP_TREE_GROWTH_HP

#include <cstdint>
#include <map>
#include <memory>
#include <set>
#include <string>
#include <vector>
#include <utility>
#include "PFPTree.hpp"

using Item = std::string;
using Transaction = std::vector<Item>;
using TransformedPrefixPath = std::pair<std::vector<Item>, uint64_t>;
using Pattern = std::pair<std::set<Item>, uint64_t>;



class FPGrowth{
public:
    FPGrowth(const FPTree &fptree);
    inline std::set<Pattern> padroes() { return padrao;};

private:
    std::set<Pattern>  padrao;
    inline   std::set<Pattern>  fptree_growth (const FPTree& fptree);
};


#endif  // PFP_TREE_GROWTH_HP
