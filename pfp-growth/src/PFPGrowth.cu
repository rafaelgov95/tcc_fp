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
PFPGrowth::PFPGrowth(gpuArrayMap *arrayMap, gpuEloMap *eloMap) {
    gpuArrayMap *device_ArrayMap;
    gpuErrchk(cudaMalloc((void **) &device_ArrayMap, sizeof(arrayMap)));
    gpuErrchk(cudaMemcpy(device_ArrayMap, arrayMap, sizeof(arrayMap), cudaMemcpyHostToDevice));
    AlgoritmoI<<<1,12>>>(device_ArrayMap,eloMap);
    gpuErrchk( cudaPeekAtLastError());
    gpuErrchk( cudaDeviceSynchronize() );
}
