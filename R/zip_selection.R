#' zip_selection
#'
#' @description Make a zip file with a selection of the default subfolders: analyses, data, manuscript, material, plots and preregistration
#' @param dir_path A character path with the project directory.
#' @param sel_folders A logic (TRUE or FALSE) vector inidcating which subfolders would be zipped (in the order that are created: analyses, data, manuscript, material, plots and preregistration).
#' @param password password to be used. Password is optional, if not entered then no password is used
#' @param git_include logical value that indicates if Git folder should be on the backup
#' @return
#' This function returns no values.
#' @export
zip_selection <- function(dir_path, sel_folders, password = NULL, git_include=FALSE) {

  # Create list of available files
  sel_files <- list.files(dir_path, all.files = TRUE, include.dirs = TRUE,
                        recursive = TRUE)
  subfolder_set <- c("analyses", "data","manuscript", "material", "plots",
                     "preregistration", ".git")

  new_selFolders <- sel_folders
  if(git_include == TRUE){
    new_selFolders <- c(sel_folders, TRUE)
  } else {
    new_selFolders <- c(sel_folders, FALSE)
  }

  # Subsetting subfolder to be added
  folder_names <- subfolder_set[new_selFolders]
  filteredFiles <- sel_files[grepl(paste(folder_names, collapse = "|"), sel_files)]
  file_time <- format(Sys.time(), "%Y-%m-%d_%H%M")

  if(!is.null(password)){
    dest_name <- paste("Encrypted_file_", file_time, sep="")
    utils::zip(dest_name, files= filteredFiles, flags = paste("--password", password))
  }
  else{
    dest_name <- paste("data/Backup_file_", file_time, sep="")
    utils::zip(dest_name, files= filteredFiles)
  }

}
