#' config_repo
#'
#' @description Configure repository
#' @param repo_obj An initialized repository
#' @param user_name The user's name
#' @param user_email The user's email
#' @return
#' This function returns no values.
#' @export
config_repo <- function(repo_obj, user_name = NULL, user_email = NULL) {
    repo <- git2r::config(repo = repo_obj, global = FALSE, user.name = user_name, user.email = user_email)
  return(repo)
}
