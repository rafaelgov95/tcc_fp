//
// Created by rafael on 20/08/18.
//

#include <cudaHeaders.h>
#include "Kernel.h"
#include "PFPTree.h"
#include "PFPArray.h"
#include <cuda_runtime_api.h>
#include <cstdio>
#include "cuda.h"
#include "../include/PFPArray.h"

__global__ void AlgoritmoI(gpuArrayMap *arrayMap, gpuEloMap *eloMap) {
    if (threadIdx.x < 12) {
        printf("ARRAY ITEM: %s | PARENT INDEX %d | SUPORTE %d\n", arrayMap[threadIdx.x].ItemId,
               arrayMap[threadIdx.x].indexP, arrayMap[threadIdx.x].suporte);

    }
    if (threadIdx.x < 11) {
        printf("ELO ITEM: %s |  INDEX ARRAY %d | SUPORTE %d\n", eloMap[threadIdx.x].ItemId,
               eloMap[threadIdx.x].indexArrayMap, eloMap[threadIdx.x].suporte);
    }

}
__global__ void AlgoritmoI(){
    printf("Hello from block %d, thread %d\n", blockIdx.x, threadIdx.x);
}
