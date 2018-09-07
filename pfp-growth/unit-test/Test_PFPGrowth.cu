
//#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
//#include "catch.hpp"
#include "PFPTree.h"
#include "PFPArray.h"
#include "PFPGrowth.cu.h"
#include "Kernel.h"
//    TEST_CASE( "FPTransMap correctly functions", "[FPTransMap]" ) {

    const Item a{ "A" };
    const Item b{ "B" };
    const Item c{ "C" };
    const Item d{ "D" };
    const Item e{ "E" };
    const Item f{ "F" };
    const Item g{ "G" };
    const Item h{ "H" };
    const Item i{ "I" };
    const Item j{ "J" };
    const Item k{ "K" };
    const Item l{ "L" };
    const Item m{ "M" };
    const Item n{ "N" };
    const Item o{ "O" };
    const Item p{ "P" };
    const Item s{ "S" };

    const std::vector<Transaction> transactions{
            { f, a, c, d, g, i, m, p },
            { a, b, c, f, l, m, o },
            { b, f, h, j, o },
            { b, c, k, s, p },
            { a, f, c, e, l, p, m, n }
    };
int main( int argc, char * argv[] ){
        const uint64_t minimum_support_threshold = 3;
        const PFPTree fptree{transactions, minimum_support_threshold};
        PFPArray pfp_array(fptree);
        PFPGrowth pfpGrowth(pfp_array._arrayMap,pfp_array._eloMap,pfp_array.arrayMap.size(),pfp_array.arrayMap.size()-1);
    return 0;
    }
