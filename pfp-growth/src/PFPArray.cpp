#include <algorithm>
#include <cassert>
#include <iostream>
#include <cstdint>
#include <utility>
#include <cublas_v2.h>
#include <PFPArray.h>
#include "PFPArray.h"
#include "Kernel.h"

PFPEloPos::PFPEloPos(const char *itemID, const cuda_int indexArray, const cuda_int suporte) : indexID(itemID),
                                                                                              indexArray(indexArray),
                                                                                              suporte(suporte) {
}

PFPArrayMap::PFPArrayMap(PFPNode *i, const int p, const int s) : ItemId(i), indexP(p), suporte(s) {
}


PFPArray::PFPArray(const PFPTree &fptree) {
    fptree.root.get()->frequency = -1;
    create_array_and_elepos(fptree);
    eloPosStapOne(arrayMap);
}

void PFPArray::createHasMap(const PFPTree &fptree, const HashMap &hashMap) {
    auto rootFolha = fptree.rootFolhas.get()->next;
    while (rootFolha) {
        auto current_leaf = rootFolha.get()->value;
        while (current_leaf.get()) {

        }
    }

}

void PFPArray::eloPosStapOne(std::vector<PFPArrayMap> ArrayMap) {
    std::string a = "{}";
    size_t size = sizeof(gpuEloMap) * ArrayMap.size();
    _eloMap = (gpuEloMap *) malloc(size);
    for (auto it = ArrayMap.begin(); it != ArrayMap.end(); ++it) {
        long index = std::distance(ArrayMap.begin(), it);
        if (a != (*it).ItemId->item) {
            PFPEloPos eloNew = PFPEloPos(it.base()->ItemId->item.c_str(), (int)index, cuda_int(it.base()->suporte));
            eloMap.push_back(eloNew);
            _eloMap[index].suporte=eloNew.suporte;
            std::strcpy(_eloMap[index].ItemId,eloNew.indexID);
        }
    }
}


int PFPArray::recur_is_parent_array(PFPNode *current_leaf) {
    auto k = std::find_if(hashMap.begin(), hashMap.end(), [&](std::pair<PFPArrayMap, int> const &ref) {
        return ref.first.ItemId == current_leaf;
    });
    if (k != hashMap.cend()) {
        return k->second;
    } else {
        int parent_pos =(int)arrayMap.size() + 1;
        return parent_pos;
    }
}


void PFPArray::create_array_and_elepos(const PFPTree &fptree) {
    auto rootFolha = fptree.rootFolhas;
    while (rootFolha) {
        auto current_leaf = rootFolha.get()->value;
        bool returnn = false;
        while (current_leaf.get()) {
            auto bb = std::find_if(hashMap.begin(), hashMap.end(), [&](std::pair<PFPArrayMap, uint64_t> const &ref) {
                return ref.first.ItemId == current_leaf.get();
            });
            if (bb == hashMap.cend() && !current_leaf.get()->is_visit) {
                int parent_pos = 0;
                if (current_leaf.get()->parent) {
                    parent_pos = recur_is_parent_array(current_leaf.get()->parent.get());
                }
                current_leaf.get()->is_visit = true;
                const PFPArrayMap a(current_leaf.get(), parent_pos, current_leaf.get()->frequency);
                arrayMap.push_back(a);
                size_t pos = arrayMap.size() - 1;
                if (current_leaf.get()->parent) {
                    hashMap.push_back(std::make_pair(a, uint64_t(pos)));
                }
            } else {
                if (current_leaf.get()->is_visit && !current_leaf.get()->children.empty()) {
                    returnn = true;
                } else {
                    auto Id_parent = recur_is_parent_array(current_leaf.get()->parent.get());
                    current_leaf.get()->is_visit = true;
                    const PFPArrayMap a(current_leaf.get(), Id_parent, current_leaf.get()->frequency);
                    arrayMap.push_back(a);
                }
            }
            if (!returnn) {
                current_leaf = current_leaf.get()->parent;
            } else {
                current_leaf = nullptr;
            }

        }
        rootFolha = rootFolha.get()->next;
    }
    size_t size = sizeof(gpuArrayMap) * arrayMap.size();
    _arrayMap = (gpuArrayMap *) malloc(size);
    for (auto it = arrayMap.begin(); it != arrayMap.end(); ++it) {
        long index = std::distance(arrayMap.begin(), it);
        _arrayMap[index].suporte = (*it).suporte;
        _arrayMap[index].indexP = (*it).indexP;
        std::strcpy(_arrayMap[index].ItemId, (*it).ItemId->item.c_str());
        std::cout << _arrayMap[index].ItemId << std::endl;
    }
}




