#include "sum_matrixes_tbb_graph.h"

Rcpp::NumericMatrix sum_matrixes_tbb_graph(
    Rcpp::NumericMatrix A, 
    Rcpp::NumericMatrix B, 
    Rcpp::NumericMatrix C, int N) {

    Rcpp::NumericMatrix result(N, N);

    if (A.nrow() != B.nrow() || 
        A.nrow() != C.nrow() || 
        A.ncol() != B.ncol() || 
        A.ncol() != C.ncol()) {
            Rcpp::Rcout << "All matrices must have the same dimensions" << std::endl;
            return result;
    }


    // std::vector<std::vector<float>> A_host = matrix_to_vectors(A);
    // std::vector<std::vector<float>> B_host = matrix_to_vectors(B);
    // std::vector<std::vector<float>> C_host = matrix_to_vectors(C);
    // std::vector<float> v_res = Rcpp::as< std::vector<float> >(result); 

    size_t available_cores = oneapi::tbb::info::default_concurrency();
    int chunk_size = N / available_cores;

    tbb::flow::graph g;
    broadcast_node<continue_msg> start(g);
    std::vector<
        tbb::flow::continue_node<
            tbb::flow::continue_msg>> nodes;

    for (int i = 0; i < available_cores; ++i) {
        nodes.emplace_back(g, [i, N, chunk_size, &A, &B, &C, &result]
          (const tbb::flow::continue_msg&) {
            for (int j = i * chunk_size; j < (i + 1) * chunk_size; ++j) {
                for (int k = 0; k < N; ++k) {
                    // v_res[j] = A_host[j][k] + B_host[j][k] + C_host[j][k];
                    result(i, j) = A(i, j) + B(i, j) + C(i, j);
                }
            }
        });
    }

    for (int i = 1; i < available_cores; ++i) {
        tbb::flow::make_edge(start, nodes[i]);
    }

    nodes[0].try_put(tbb::flow::continue_msg());
    g.wait_for_all();

    return result;
}