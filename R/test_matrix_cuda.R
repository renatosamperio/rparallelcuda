#' Run parallel benchmark 
#' @param A `vector` array of numbers
#' @param B `vector` array of numbers
#' @param C `vector` array of numbers
#' @param times `numeric` how many times it shoud run
#' @param size `numeric` size of vector if not provided
#' @param debug `boolean` set to show messages
#' @param with_gc `boolean` set to include garbage collection
#' @param functor `function` call for CUDA kernel
#' @export
test_cuda_sum <- function(
    A = NULL,
    B = NULL,
    C = NULL,
    times = 1, 
    size = 496, 
    debug = FALSE,
    with_gc = FALSE, 
    functor = sumMatrixesTbbCuda) {

    message(paste0("Creating input data of ", size, " x ", size))
    if (is.null(A)) {
        A <- initMatrix(size, debug = debug)
    } else {
        size <- nrow(A)
    }
    if (is.null(B)) {
        B <- initMatrix(size, debug = debug)
    }
    if (is.null(C)) {
        C <- initMatrix(size, debug = debug)
    } 

    message(paste0("Benchmarking methods..."))
    res_benchmark <- microbenchmark::microbenchmark(
        functor(A, B, C, block1 = 65536, block2 = 65536),
        functor(A, B, C, block1 = 1024,  block2 = 1024),
        functor(A, B, C, block1 = 256,   block2 = 256),
        functor(A, B, C, block1 = 128,   block2 = 128),
        functor(A, B, C, block1 = 64,    block2 = 64),
        functor(A, B, C, block1 = 32,    block2 = 32),
        functor(A, B, C, block1 = 16,    block2 = 16),
        functor(A, B, C, block1 = 4,     block2 = 4),
        functor(A, B, C, block1 = 65536, block2 = 4),
        functor(A, B, C, block1 = 1024,  block2 = 4),
        times = times)

    sum_bench <- summary(res_benchmark)
    sum_bench <- sum_bench[order(sum_bench$mean),]

    # print(res_benchmark)

    print(sum_bench[c('expr', 'mean')])

}

