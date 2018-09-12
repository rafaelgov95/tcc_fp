//
// Created by rafael on 20/08/18.
//

#ifndef FP_GROWTH_GPU_KERNEL_PFP_H
#define FP_GROWTH_GPU_KERNEL_PFP_H


#include <cuda_runtime_api.h>
#include <cstdio>
#include "cuda.h"
#include "cudaHeaders.h"
#include "PFPArray.h"

__global__ void run(Elo **Elo_k1,int *array_int_elo, ArrayMap *arrayMap, Elo *eloMap, size_t arrayMapSize, size_t eloMapSize);


#endif //FP_GROWTH_GPU_KERNEL_PFP_H
