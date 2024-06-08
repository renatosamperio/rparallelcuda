#' Initailised a matrix of 2D
#' @param debug `boolean` set to show messages
#' @param size `numeric` of array, default based on L2 Cache
initMatrix <- function(size, 
                        debug = FALSE) {

    A <- matrix(, nrow = size, ncol = size)
    for(column in 1:size){A[, column] <- stats::runif(size)}
    objSize <- format(object.size(A), units = "auto")
    if(debug) message(paste0("Created A matrix of ", size, " x ",size," ... ", objSize))

    A
}