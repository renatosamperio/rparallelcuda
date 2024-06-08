#include "oneapi/tbb/parallel_reduce.h"
#include "oneapi/tbb/blocked_range.h"
#include <random>
#include <iostream>
#include <Rcpp.h>

#include <unistd.h>

using namespace oneapi::tbb;

// [[Rcpp::export]]
double sum_matrixes_tbb_reduce(
    Rcpp::NumericMatrix A, 
    Rcpp::NumericMatrix B, 
    Rcpp::NumericMatrix C, 
    Rcpp::NumericVector result, int N);