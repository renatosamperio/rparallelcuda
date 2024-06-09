#include "sum_matrixes_tbb_cuda.h"

extern "C"
void matrix_sum_cuda(
    const double* A, 
    const double* B, 
    const double* C, 
    double* result, int N, int block1, int block2) ;

Rcpp::NumericMatrix sum_matrixes_tbb_cuda(
    Rcpp::NumericMatrix A, 
    Rcpp::NumericMatrix B, 
    Rcpp::NumericMatrix C, int N, int block1, int block2) {

    int rows = N;
    int cols = N;
    Rcpp::NumericMatrix result(N, N);
    double *it_r = result.begin();

    if (A.nrow() != B.nrow() || 
        A.nrow() != C.nrow() || 
        A.ncol() != B.ncol() || 
        A.ncol() != C.ncol()) {
            Rcpp::Rcout << "All matrixes must have the same dimensions" << std::endl;
            return result;
    }

    // Define the range over which we will parallelize
    oneapi::tbb::blocked_range<size_t> range(0, rows);

    // Perform parallel matrix addition
    oneapi::tbb::parallel_for(range,
        [&](const blocked_range<size_t>& r) {

            for (size_t i = r.begin(); i < r.end(); ++i) {
                
                matrix_sum_cuda(
                    A.begin(), 
                    B.begin(), 
                    C.begin(),
                    it_r, N, block1, block2);

            }
        }
    );

    return result;
}