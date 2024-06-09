#include "sum_matrixes_cuda.h"

extern "C"
void matrix_sum_cuda(
    const double* A, 
    const double* B, 
    const double* C, 
    double* result, int N, int block1, int block2) ;

Rcpp::NumericMatrix sum_matrixes_cuda(
    Rcpp::NumericMatrix A, 
    Rcpp::NumericMatrix B, 
    Rcpp::NumericMatrix C, int N, int block1, int block2) {

    Rcpp::NumericMatrix result(N, N);

    if (A.nrow() != B.nrow() || 
        A.nrow() != C.nrow() || 
        A.ncol() != B.ncol() || 
        A.ncol() != C.ncol()) {
            Rcpp::Rcout << "All matrixes must have the same dimensions" << std::endl;
            return result;
    }

    // Rcpp::NumericMatrix::Row r = A.row(0);
    double *it_r = result.begin();

    // Call the CUDA function
    matrix_sum_cuda(
        A.begin(), 
        B.begin(), 
        C.begin(),
        it_r, N, block1, block2);

    return result;
}