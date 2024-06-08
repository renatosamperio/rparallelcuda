#include "matrix_sum.h"

std::vector<std::vector<float>> matrix_to_vectors(Rcpp::NumericMatrix mat) {
  std::vector<std::vector<float>> vecs(mat.ncol());
  
  for (int j = 0; j < mat.ncol(); ++j) {
    Rcpp::NumericVector v_row = mat(_, j);
    vecs[j] = Rcpp::as<std::vector<float>>(v_row);
  }
  
  return vecs;
}

Rcpp::NumericMatrix vectors_to_matrix(std::vector<std::vector<float>> vecs) {
  int rows = vecs[0].size();
  int cols = vecs.size();
  
  Rcpp::NumericMatrix mat(rows, cols);
  
  for (int j = 0; j < cols; ++j) {
    std::vector<float> v_row = vecs[j];
    Rcpp::NumericVector rcpp_row = Rcpp::wrap(v_row);
    mat(_, j) = rcpp_row;
  }
  
  return mat;
}