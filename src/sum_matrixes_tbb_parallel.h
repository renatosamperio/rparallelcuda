#ifndef SUM_TBB_PARALLEL_H
#define SUM_TBB_PARALLEL_H

#include "matrix_sum.h"

#include <iostream>
#include <Rcpp.h> 
#include <unistd.h>
#include <oneapi/tbb.h>

using namespace std;
using namespace oneapi::tbb;

//' TBB using parallel for
//' @param A `vector` array of input numbers
//' @param B `vector` array of input numbers
//' @param C `vector` array of input numbers
//' @param N `numeric` of array, default based on L2 Cache
//' @export
// [[Rcpp::export]]
Rcpp::NumericMatrix sum_matrixes_tbb_parallel(
    Rcpp::NumericMatrix A, 
    Rcpp::NumericMatrix B, 
    Rcpp::NumericMatrix C, int N);

#endif // SUM_TBB_PARALLEL_H