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

typedef struct {
    Elo *elo;
    int *array;
    int size;
}SetMap;

inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort = true) {
    if (code != cudaSuccess) {
        fprintf(stderr, "GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
        if (abort) exit(code);
    }
}
__device__ int counter;
__shared__ Elo elo[256];

__device__ int roundd;

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

//extern __shared__ int s[];

//__device__ void Add_Elo_Frequencia_Elo_k1(Elo *vecor){
//    extern __shared__ int s[];
//}



//    SetMap *setMap =(SetMap*)malloc(sizeof(SetMap));
//    setMap->array=(int*)malloc(sizeof(int)*eloMapSize);
//    setMap->elo=(Elo *)malloc(sizeof(Elo)*eloMapSize);
//    setMap->size=0;
//
//
//    int indexEloMap = eloGrid[threadIdx.x].size;
//    eloGrid[threadIdx.x].eloMap[indexEloMap].elo = Elo_k1;
//    eloGrid[threadIdx.x].eloMap[indexEloMap].size=elo_k1_map_size;
////
//    for (int i = 0; i < eloGrid[threadIdx.x].eloMap[indexEloMap].size; i++) {
//        for (int j = 0;j<setMap->size; ++j) {
//            if(setMap->elo[j].ItemId==eloGrid[threadIdx.x].eloMap[indexEloMap].elo[i].ItemId){
//                setMap->array[j]=setMap->array[j]+1;
//            }
//        }
//        setMap->elo=&eloGrid[threadIdx.x].eloMap[indexEloMap].elo[i];
//        setMap->array[i]=setMap->array[i]+1;
//        setMap->size=setMap->size+1;

//Final_Elo[0] =*
//Elo_k1;
//
__device__ void put_k1_elo(Elo **Elo_k1,Elo *elo_k1, int sizeEloLocal) {
for (int i = 0; i < sizeEloLocal; ++i)
elo[atomicAdd(&roundd,1)]=elo_k1[i];
}

__device__ void reducex_suporte(Elo **Elo_k1,int *sizeArray,Elo *elo_k1, int sizeEloLocal) {


if(threadIdx.x==10){
for (int i = 0; i < roundd; ++i)
printf("%d %s\n",threadIdx.x, elo[i].ItemId);
}



//    int k=0;
//    int kk=(int)nn;
//

//    for (int i=kk; i < (n+kk); ++i) {
//
//        Elo_k1[i] = elo_k1[k];
//        printf("THREAD %d ITEMID %s | IndexArray %d| Suporte %d |\n", threadIdx.x,Elo_k1[i].ItemId,Elo_k1[i].indexArrayMap,Elo_k1[i].suporte);
//
//        k++;
//    }
//    if(threadIdx.x==9){
//        for (int i=0; i <15; ++i) {
//            printf("THREAD %d ITEMID %s | IndexArray %d| Suporte %d |\n", threadIdx.x,Elo_k1[i].ItemId,Elo_k1[i].indexArrayMap,Elo_k1[i].suporte);
//        }
//    }

//    nn=(int*)kk+n;
//    printf("%d %d\n",threadIdx.x ,nn);
//    __syncthreads();
//    if(threadIdx.x==10) {
//        printf("FIM %d %d\n",threadIdx.x ,nn);
//        for (int i = 0; i < nn ; ++i) {
//            printf("THREAD %d ITEMID %s | IndexArray %d| Suporte %d |\n", threadIdx.x,elo_k1[i].ItemId,elo_k1[i].indexArrayMap,elo_k1[i].suporte);
//        }
//    }
//    __syncthreads();

//        printf("THREAD %d ITEMID %s | IndexArray %d| Suporte %d |\n", threadIdx.x,
//               eloGrid[threadIdx.x].eloMap[indexEloMap].elo[i].ItemId,
//               eloGrid[threadIdx.x].eloMap[indexEloMap].elo[i].indexArrayMap,
//               eloGrid[threadIdx.x].eloMap[indexEloMap].elo[i].suporte);
//    }
//    eloGrid[threadIdx.x].size=eloGrid[threadIdx.x].size+1;
////    eloGrid[threadIdx.x].size=eloGrid[threadIdx.x].size+1;
//    for (int k = 0; k < setMap->size ; ++k) {
//        printf("%s | %d\n",setMap->elo[k].ItemId,setMap->array[k]);
//
//    }
}
//for (int i = 0; i < n; ++i){
//printf("THREAD %d ITEMID %s | IndexArray %d| Suporte %d |\n", threadIdx.x, Elo_k1[i].ItemId,
//Elo_k1[i].indexArrayMap,Elo_k1[i].suporte);
//}


__device__ void
geracao_candidato(Elo **elo_k1,int *nn,ArrayMap *arrayMap, Elo *eloMap, size_t arrayMapSize, size_t eloMapSize) {
    auto indexAtual = threadIdx.x;
    int xxx = 0;
    bool flag = true;
//    Elo *elo_k1=(Elo *) malloc(sizeof(Elo*) * eloMapSize);
//    Elo_Grid[threadIdx.x].eloMap[Elo_Grid[threadIdx.x].size].elo = (Elo *) malloc(sizeof(Elo*) * eloMapSize);
//    Elo_Grid[threadIdx.x].eloMap[Elo_Grid[threadIdx.x].size].size =0;

    Elo *Elo_k1 = (Elo *) malloc(sizeof(Elo) * eloMapSize);
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
    put_k1_elo(elo_k1,Elo_k1,(xxx-1));
    reducex_suporte(elo_k1,nn,Elo_k1,(xxx - 1));
}

__global__ void run(Elo **Elo_k1,int *nn, ArrayMap *arrayMap, Elo *eloMap, size_t ArrayMapSize, size_t eloMapSize) {

    if (threadIdx.x < eloMapSize) {
    geracao_candidato(Elo_k1,nn,arrayMap, eloMap, ArrayMapSize, eloMapSize);
    }

}

