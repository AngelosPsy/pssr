#' make_project
#'
#' @description This function is used for creating a new project.
#' @param proj_name name of the project
#' @param add_dir character vector of additional directories expect the
#' default ones (see below). Default is set to NULL
#' @return
#' This function returns no values.
#' @details
#' The function creates a directory named after the \code{proj.name}
#' object. Inside this directory, the following subdirectories are
#' created by default: \code{preregistration}, \code{data},
#' \code{analyses}, \code{plots}, \code{manuscript}. Additional
#' directories could be defined using the \code{add.dir} argument.
#' @export
make_project <- function(proj_name = "project", add_dir = NULL) {
  check_dir(proj_name)
  proj_subs = paste(proj_name, c("preregistration", "preregistration/backuptext", "data", "analyses", "manuscript", "material", add_dir), sep = "/")
  invisible(lapply(proj_subs, dir.create))
}
