//
// Created by rafael on 20/08/18.
//

#include <cudaHeaders.h>
#include <cuda_runtime_api.h>
#include <cstdio>
#include "kernel_pfp.h"


__device__ void addNew (int *a, int *b, int *c,int size) {
    int tid = blockIdx.x;
    if (tid < size) c[tid] = a[tid] + b[tid];
}
__global__ void add( int *a, int *b, int *c,int size) {
    addNew(a,b,c,size);

}
    void run(int i)
    {
        int N =i;
        int a[N], b[N], c[N];
        int *dev_a, *dev_b, *dev_c ,*size;
        // allocate the memory on the GPU
          cudaMalloc( (void**)&dev_a, N * sizeof(int) ) ;
          cudaMalloc( (void**)&dev_b, N * sizeof(int) ) ;
          cudaMalloc( (void**)&dev_c, N * sizeof(int) ) ;
          cudaMalloc( (void**)&size, sizeof(int) ) ;
         // fill the arrays 'a' and 'b' on the CPU
         for (int i=0; i<N; i++) {
             a[i] = -i;
             b[i] = i * i;
         }
        cudaMemcpy( dev_a, a, N * sizeof(int), cudaMemcpyHostToDevice );
        cudaMemcpy( dev_b, b, N * sizeof(int),cudaMemcpyHostToDevice );
        add<<<N,1>>>( dev_a, dev_b, dev_c ,1);
        cudaMemcpy( c, dev_c, N * sizeof(int),cudaMemcpyDeviceToHost );
        for (int i=0; i<N; i++) {
            printf( "%d + %d = %d\n", a[i], b[i], c[i] );
        }
        cudaFree( dev_a );    cudaFree( dev_b );    cudaFree( dev_c );
    }


