#' Runs CUDA kernel
#' @param size `numeric` size of arrays
#' @param debug `bool` show debug messages
run_cuda <- \(size = 500, debug = FALSE) {

    A <- initMatrix(size, debug = debug)
    B <- initMatrix(size, debug = debug)
    C <- initMatrix(size, debug = debug)

    sum_matrixes_cuda(A, B, C, s, 16, 16)
    sumMatrixesCuda(A = A, B = B, C = C, size = size)

    # test execution
    devtools::load_all()
    size <- 6000; A <- initMatrix(size); B <- initMatrix(size); C <- initMatrix(size);
    r <- sumMatrixesCuda(A = A, B = B, C = C, size = size)

    test_parallel_sum(A=A, B=B, C=C, size, times = 10)
}
