//
// Created by rafael on 01/09/18.
//
#include "cudaHeaders.h"
#include "Kernel.h"
#include "PFPArray.h"
#include "PFPGrowth.cu.h"
#include "PFPArray.h"
#include "../include/PFPArray.h"
#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
    if (code != cudaSuccess)
    {
        fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
        if (abort) exit(code);
    }
}
PFPGrowth::PFPGrowth(std::vector <PFPArrayMap> arrayMap) {

    gpuArrayMap *host_ArrayMap = (gpuArrayMap *) malloc(sizeof(gpuArrayMap) * arrayMap.size());
    for (auto it = arrayMap.begin(); it != arrayMap.end(); ++it) {
        int index = std::distance(arrayMap.begin(), it);
        host_ArrayMap[index].suporte = (*it).suporte;
        host_ArrayMap[index].indexP = (*it).indexP;
        std::strcpy(host_ArrayMap[index].ItemId, (*it).ItemId->item.c_str());
//        std::cout<<a[index].ItemId<<std::endl;
    }

    int size = sizeof(gpuArrayMap) * arrayMap.size();
    gpuArrayMap *device_ArrayMap;
    gpuErrchk(cudaMalloc((void **) &device_ArrayMap, size));
    gpuErrchk(cudaMemcpy(device_ArrayMap, host_ArrayMap, size, cudaMemcpyHostToDevice));
    std::cout<<host_ArrayMap[0].indexP<<std::endl;

    AlgoritmoI<<<1,12>>>(device_ArrayMap);
    gpuErrchk( cudaPeekAtLastError() );
    gpuErrchk( cudaDeviceSynchronize() );
}
