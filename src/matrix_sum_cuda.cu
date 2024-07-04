#include <cuda_runtime.h>
#include <iostream>
#include <Rcpp.h>

#define CUDA_CHECK(call) \
    do { \
        cudaError_t err = call; \
        if (err != cudaSuccess) { \
            Rcpp::Rcout << "CUDA error in " << __FILE__ << " at line " << __LINE__ << ": " << cudaGetErrorString(err) << std::endl; \
            Rcpp::stop("Exiting..."); \
        } \
    } while (0)

__global__ void matrix_sum_kernel(const double* A, const double* B, const double* C, double* result, int N) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    int idy = blockIdx.y * blockDim.y + threadIdx.y;

    // printf("  Executing kernel on (%d, %d)", idx, idy);
    if (idx < N && idy < N) {
        int index = idy * N + idx;
        result[index] = A[index] + B[index] + C[index];
    }
}

extern "C"
void matrix_sum_cuda(
    const double* A, 
    const double* B, 
    const double* C, 
    double* result, int N, int block1, int block2) {

    double *d_A, *d_B, *d_C, *d_result;
    size_t size = N * N * sizeof(double);

    CUDA_CHECK(cudaMalloc(&d_A, size));
    CUDA_CHECK(cudaMalloc(&d_B, size));
    CUDA_CHECK(cudaMalloc(&d_C, size));
    CUDA_CHECK(cudaMalloc(&d_result, size));

    CUDA_CHECK(cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_C, C, size, cudaMemcpyHostToDevice));

    dim3 threadsPerBlock(block1, block2);
    dim3 numBlocks((N + threadsPerBlock.x - 1) / threadsPerBlock.x, (N + threadsPerBlock.y - 1) / threadsPerBlock.y);

    matrix_sum_kernel<<<numBlocks, threadsPerBlock>>>(d_A, d_B, d_C, d_result, N);
    CUDA_CHECK(cudaMemcpy(result, d_result, size, cudaMemcpyDeviceToHost));

    CUDA_CHECK(cudaFree(d_A));
    CUDA_CHECK(cudaFree(d_B));
    CUDA_CHECK(cudaFree(d_C));
    CUDA_CHECK(cudaFree(d_result));
}


__global__ void matrixSumKernel(double* A, double* B, double* C, double* D, int rows, int cols) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    int idy = blockIdx.y * blockDim.y + threadIdx.y;
    
    if (idx < cols && idy < rows) {
        int index = idy * cols + idx;
        D[index] = A[index] + B[index] + C[index];
    }
}
