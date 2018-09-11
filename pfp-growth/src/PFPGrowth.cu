//
// Created by rafael on 01/09/18.
//
#include "cudaHeaders.h"
#include "Kernel.h"
#include "PFPArray.h"
#include "PFPGrowth.cu.h"
#include "PFPArray.h"
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
PFPGrowth::PFPGrowth(gpuArrayMap *arrayMap, gpuEloMap *eloMap,size_t arrayMapSize,size_t eloPosMapSize) {
    gpuArrayMap *device_ArrayMap;
    gpuEloMap *device_EloMap;


    EloGrid **devicePointersStoredInDeviceMemory;
    cudaMalloc( (void**)&devicePointersStoredInDeviceMemory, sizeof(EloGrid)*eloPosMapSize);


    EloGrid* devicePointersStoredInHostMemory[eloPosMapSize];
    for(int i=0; i<eloPosMapSize; i++)
        cudaMalloc( (void**)&devicePointersStoredInHostMemory[i], sizeof(EloGrid *) );

    cudaMemcpy(
            devicePointersStoredInDeviceMemory,
            devicePointersStoredInHostMemory,
            sizeof(EloGrid*), cudaMemcpyHostToDevice);



    gpuErrchk(cudaMalloc((void **) &device_ArrayMap, sizeof(gpuArrayMap)*arrayMapSize));
    gpuErrchk(cudaMemcpy(device_ArrayMap, arrayMap, sizeof(gpuArrayMap)*arrayMapSize, cudaMemcpyHostToDevice));

    gpuErrchk(cudaMalloc((void **) &device_EloMap, sizeof(gpuEloMap)*eloPosMapSize));
    gpuErrchk(cudaMemcpy(device_EloMap, eloMap, sizeof(gpuArrayMap)*eloPosMapSize, cudaMemcpyHostToDevice));



    run<<<1,eloPosMapSize>>>(devicePointersStoredInDeviceMemory,device_ArrayMap,device_EloMap,arrayMapSize,eloPosMapSize);
    gpuErrchk( cudaPeekAtLastError());
    gpuErrchk( cudaDeviceSynchronize());

    EloGrid* hostPointersStoredInHostMemory[eloPosMapSize];
    for(int i=0; i<eloPosMapSize; i++) {
        EloGrid* hostPointer = hostPointersStoredInHostMemory[i];
        // (allocate memory for hostPointer here!)
        EloGrid* devicePointer = devicePointersStoredInHostMemory[i];
        cudaMemcpy(hostPointer, devicePointer, sizeof(EloGrid), cudaMemcpyDeviceToHost);
    }
    printf("%d",hostPointersStoredInHostMemory[0]->size);

//    cudaFree(device_EloMap);
//    cudaFree(device_ArrayMap);
//    cudaFree(host_elo_grid);
//    cudaFree(device_elo_grid);

}
