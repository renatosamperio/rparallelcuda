# Sys.setenv(MKL_CBWR = "AVX2,STRICT")
# Sys.setenv(MKL_CBWR = "COMPATIBLE")
# Sys.setenv(MKL_NUM_THREADS = "4")
# options(digits=20)

if (FALSE) {
    message(paste0("MKL_CBWR: ", Sys.getenv("MKL_CBWR")))
}

.rotate <-\(out_vector,
            func, 
            A = NULL,
            B = NULL,
            C = NULL) {

    c(out_vector, func(A, B, C))
}

.stats <- \(input) {
    list(
        data = sort(input),
        avg = mean(input),
        stdev = stats::sd(input),
        max = max(input),
        min = min(input),
        range = max(input) - min(input)
    )
}

#' Run parallel benchmark 
#' @param A `vector` array of numbers
#' @param B `vector` array of numbers
#' @param C `vector` array of numbers
#' @param times `numeric` how many times it shoud run
#' @param size `numeric` size of vector if not provided
#' @param debug `boolean` set to show messages
#' @export
test_parallel_sum <- function(
    A = NULL,
    B = NULL,
    C = NULL,
    times = 1, 
    size = 496, 
    debug = FALSE) {

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

    callTbbGraph <- \() {r1 <- sumMatrixesTbbGraph(A, B, C)}
    callTbbParalleFor <- \() {r1 <- sumMatrixesTbbGraph(A, B, C)}
    callRcppParallel <- \() {r1 <- sumMatrixesRcpp(A, B, C)}

    message(paste0("Benchmarking methods..."))
    res_benchmark <- microbenchmark::microbenchmark(
        callTbbGraph(), 
        callTbbParalleFor(),
        callRcppParallel(),
        times = times)

    sum_bench <- summary(res_benchmark)
    sum_bench <- sum_bench[order(sum_bench$mean),]

    sum_bench[c('expr', 'mean')]

}

