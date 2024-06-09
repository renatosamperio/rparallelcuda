#include <Rcpp.h>
#include <RcppParallel.h>

using namespace Rcpp;
using namespace RcppParallel;

struct MatrixSum : public Worker {
    
    // Input matrixes
    const Rcpp::NumericMatrix A;
    const Rcpp::NumericMatrix B;
    const Rcpp::NumericMatrix C;
    
    // Output matrix
    NumericMatrix result;

    // Constructor
    MatrixSum(const Rcpp::NumericMatrix A, 
              const Rcpp::NumericMatrix B, 
              const Rcpp::NumericMatrix C, 
              Rcpp::NumericMatrix result)
        : A(A), B(B), C(C), result(result) 
    {}
    
    // Overload () operator to perform the matrix sum in parallel
    void operator()(std::size_t begin, std::size_t end) {
        for (std::size_t i = begin; i < end; i++) {
            for (std::size_t j = 0; j < result.ncol(); j++) {
                result(i, j) = A(i, j) + B(i, j) + C(i, j);
            }
        }
    }
};


//' Executes a distributed paralellel sum with RcpParallel
//' @param A `vector` array of input numbers
//' @param B `vector` array of input numbers
//' @param C `vector` array of input numbers
//' @param N `numeric` of array, default based on L2 Cache
//' @export
// [[Rcpp::export]]
Rcpp::NumericMatrix sum_matrixes_rcpp(
    Rcpp::NumericMatrix A,
    Rcpp::NumericMatrix B, 
    Rcpp::NumericMatrix C, int N);