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

#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }


inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort = true) {
    if (code != cudaSuccess) {
        fprintf(stderr, "GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
        if (abort) exit(code);
    }
}

__device__ char *my_strcpy(char *dest, const char *src) {
    int i = 0;
    do {
        dest[i] = src[i];
    } while (src[i++] != 0);
    return dest;
}

__device__ char *my_strcat(char *dest, const char *src) {
    int i = 0;
    while (dest[i] != 0) i++;
    my_strcpy(dest + i, src);
    return dest;
}

__device__ char *my_cpcat(const char *array1, const char *array2, char *src) {
    my_strcat(src, array1);
    my_strcat(src, array2);
    return src;
}

__device__ void
reducex_suporte(EloGrid *eloGrid, gpuArrayMap *arrayMap, gpuEloMap *eloMap, size_t arrayMapSize, size_t eloMapSize,
                int elo_k1_map_size, gpuEloMap *Elo_k1) {


    int indexEloMap = eloGrid->size;
    eloGrid->eloMap[indexEloMap].elo = Elo_k1;
    eloGrid->eloMap[indexEloMap].size=elo_k1_map_size;

    for (int i = 0; i < eloGrid->eloMap[indexEloMap].size; i++)
        printf("THREAD %d ITEMID %s | IndexArray %d| Suporte %d |\n", threadIdx.x,  eloGrid->eloMap[indexEloMap].elo[i].ItemId,eloGrid->eloMap[indexEloMap].elo[i].indexArrayMap,eloGrid->eloMap[indexEloMap].elo[i].suporte);
    eloGrid->size=+eloGrid->size;
}


__device__ void
geracao_candidato(EloGrid **Elo_Grid, gpuArrayMap *arrayMap, gpuEloMap *eloMap, size_t arrayMapSize, size_t eloMapSize) {
    auto indexAtual = threadIdx.x;
    int xxx = 0;
    bool flag = true;
    gpuEloMap *Elo_k1 = (gpuEloMap *) malloc(sizeof(gpuEloMap) * eloMapSize);
    while (flag && (indexAtual + xxx) < eloMapSize) {
        char a[32] = "";
            auto indexParentArrayMap = arrayMap[eloMap[indexAtual + xxx].indexArrayMap].indexP;
            if (arrayMap[indexParentArrayMap].indexP != -1 &&
                arrayMap[eloMap[indexAtual].indexArrayMap].indexP != -1) {
                my_cpcat(arrayMap[eloMap[indexAtual].indexArrayMap].ItemId,
                         arrayMap[indexParentArrayMap].ItemId, a);
                my_strcpy(Elo_k1[xxx].ItemId, a);
                Elo_k1[xxx].indexArrayMap = arrayMap[eloMap[indexAtual+xxx].indexArrayMap].indexP;
                Elo_k1[xxx].suporte = arrayMap[eloMap[indexAtual+xxx].indexArrayMap].suporte;
            } else {
                my_cpcat(arrayMap[eloMap[indexAtual].indexArrayMap].ItemId,
                         arrayMap[indexParentArrayMap].ItemId, a);
                my_strcpy(Elo_k1[xxx].ItemId, a);
                Elo_k1[xxx].indexArrayMap = arrayMap[indexParentArrayMap].indexP;
                Elo_k1[xxx].suporte = arrayMap[indexAtual].suporte;
               flag = false;
            }
            xxx++;
    }
    reducex_suporte(Elo_Grid[indexAtual], arrayMap, eloMap, arrayMapSize, eloMapSize, xxx - 1, Elo_k1);

}

__global__ void run(EloGrid **Elo_k1, gpuArrayMap *arrayMap, gpuEloMap *eloMap, size_t sizeArrayMap, size_t eloMapSize) {

    if (threadIdx.x < eloMapSize) {
        Elo_k1[threadIdx.x] = (EloGrid *) malloc(sizeof(EloGrid));
        Elo_k1[threadIdx.x]->size = 0;
        Elo_k1[threadIdx.x]->eloMap = (EloMap *) malloc(sizeof(EloMap *)* eloMapSize);
        geracao_candidato(Elo_k1, arrayMap, eloMap, sizeArrayMap, eloMapSize);
    }
//    cudaFree(Elo_k1);

}

