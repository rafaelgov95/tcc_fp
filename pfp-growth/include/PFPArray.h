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

struct PFPArrayMap {
    std::string ItemId ;
    uint64_t indexP;
    uint64_t suporte;
    PFPArrayMap(const std::string, const uint64_t);
    PFPArrayMap(const std::string, const uint64_t ,const uint64_t);

};
//struct PFPHashMap {
//    std::shared_ptr<PFPArrayMap>& key;
//    uint64_t value;
//    PFPHashMap()
//};
using HashMap = std::vector<std::pair<PFPArrayMap,uint64_t >> ;
class PFPArray{
public:
    PFPArray( const PFPTree &fptree);
    HashMap hashMap;
    std::vector<PFPArrayMap> ArrayMap;
private:
uint64_t recur_is_parent_array( PFPNode *a) ;
    //    PFPHashMap addHash(std::shared_ptr<PFPNode>& parent,PFPHashMap& hasMap);
    void  create_array_and_elepos (const PFPTree& fptree);

};
#endif  // PFP_ARRAY_HP
