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

inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort = true) {
    if (code != cudaSuccess) {
        fprintf(stderr, "GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
        if (abort) exit(code);
    }
}

PFPGrowth::PFPGrowth(ArrayMap *arrayMap, Elo *eloMap, size_t arrayMapSize, size_t eloPosMapSize) {
    ArrayMap *device_ArrayMap;
    Elo *device_EloMap;
    Elo *device_pointer_elo_kx[eloPosMapSize], *host_pointer_elo_kx[eloPosMapSize];
    int *device_int_array;

    cudaMalloc((void**) &device_int_array, sizeof(int)*eloPosMapSize);
    cudaMemset (device_int_array , 0 , eloPosMapSize * sizeof ( int ));
    for (int i = 0; i < eloPosMapSize ; ++i) {
         host_pointer_elo_kx[i]=(Elo*)malloc(sizeof(Elo) * eloPosMapSize);
   }
   for (int i = 0; i < eloPosMapSize ; ++i) {
        cudaMalloc((void **) &device_pointer_elo_kx[i], sizeof(Elo) * eloPosMapSize);
    }

    for (int j = 0; j < eloPosMapSize; ++j) {
        cudaMemcpy(device_pointer_elo_kx[j],host_pointer_elo_kx[j],sizeof(Elo) *eloPosMapSize,cudaMemcpyHostToDevice);
    }

    gpuErrchk(cudaMalloc((void **) &device_ArrayMap, sizeof(ArrayMap) * arrayMapSize));
    gpuErrchk(cudaMemcpy(device_ArrayMap, arrayMap, sizeof(ArrayMap) * arrayMapSize, cudaMemcpyHostToDevice));

    gpuErrchk(cudaMalloc((void **) &device_EloMap, sizeof(Elo) * eloPosMapSize));
    gpuErrchk(cudaMemcpy(device_EloMap, eloMap, sizeof(Elo) * eloPosMapSize, cudaMemcpyHostToDevice));

    run << < 1,eloPosMapSize >>>
            (device_pointer_elo_kx,
                    device_int_array,
                    device_ArrayMap,
                    device_EloMap,
                    arrayMapSize,
                    eloPosMapSize);

    gpuErrchk(cudaPeekAtLastError());
    gpuErrchk(cudaDeviceSynchronize());


//    for (int l = 0; l < eloPosMapSize ; ++l) {
//        cudaMemcpy(host_pointer_elo_kx[l],
//                   device_pointer_elo_kx[l],
//                   sizeof(Elo)*eloPosMapSize,
//                   cudaMemcpyDeviceToHost);
//
//    }

    cudaFree(device_EloMap);
    cudaFree(device_ArrayMap);


}
