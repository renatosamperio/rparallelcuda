#' Run parallel benchmark 
#' @param A `vector` array of numbers
#' @param B `vector` array of numbers
#' @param C `vector` array of numbers
#' @param times `numeric` how many times it shoud run
#' @param size `numeric` size of vector if not provided
#' @param debug `boolean` set to show messages
#' @param with_gc `boolean` set to include garbage collection
#' @param block1 `numeric` size of block 1
#' @param block2 `numeric` size of block 2
#' @export
test_parallel_sum <- function(
    A = NULL,
    B = NULL,
    C = NULL,
    times = 1, 
    size = 496, 
    debug = FALSE,
    with_gc = FALSE, 
    block1 = 16, block2 = 16) {

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

    callTbbGraph <- \(cleaner = FALSE) {
        r <- sumMatrixesTbbGraph(A, B, C); 
        if(cleaner) {
            r<-NULL
            gc()
        }}
    callRcppParallel <- \(cleaner = FALSE) {
        r <- sumMatrixesRcpp(A, B, C); 
        if(cleaner) {
            r<-NULL
            gc()
        }}
    callTbbParalleFor <- \(cleaner = FALSE) {
        r <- sumMatrixesTbbParallel(A, B, C);
        if(cleaner) {
            r<-NULL
            gc()
        }}
    callTbbCuda <- \(cleaner = FALSE) {
        r <- sumMatrixesTbbCuda(A, B, C); 
        if(cleaner) {
            r<-NULL
            gc()
        }}
    callCuda <- \(cleaner = FALSE) {
        r <- sumMatrixesCuda(A, B, C); 
        if(cleaner) {
            r<-NULL
            gc()
        }}

    message(paste0("Benchmarking methods..."))
    res_benchmark <- microbenchmark::microbenchmark(
        r<-callTbbGraph(with_gc),
        r<-callRcppParallel(with_gc),
        r<-callTbbParalleFor(with_gc),
        #r<-callTbbCuda(with_gc),
        r<-callCuda(with_gc),
        times = times)

    sum_bench <- summary(res_benchmark)
    sum_bench <- sum_bench[order(sum_bench$mean),]

    # print(res_benchmark)
    message(paste0("Saving benchmark into file"))
    # print(res_benchmark)

    sum_bench <- sum_bench[c('expr', 'mean', 'min', 'max')]
    print(sum_bench)

    # res_benchmark
    sum_bench
}

