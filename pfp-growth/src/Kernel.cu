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

inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
    if (code != cudaSuccess)
    {
        fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
        if (abort) exit(code);
    }
}
__device__ char * my_strcpy(char *dest, const char *src){
    int i = 0;
    do {
        dest[i] = src[i];}
    while (src[i++] != 0);
    return dest;
}

__device__ char * my_strcat(char *dest, const char *src){
    int i = 0;
    while (dest[i] != 0) i++;
    my_strcpy(dest+i, src);
    return dest;
}
__device__ char * my_cpcat(const char *array1, const char *array2, char *src){
    my_strcat(src,array1);
    my_strcat(src,array2);
    return src;
}
__device__ void reducex_suporte(gpuArrayMap *arrayMap, gpuEloMap *eloMap){
    printf("THREAD FINALIZANDO TRABALHO %d\n",threadIdx.x);
}
__device__ void geracao_candidato(gpuArrayMap *arrayMap, gpuEloMap *eloMap,gpuEloMap **elosMap,int round) {
    auto indexAtual = threadIdx.x;
//    thrust::device_vector<elosMap> B();
    int xxx = 0;
    auto indexParentArrayMap = arrayMap[eloMap[threadIdx.x].indexArrayMap].indexP;
    bool flag = true;
    gpuEloMap *b;
    gpuErrchk(cudaMalloc((void **) &b, sizeof(gpuEloMap)*12));
    while (flag) {
        if (arrayMap[indexParentArrayMap].indexP != -1 && arrayMap[indexAtual].indexP != -1) {
            char a[12]="";
            my_cpcat(arrayMap[indexAtual].ItemId,arrayMap[indexParentArrayMap].ItemId, a);

//            my_cpcat(arrayMap[indexAtual].ItemId,arrayMap[indexParentArrayMap].ItemId, b[xxx].ItemId);
            printf("AQUI  %s\n",a);
//            elosMap[threadIdx.x][xxx].indexP=arrayMap[indexParentArrayMap].indexP;
//            elosMap[threadIdx.x][xxx].suporte=arrayMap[indexAtual].suporte;
//            printf("AQUI %s ",b.ItemId);
//            =(gpuArrayMap *)malloc(sizeof(gpuArrayMap));
//            my_cpcat(arrayMap[indexAtual].ItemId,arrayMap[indexParentArrayMap].ItemId,b->ItemId);
//            printf("AQUI  %s\n", my_strcat(arrayMap[indexAtual].ItemId,arrayMap[indexParentArrayMap].ItemId));
//            printf("THEREAD %d ID %s INDEX %d  SUPORTE %d \n", threadIdx.x, elosMap[threadIdx.x][xxx].ItemId,elosMap[threadIdx.x][xxx].indexP,elosMap[threadIdx.x][xxx].suporte);
//                   arrayMap[indexParentArrayMap].ItemId);
        } else {
            flag = false;
        }
        xxx++;
        indexParentArrayMap = arrayMap[eloMap[threadIdx.x + xxx].indexArrayMap].indexP;
    }
    reducex_suporte(arrayMap,eloMap);

}

__global__ void AlgoritmoI(gpuEloMap **elosMaps, gpuArrayMap *arrayMap, gpuEloMap *eloMap, size_t sizeArrayMap,int round) {

    if (threadIdx.x < sizeArrayMap - 1) {
//        printf("ELO ITEM: %s |  INDEX ARRAY %d | SUPORTE %d\n", eloMap[threadIdx.x].ItemId,
//               eloMap[threadIdx.x].indexArrayMap, eloMap[threadIdx.x].suporte);
        geracao_candidato(arrayMap, eloMap,elosMaps,round);

    } else {
        printf("ELO VACOU");
    }


}

__global__ void AlgoritmoI() {
    printf("Hello from block %d, thread %d\n", blockIdx.x, threadIdx.x);
}
