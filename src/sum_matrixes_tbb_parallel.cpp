#include "sum_matrixes_tbb_parallel.h"

// Parallel matrix addition task
class MatrixAdd {
    const Rcpp::NumericMatrix& A;
    const Rcpp::NumericMatrix& B;
    const Rcpp::NumericMatrix& C;
    Rcpp::NumericMatrix& result;
    int N;

public:
    void operator()( const oneapi::tbb::blocked_range<size_t>& range ) const {

        for (size_t i = range.begin(); i != range.end(); ++i) {
            for (size_t j = 0; j < N; ++j) {
                result(i, j) = A(i, j) + B(i, j) + C(i, j);
            }
        }
    }

    MatrixAdd(const Rcpp::NumericMatrix& A, 
             const Rcpp::NumericMatrix& B, 
             const Rcpp::NumericMatrix& C, 
             Rcpp::NumericMatrix& result, int N)
        : A(A), B(B), C(C), result(result), N(N) 
    {}
};

Rcpp::NumericMatrix sum_matrixes_tbb_parallel(
    Rcpp::NumericMatrix A, 
    Rcpp::NumericMatrix B, 
    Rcpp::NumericMatrix C, int N) {

    Rcpp::NumericMatrix result(N, N);

    if (A.nrow() != B.nrow() || 
        A.nrow() != C.nrow() || 
        A.ncol() != B.ncol() || 
        A.ncol() != C.ncol()) {
            Rcpp::Rcout << "All matrixes must have the same dimensions" << std::endl;
            return result;
    }

    int num_cores = std::thread::hardware_concurrency();
    int chunk_size = (N + num_cores - 1) / num_cores;

    // Define the range over which we will parallelize
    oneapi::tbb::blocked_range<size_t> range(0, N);

    // Perform parallel matrix addition
    MatrixAdd worker(A, B, C, result, N);
    oneapi::tbb::parallel_for(range, worker);

    return result;
}

