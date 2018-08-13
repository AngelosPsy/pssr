#' commit_change
#'
#' @description Function for commiting changes
#' @param repo_obj An initialized repository
#' @param message The message of commit
#' @return
#' This function returns no values.
#' @details Custom function for commiting changes in a directory
#' @export
commit_change <- function(repo_obj, message){
  if(methods::is(repo_obj) != "git_repository"){
    stop("This is not a git repository. Please create one if you
         want to commit changes")
  }
  # Based on that status of the repo you will commit
  # the changes or not
  stmp <- git2r::status(repo_obj)
  untracked <- unlist(stmp$untracked)
  unstaged <- unlist(stmp$unstaged)
  # Stop in case there is nothing to commit
  if(is.null(untracked) && is.null(unstaged)){
    stop("Nothing to commit.")
  }

  if(!is.null(untracked)){
    git2r::add(repo_obj, untracked)
  }

  if(!is.null(unstaged)){
   git2r::add(repo_obj, unstaged)
  }

  git2r::commit(repo = repo_obj, message = message)
}
