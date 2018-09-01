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
struct PFPEloPos{
    Item indexID;
    cuda_int indexArray;
    cuda_int suporte;
    PFPEloPos(const Item ,const cuda_int, const cuda_int);
};

struct PFPArrayMap {
    PFPNode *ItemId ;
    uint64_t indexP;
    uint64_t suporte;
    PFPArrayMap( PFPNode*, const uint64_t);
    PFPArrayMap( PFPNode*, const uint64_t ,const uint64_t);

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
    std::vector<PFPEloPos> eloPos;

private:
   void createHasMap(const PFPTree &fptree,const HashMap &hashMap);
    void eloPosStapOne(std::vector<PFPArrayMap> ArrayMap);
uint64_t recur_is_parent_array( PFPNode *a) ;
    //    PFPHashMap addHash(std::shared_ptr<PFPNode>& parent,PFPHashMap& hasMap);
    void  create_array_and_elepos (const PFPTree& fptree);

};
#endif  // PFP_ARRAY_HP
