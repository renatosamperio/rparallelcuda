#' Executes a summation with TBB and CUDA
#' @param A `vector` array of numbers
#' @param B `vector` array of numbers
#' @param C `vector` array of numbers
#' @param size `numeric` of array, default based on L2 Cache
#' @param debug `boolean` set to show messages
sumMatrixesTbbParallel <- \(A = NULL,
                        B = NULL,
                        C = NULL,
                        size = 496, 
                        debug = FALSE) {

    format(object.size(library), units = "auto")
    if (is.null(A)) {
        A <- initMatrix(size, debug = debug)
    }
    else if (is.null(B)) {
        B <- initMatrix(size, debug = debug)
    }
    else if (is.null(C)) {
        C <- initMatrix(size, debug = debug)
    } else {
        size <- nrow(A)
    }

    if(debug) message(paste0("Running summation with TBB parallel_for threads for ", size))
    sum_matrixes_tbb_parallel(A, B, C, size)
}