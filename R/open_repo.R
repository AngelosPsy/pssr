#' open_repo
#'
#' @description Open repository
#' @param repo_obj An initialized repository
#' @return
#' Summary of the repository.
#' @details Open repository.
#' @export
open_repo <- function(repo_obj) {
  if(git2r::is_empty(repo_obj)){
    repo <- git2r::repository(normalizePath(getwd()))
  } else{
    stop(paste0("There is no git repository to open."))
  }
  return(summary(repo))
}
