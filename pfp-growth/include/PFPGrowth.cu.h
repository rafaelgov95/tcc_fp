//
// Created by rafael on 01/09/18.
//
#include "cudaHeaders.h"
#include <cstdint>
#include <iostream>
#include <string>
#include <vector>
#include <thrust/transform_reduce.h>
#include <thrust/functional.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "PFPArray.h"

#ifndef PFP_GROWTH_PFPGROWTH_H
#define PFP_GROWTH_PFPGROWTH_H




class PFPGrowth {
    gpuArrayMap*  ArrayMap;
    gpuArrayMap*  EloPos;
public:
    PFPGrowth(gpuArrayMap *arrayMap,gpuEloMap *eloMap,size_t arrayMapSize,size_t eloPosMapSize);

};


#endif //PFP_GROWTH_PFPGROWTH_H
