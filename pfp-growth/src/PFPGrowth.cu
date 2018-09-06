//
// Created by rafael on 01/09/18.
//
#include "cudaHeaders.h"
#include "Kernel.h"
#include "PFPArray.h"
#include "PFPGrowth.cu.h"
#include "PFPArray.h"
#include "PFPArray.h"
#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
    if (code != cudaSuccess)
    {
        fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
        if (abort) exit(code);
    }
}
PFPGrowth::PFPGrowth(gpuArrayMap *arrayMap, gpuEloMap *eloMap,size_t arrayMapSize,size_t eloPosMapSize) {
    gpuArrayMap *device_ArrayMap;
    gpuEloMap *device_EloMap;
    gpuErrchk(cudaMalloc((void **) &device_ArrayMap, sizeof(gpuArrayMap)*arrayMapSize));
    gpuErrchk(cudaMemcpy(device_ArrayMap, arrayMap, sizeof(gpuArrayMap)*arrayMapSize, cudaMemcpyHostToDevice));

    gpuErrchk(cudaMalloc((void **) &device_EloMap, sizeof(gpuEloMap)*eloPosMapSize));
    gpuErrchk(cudaMemcpy(device_EloMap, eloMap, sizeof(gpuArrayMap)*eloPosMapSize, cudaMemcpyHostToDevice));

    AlgoritmoI<<<1,12>>>(device_ArrayMap,device_EloMap);
    gpuErrchk( cudaPeekAtLastError());
    gpuErrchk( cudaDeviceSynchronize() );
}
