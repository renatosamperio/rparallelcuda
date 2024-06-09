#' Executes a summation with TBB and CUDA
#' @param A `vector` array of numbers
#' @param B `vector` array of numbers
#' @param C `vector` array of numbers
#' @param size `numeric` of array, default based on L2 Cache
#' @param debug `boolean` set to show messages
#' @param block1 `numeric` size of block 1
#' @param block2 `numeric` size of block 2
sumMatrixesCuda <- \(A = NULL,
                        B = NULL,
                        C = NULL,
                        size = 496, 
                        debug = FALSE,
                        block1 = 16, block2 = 16) {

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

    if(debug) message(paste0("Running summation with TBB graph-based threads for ", size))
    sum_matrixes_cuda(A, B, C, size, block1, block2)
}