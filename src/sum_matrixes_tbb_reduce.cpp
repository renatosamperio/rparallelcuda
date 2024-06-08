#include "sum_matrixes_tbb_reduce.h"

double sum_matrixes_tbb_reduce(
        Rcpp::NumericMatrix A, 
        Rcpp::NumericMatrix B, 
        Rcpp::NumericMatrix C, 
        Rcpp::NumericVector result, int N) {
/*

    // converting to flat vectors
    std::vector<std::vector<float>> A_host = matrix_to_vectors(A);
    std::vector<std::vector<float>> B_host = matrix_to_vectors(B);
    std::vector<std::vector<float>> C_host = matrix_to_vectors(C);
    std::vector<float> v_res = Rcpp::as< std::vector<float> >(result);

    // Using parallel_deterministic_reduce
    int num_elements = A_host.size();
    int chunk_size = (num_elements + num_cores - 1) / num_cores;

    oneapi::tbb::parallel_deterministic_reduce(
        oneapi::tbb::blocked_range<size_t>(0, numbers.size(), chunk_size),
        0.0, // Initial value for the sum
        [&numbers](const oneapi::tbb::blocked_range<size_t>& r, double init) -> double {
            double local_sum = init;
            // Rcpp::Rcout << "(" << std::this_thread::get_id() << " - " << r.begin() << " : " << r.end() << ")" << std::endl;

            for (size_t i = r.begin(); i != r.end(); ++i) {
                local_sum += numbers[i];
            }

            // std::cout << "(" << std::this_thread::get_id() << "," << gettid() << " - " << r.begin() << " : " << r.end() << ")" << std::endl;
            return local_sum;
        },
        [](double x, double y) -> double {
            return x + y;
        }
    );

    return sum;
*/
    return 0.0;
}
