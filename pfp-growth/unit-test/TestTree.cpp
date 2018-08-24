
#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include "catch.hpp"
#include "PFPTree.hpp"
#include "PFPGrowth.h"

    TEST_CASE( "FPTransMap correctly functions", "[FPTransMap]" ) {

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

    const uint64_t minimum_support_threshold = 3;

    const FPTree fptree{ transactions, minimum_support_threshold };
     FPGrowth pfp_growth( fptree);

    std::set<Pattern>  patterns = pfp_growth.padroes();
    REQUIRE( patterns.size() == 18 );
    CHECK( patterns.count( { { f }, 4 } ) );
    CHECK( patterns.count( { { c, f }, 3 } ) );
    CHECK( patterns.count( { { c }, 4 } ) );
    CHECK( patterns.count( { { b }, 3 } ) );
    CHECK( patterns.count( { { p, c }, 3 } ) );
    CHECK( patterns.count( { { p }, 3 } ) );
    CHECK( patterns.count( { { m, f, c }, 3 } ) );
    CHECK( patterns.count( { { m, f }, 3 } ) );
    CHECK( patterns.count( { { m, c }, 3 } ) );
    CHECK( patterns.count( { { m }, 3 } ) );
    CHECK( patterns.count( { { a, f, c, m }, 3 } ) );
    CHECK( patterns.count( { { a, f, c }, 3 } ) );
    CHECK( patterns.count( { { a, f, m }, 3 } ) );
    CHECK( patterns.count( { { a, f }, 3 } ) );
    CHECK( patterns.count( { { a, c, m }, 3 } ) );
    CHECK( patterns.count( { { a, c }, 3 } ) );
    CHECK( patterns.count( { { a, m }, 3 } ) );
    CHECK( patterns.count( { { a }, 3 } ) );
    }


