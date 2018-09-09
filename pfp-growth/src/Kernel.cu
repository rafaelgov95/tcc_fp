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

__device__ void reducex_suporte(gpuEloMap *Elo_k1,gpuArrayMap *arrayMap, gpuEloMap *eloMap, size_t arrayMapSize, size_t eloMapSize,size_t elo_k1_map_size) {

    printf("THREAD %d Elo Size %d\n",  threadIdx.x,elo_k1_map_size);

    for(int i =0;i<elo_k1_map_size;i++)
    printf("THREAD %d CHAR %s\n",  threadIdx.x,Elo_k1[i].ItemId);




//    printf("THREAD FINALIZANDO TRABALHO %d\n", threadIdx.x);
}


__device__ void geracao_candidato( gpuEloMap *Elo_k1,gpuArrayMap *arrayMap, gpuEloMap *eloMap, size_t arrayMapSize, size_t eloMapSize) {
    auto indexAtual = threadIdx.x;
    int xxx = 0;
    auto indexParentArrayMap = arrayMap[eloMap[threadIdx.x].indexArrayMap].indexP;
    bool flag = true;
    while (flag) {
        if (arrayMap[indexParentArrayMap].indexP != -1 && arrayMap[indexAtual].indexP != -1) {
            char a[32] = "";
            my_cpcat(arrayMap[indexAtual].ItemId, arrayMap[indexParentArrayMap].ItemId, a);
            my_strcpy(Elo_k1[xxx].ItemId, a);
            Elo_k1[xxx].indexArrayMap = arrayMap[indexParentArrayMap].indexP;
            Elo_k1[xxx].suporte = arrayMap[indexAtual].suporte;
            printf("THEREAD %d | %s INDEX %d  SUPORTE %d \n", threadIdx.x, Elo_k1[xxx].ItemId,Elo_k1[xxx].indexArrayMap,Elo_k1[xxx].suporte);
        } else {
            flag = false;
        }
        xxx++;
        indexParentArrayMap = arrayMap[eloMap[threadIdx.x + xxx].indexArrayMap].indexP;
    }
    reducex_suporte(Elo_k1,arrayMap,eloMap,arrayMapSize,eloMapSize,(size_t)xxx-1);

}

__global__ void AlgoritmoI(gpuEloMap **Elo_k1, gpuArrayMap *arrayMap, gpuEloMap *eloMap, size_t sizeArrayMap,size_t eloMapSize) {

if (threadIdx.x< sizeArrayMap - 1) {
Elo_k1[threadIdx.x] = (gpuEloMap *)malloc(sizeof(gpuEloMap)*sizeArrayMap);
geracao_candidato(Elo_k1[threadIdx.x],arrayMap,eloMap,sizeArrayMap,eloMapSize);
} else {
printf("ELO VACOU");
}
free(Elo_k1[threadIdx.x]);

}

