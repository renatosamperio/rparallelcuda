#' Executes a summation with TBB and CUDA
#' @param A `vector` array of numbers
#' @param B `vector` array of numbers
#' @param C `vector` array of numbers
#' @param size `numeric` of array, default based on L2 Cache
#' @param debug `boolean` set to show messages
sumMatrixesTbbCuda <- \(A = NULL,
                        B = NULL,
                        C = NULL,
                        size = 496, 
                        debug = FALSE) {

    if (is.null(A)) {
        if(debug) message(paste0("Creating A vector of ", size, " ..."))
        A <- stats::runif(size)
    }
    if (is.null(B)) {
        if(debug) message(paste0("Creating B vector of ", size, " ..."))
        B <- stats::runif(size)
    }
    if (is.null(C)) {
        if(debug) message(paste0("Creating C vector of ", size, " ..."))
        C <- stats::runif(size)
    }
    result <- replicate(size, 0)

    if(debug) message(paste0("Running summation with TBB threads and CUDA"))
    # sum_matrixes_tbb_cuda(A, B, C, result, size)
}