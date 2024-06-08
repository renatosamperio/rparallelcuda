#' Done be called from bash
run <- \() {

    size <- 496
    A <- matrix(, nrow = size, ncol = size)
    for(column in 1:size){A[, column] <- stats::runif(size)}
    B <- matrix(, nrow = size, ncol = size)
    for(column in 1:size){B[, column] <- stats::runif(size)}
    C <- matrix(, nrow = size, ncol = size)
    for(column in 1:size){C[, column] <- stats::runif(size)}
    # result <- replicate(size, 0)

    message(paste0("Summing matrixes with TBB graph-based"))
    # sum_matrixes_tbb_graph(A, B, C, result, size)
    sumMatrixesTbbGraph(A = A, B = B, C = C, size = size)

    message(paste0("Summing matrixes with TBB parallel_for"))
    # sum_matrixes_tbb_parallel(A, B, C, result, size)
    sumMatrixesTbbParallel(A = A, B = B, C = C, size = size)

}