//
// Created by rafael on 01/09/18.
//

#include <cstdint>
#include <iostream>
#include <string>
#include <vector>
#include <thrust/device_vector.h>
#include "PFPArray.h"
#ifndef PFP_GROWTH_PFPGROWTH_H
#define PFP_GROWTH_PFPGROWTH_H

using DEloPos = thrust::device_vector<PFPEloPos>;
using DArrayMap = thrust::device_vector<PFPArrayMap>;

class PFPGrowth {
    DArrayMap  ArrayMap;
    DEloPos  EloPos;
    std::vector<PFPEloPos>  Kx_EloPos;

private:
    void alingElo();
    void mining_candidate();
public:
    PFPGrowth(std::vector<PFPArrayMap> arrayMaps,std::vector<PFPEloPos> eloPos);
};


#endif //PFP_GROWTH_PFPGROWTH_H
