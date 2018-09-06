#ifndef PFP_ARRAY_HP
#define PFP_ARRAY_HP

#include <cstdint>
#include <map>
#include <memory>
#include <set>
#include <string>
#include <vector>
#include <utility>
#include "PFPTree.h"

#include <iostream>
#include <thrust/device_vector.h>
#define MAX_STR_SIZE 32

struct PFPEloPos {
    const char *indexID;
    cuda_int indexArray;
    cuda_int suporte;

    PFPEloPos(const char *Item, const cuda_int, const cuda_int);
};


struct PFPArrayMap {
    PFPNode *ItemId;
    int indexP;
    int suporte;

    PFPArrayMap(PFPNode *, const int);

    PFPArrayMap(PFPNode *, const int, const int);

};
typedef struct {
    char ItemId[MAX_STR_SIZE];
    cuda_int indexArrayMap;
    cuda_int suporte;
} gpuEloMap;

typedef struct {
    char ItemId[MAX_STR_SIZE];
    cuda_int indexP;
    cuda_int suporte;
} gpuArrayMap;

using HashMap = std::vector<std::pair<PFPArrayMap, int >>;
class PFPArray {
public:
    PFPArray(const PFPTree &fptree);
    HashMap hashMap;
    gpuArrayMap*  _arrayMap;
    gpuEloMap*  _eloMap;
    std::vector<PFPArrayMap> arrayMap;
    std::vector<PFPEloPos> eloMap;

private:
    void createHasMap(const PFPTree &fptree, const HashMap &hashMap);

    void eloPosStapOne(std::vector<PFPArrayMap> ArrayMap);

    int recur_is_parent_array(PFPNode *a);

    void create_array_and_elepos(const PFPTree &fptree);

};

#endif  // PFP_ARRAY_HP
