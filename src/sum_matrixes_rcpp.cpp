#ifndef RCPP_PAR_H
#define RCPP_PAR_H

#include "sum_matrixes_rcpp.h"

Rcpp::NumericMatrix sum_matrixes_rcpp(
     Rcpp::NumericMatrix A,
     Rcpp::NumericMatrix B, 
     Rcpp::NumericMatrix C, int N) {
    // Check if dimensions match
    if (A.nrow() != B.nrow() || A.nrow() != C.nrow() || 
        A.ncol() != B.ncol() || A.ncol() != C.ncol()) {
        stop("Matrices are not the same size.");
    }

    // Output matrix
    Rcpp::NumericMatrix result(A.nrow(), A.ncol());
    
    // Create the worker
    MatrixSum matrixSum(A, B, C, result);
    
    // Perform parallel computation
    RcppParallel::parallelFor(0, A.nrow(), matrixSum);
    
    return result;
}

#endif // RCPP_PAR_H