#ifndef MATRIX_SUM_H
#define MATRIX_SUM_H

#include <iostream>
#include <vector>
#include <Rcpp.h> 

using namespace Rcpp;

// converts Rcpp matrixes into std vectors
std::vector<std::vector<double>> matrix_to_vectors(Rcpp::NumericMatrix mat);

// converts std vectors into Rcpp matrixes
Rcpp::NumericMatrix vectors_to_matrix(std::vector<std::vector<double>> vecs);

#endif // MATRIX_SUM_H
