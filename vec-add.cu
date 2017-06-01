#include <stdio.h>
#include <stdlib.h>

// Device code
__global__ void VecAdd(float* A, float* B, float* C, int N)
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  if (i < N)
    C[i] = A[i] + B[i];
}
  
float *initarray(float *a, int N, float value) {
  int i;

  for (i=0; i<N; i++)
      a[i] = drand48()*value;

  return a;
}

void printarray(float *a, int N) {
  int i;

  for (i=0; i<N; i++) {
      printf("%f ", a[i]);
    printf("\n");
  }
}
          
// Host code
int main(int argc, char **argv)
{
  int N = atoi(argv[1]);
  size_t size = N * sizeof(float);

  // Allocate input vectors h_A and h_B in host memory
  float* h_A = (float*)malloc(size);
  float* h_B = (float*)malloc(size);
  float* h_C = (float*)malloc(size);
  
  // Initialize input vectors
  initarray(h_A, N, 10);
  initarray(h_B, N, 10);

  printarray(h_A, N);
  printarray(h_B, N);

  // Allocate vectors in device memory
  float* d_A;
  cudaMalloc(&d_A, size);
  float* d_B;
  cudaMalloc(&d_B, size);
  float* d_C;
  cudaMalloc(&d_C, size);

  // Copy vectors from host memory to device memory
  cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);

  // Invoke kernel
  int threadsPerBlock = 256;
  int blocksPerGrid =
    (N + threadsPerBlock - 1) / threadsPerBlock;
  VecAdd<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, N);

  // Copy result from device memory to host memory
  // h_C contains the result in host memory
  cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);

  // print result
  printarray(h_C, N);

  // Free device memory
  cudaFree(d_A);
  cudaFree(d_B);
  cudaFree(d_C);
            
  // Free host memory
  free(h_A);
  free(h_B);
  free(h_C);
}
