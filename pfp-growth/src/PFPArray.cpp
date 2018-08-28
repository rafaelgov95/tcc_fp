#include <algorithm>
#include <cassert>
#include <cstdint>
#include <utility>
#include "PFPArray.h"
#include "Kernel.h"

PFPArray::PFPArray( const PFPTree& fptree)
{
    PFPHashMap hasMap;
    create_array_and_elepos(fptree,hasMap);
}
PFPArray::PFPHashMap PFPArray::addHash( std::shared_ptr<PFPNode>& parent, PFPHashMap& hasMap){

}

 void PFPArray::create_array_and_elepos(const PFPTree &fptree,  PFPHashMap& hashMap){

               auto  rootFolha= fptree.rootFolhas.get()->next;
               while (rootFolha){
                   auto current_item = rootFolha.get()->value;
                   while (current_item.get()->item!="")
                   {
                       addHash(current_item,hashMap);
                       auto suporte = current_item.get()->frequency;
                       current_item=current_item->parent;
                   }
                    rootFolha = rootFolha.get()->next;
               }

}




