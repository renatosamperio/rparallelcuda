#ifndef SUM_TBB_GRAPH_H
#define SUM_TBB_GRAPH_H

#include "matrix_sum.h"

// #include <string>
#include <iostream>
// #include <vector>

#include <Rcpp.h> 
#include <unistd.h>

#include <oneapi/tbb.h>
#include <oneapi/tbb/flow_graph.h>

using namespace std;
using namespace oneapi::tbb;
using namespace oneapi::tbb::flow;


//' TBB parallelism function using a graph of nodes
//' @param A `vector` array of input numbers
//' @param B `vector` array of input numbers
//' @param C `vector` array of input numbers
//' @param N `numeric` of array, default based on L2 Cache
//' @export
// [[Rcpp::export]]
Rcpp::NumericMatrix sum_matrixes_tbb_graph(
    Rcpp::NumericMatrix A, 
    Rcpp::NumericMatrix B, 
    Rcpp::NumericMatrix C, int N);

#endif // SUM_TBB_GRAPH_H