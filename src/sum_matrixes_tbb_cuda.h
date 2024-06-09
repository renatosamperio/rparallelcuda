#ifndef SUM_TBB_CUDA_H
#define SUM_TBB_CUDA_H

#include "matrix_sum.h"

#include <string>
#include <iostream>
#include <vector>

#include <Rcpp.h> 
#include <unistd.h>

#include <oneapi/tbb/parallel_for.h>
#include <oneapi/tbb/flow_graph.h>
#include <oneapi/tbb.h>

using namespace std;
using namespace oneapi::tbb;

//' Function to sum matrixes using TBB and CUDA
//' @param A `matrix` array of input numbers
//' @param B `matrix` array of input numbers
//' @param C `matrix` array of input numbers
//' @param N `numeric` of array, default based on L2 Cache
//' @param block1 `numeric` size of block 1
//' @param block2 `numeric` size of block 2
//' @export
// [[Rcpp::export]]
Rcpp::NumericMatrix sum_matrixes_tbb_cuda(
    Rcpp::NumericMatrix A, 
    Rcpp::NumericMatrix B, 
    Rcpp::NumericMatrix C, int N, int block1 = 16, int block2 = 16);

#endif // SUM_TBB_CUDA_H
