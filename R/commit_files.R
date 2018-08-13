#' commit_files
#'
#' @description Commit files
#' @param repo_obj An initialized repository
#' @param file_list A list of the files to be commited
#' @param message The message of commit
#' @return
#' This function returns no values.
#' @details Short function for commiting changes in the directories of a project.
#' @export
commit_files <- function(repo_obj, file_list,  message){
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
  if(is.null(file_list)){
    stop("Nothing to commit.")
  }

  commit_num<-length(git2r::commits(repo_obj))+1
  commit_message<-paste(paste("Commit #", commit_num), message, sep=": ")
  git2r::add(repo_obj,file_list)
  git2r::commit(repo_obj,message = commit_message)

}
