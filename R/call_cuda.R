#' Estimates time used to call CUDA example
#' @param `size` length of squared matrix
call_cuda <- \(size) {
  A <- initMatrix(size)
  B <- initMatrix(size)
  C <- initMatrix(size)
  message(paste0("Using matrixes with ", format(object.size(A)*3, units = "auto")))
  tictoc::tic("Executed CUDA program")
  r <- sumMatrixesCuda(A = A, B = B, C = C, size = size)
  tictoc::toc()
  out <- gc()
}