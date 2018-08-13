#' init_repo
#'
#' @description Initialize repository
#' @param repo_path the path of the repository. If none given, the current directory used as paht.
#' @details
#' Wrapper function for initializing a repository.
#' @export
init_repo <- function(repo_path = getwd()) {
    repo <- git2r::init(normalizePath(repo_path))
  return(repo)
}
