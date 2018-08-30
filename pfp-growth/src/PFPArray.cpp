#include <algorithm>
#include <cassert>
#include <cstdint>
#include <utility>
#include "PFPArray.h"
#include "Kernel.h"

PFPArrayMap::PFPArrayMap(const std::string i, const size_t p, const uint64_t s) : ItemId(i), indexP(p), suporte(s) {
}


PFPArray::PFPArray(const PFPTree &fptree) {
    fptree.root.get()->frequency = std::uint64_t(-1);
    create_array_and_elepos(fptree);
}

uint64_t PFPArray::recur_is_parent_array(PFPNode *current_leaf) {
    auto k = std::find_if(hashMap.begin(), hashMap.end(), [&](std::pair<PFPArrayMap, uint64_t> const &ref) {
        return ref.first.ItemId == current_leaf->item;
    });
    if (k != hashMap.cend()) {
        return k->second;
    } else {

        uint64_t parent_pos = ArrayMap.size() + 1;
        return parent_pos;
    }
}


void PFPArray::create_array_and_elepos(const PFPTree &fptree) {

    auto rootFolha = fptree.rootFolhas.get()->next;
    while (rootFolha) {
        auto current_leaf = rootFolha.get()->value;
        bool returnn = false;
        while (current_leaf.get()) {
            auto bb = std::find_if(hashMap.begin(), hashMap.end(), [&](std::pair<PFPArrayMap, uint64_t> const &ref) {
                return ref.first.ItemId == current_leaf.get()->item;
            });
            if (bb == hashMap.cend()) {
                uint64_t parent_pos;
                if (current_leaf.get()->parent) {
                    parent_pos = recur_is_parent_array(current_leaf.get()->parent.get());
                }
                const PFPArrayMap a(current_leaf.get()->item, parent_pos, current_leaf.get()->frequency);
                ArrayMap.push_back(a);
                size_t pos = ArrayMap.size() - 1;
                if (current_leaf.get()->parent) {
                    hashMap.push_back(std::make_pair(a, uint64_t(pos)));
                }
            } else {
                auto Id_parent = recur_is_parent_array(current_leaf.get()->parent.get());
                if(Id_parent > ArrayMap.size() -1 ) {
                    const PFPArrayMap a(current_leaf.get()->item, Id_parent, current_leaf.get()->frequency);
                    ArrayMap.push_back(a);
                } else{
                    if(current_leaf.get()->children.empty() && Id_parent <ArrayMap.size()-1 ){
                        const PFPArrayMap a(current_leaf.get()->item, Id_parent, current_leaf.get()->frequency);
                        ArrayMap.push_back(a);
                        returnn = true;
                    }else {
                        returnn = true;
                    }
                }

            }
           if(!returnn){
               current_leaf = current_leaf.get()->parent;
            }else{
               current_leaf= nullptr;
            }

        }
        rootFolha = rootFolha.get()->next;
    }

}


// Plano B

//             auto bb =  std::find_if(HashMap.begin(), HashMap.end(), [&](std::pair<PFPArrayMap,uint64_t> const &ref) {
//                 return ref.first.ItemId==current_leaf.get()->item;
//             });
//          if(bb==HashMap.cend()){
//              uint64_t parent_pos;
//              if(current_leaf.get()->parent)
//              { parent_pos= ArrayMap.size() + 1;}
//              else{
//                  parent_pos = uint64_t (1-2);}
//              const PFPArrayMap a(current_leaf.get()->item, parent_pos,current_leaf.get()->frequency);
//              ArrayMap.push_back(a);
//              size_t pos = ArrayMap.size() - 1;
//              HashMap.push_back(std::make_pair(a,uint64_t(pos)));
//          }else{
//
//              const PFPArrayMap a(current_leaf.get()->item, recur_create_array(current_leaf.get()),current_leaf.get()->frequency);
//
//          }




