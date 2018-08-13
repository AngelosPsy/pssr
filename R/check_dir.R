#' check_dir
#'
#' @description Function for checking whether a directory exists.
#' @param proj_name name of the project
#' @details Function of checking whether a directory exists. If it does, the funtion will generate a warning.
#' Alternatively, the function will create a new directory named after the \code{proj_name} argument.
#'
#' @export
check_dir <- function(proj_name = "project") {
  if(!dir.exists(proj_name)){
    dir.create(proj_name)
  } else{
    warning(paste("The directory named", proj_name, "exists already."))
  }
}
