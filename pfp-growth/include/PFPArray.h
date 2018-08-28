#ifndef PFP_ARRAY_HP
#define PFP_ARRAY_HP

#include <cstdint>
#include <map>
#include <memory>
#include <set>
#include <string>
#include <vector>
#include <utility>
#include "PFPTree.hpp"

#include <iostream>
#include <thrust/device_vector.h>

class PFPArray{
public:
    PFPArray(const PFPTree &fptree);

private:
    using PFPHashMap = std::pair<std::shared_ptr<PFPNode>,int>;
    PFPHashMap addHash(std::shared_ptr<PFPNode>& parent,PFPHashMap& hasMap);
    void  create_array_and_elepos (const PFPTree& fptree, PFPHashMap& hashMap);

};
#endif  // PFP_ARRAY_HP
