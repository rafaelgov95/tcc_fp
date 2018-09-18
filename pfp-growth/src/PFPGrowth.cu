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
    EloVector *device_pointer_elo_vector, *host_elos_vector_and_memory_pointer_elos, *data_host_elos_vector;
    Elo *host_elos[eloPosMapSize];
    int *deviceEloVectorSize;
    int hostEloVectorSize=1;


    data_host_elos_vector = (EloVector *)malloc(sizeof(EloVector)*eloPosMapSize);
    for (int j = 0; j < eloPosMapSize; ++j) {
        data_host_elos_vector[j].eloArray=(Elo *)malloc(sizeof(Elo)*eloPosMapSize);
    }
    data_host_elos_vector[0].eloArray=eloMap;
    data_host_elos_vector[0].size=eloPosMapSize;

    host_elos_vector_and_memory_pointer_elos = (EloVector*)malloc(eloPosMapSize * sizeof(EloVector));
    memcpy(host_elos_vector_and_memory_pointer_elos, data_host_elos_vector, eloPosMapSize * sizeof(EloVector));

    for (int i=0; i<eloPosMapSize; i++){
        cudaMalloc(&(host_elos_vector_and_memory_pointer_elos[i].eloArray), eloPosMapSize*2*sizeof(Elo));
        cudaMemcpy(host_elos_vector_and_memory_pointer_elos[i].eloArray, data_host_elos_vector[i].eloArray, eloPosMapSize*sizeof(Elo), cudaMemcpyHostToDevice);
    }
    cudaMalloc((void **)&device_pointer_elo_vector, sizeof(EloVector)*eloPosMapSize);
    cudaMemcpy(device_pointer_elo_vector,host_elos_vector_and_memory_pointer_elos,sizeof(EloVector)*eloPosMapSize,cudaMemcpyHostToDevice);


    gpuErrchk(cudaMalloc((void **) &device_ArrayMap, sizeof(ArrayMap) * arrayMapSize));

    gpuErrchk(cudaMalloc((void **) &deviceEloVectorSize, sizeof(int)));

    gpuErrchk(cudaMemcpy(device_ArrayMap, arrayMap, sizeof(ArrayMap) * arrayMapSize, cudaMemcpyHostToDevice));

    gpuErrchk(cudaMemcpy(deviceEloVectorSize,&hostEloVectorSize, sizeof(int), cudaMemcpyHostToDevice));

    pfp_growth << < 1,eloPosMapSize,50*sizeof(Elo)>>>
                  (device_pointer_elo_vector,
                    deviceEloVectorSize,
                    device_ArrayMap,
                    arrayMapSize);

    gpuErrchk(cudaPeekAtLastError());
    gpuErrchk(cudaDeviceSynchronize());

    for(int i =0;i<eloPosMapSize;++i) {
        host_elos[i] = (Elo *) malloc(eloPosMapSize*2* sizeof(Elo)); //Tamanho ficou pequeno para o final
    }

    gpuErrchk(cudaMemcpy(host_elos_vector_and_memory_pointer_elos,device_pointer_elo_vector,sizeof(EloVector)*eloPosMapSize,cudaMemcpyDeviceToHost));
    gpuErrchk(cudaMemcpy(&hostEloVectorSize,deviceEloVectorSize,sizeof(int),cudaMemcpyDeviceToHost));


    for(int i =0;i<eloPosMapSize;++i){
        gpuErrchk(cudaMemcpy(host_elos[i],host_elos_vector_and_memory_pointer_elos[i].eloArray,sizeof(Elo)*eloPosMapSize*2,cudaMemcpyDeviceToHost)); //Tamanho ficou pequeno para o final

    }

    printf("Total de Gerações de Frequência %d\n",hostEloVectorSize+1);
    for (int k = 0; k <=hostEloVectorSize; ++k) {
        for (int j = 0; j <host_elos_vector_and_memory_pointer_elos[k].size; ++j) {
            printf("%s;%d;%d \n",host_elos[k][j].ItemId,host_elos[k][j].indexArrayMap,host_elos[k][j].suporte);
        }
    }


    cudaFree(device_ArrayMap);
    cudaFree(deviceEloVectorSize);
    cudaFree(device_pointer_elo_vector);
    cudaFree(host_elos_vector_and_memory_pointer_elos->eloArray);
}
