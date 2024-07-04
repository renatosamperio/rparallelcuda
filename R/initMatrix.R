#' Initailised a matrix of 2D
#' @param debug `boolean` set to show messages
#' @param size `numeric` of array, default based on L2 Cache
initMatrix <- function(size, 
                        debug = FALSE) {

    A <- matrix(stats::runif(size*size), nrow=size, ncol=size)
    objSize <- format(utils::object.size(A), units = "auto")
    if(debug) message(paste0("Created a matrix with dimensions ", size, " x ",size," ... ", objSize))

    A
}