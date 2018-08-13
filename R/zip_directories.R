#' zip_directories
#'
#' @description Make a zip file with all directories
#' @param dir_names A character vector with all the directories to be zipped.
#' @param password password to be used.
#' @return
#' This function returns no values.
#' @export
zip_dir <- function(dir_names, password = NULL) {
  # Create zip file name
  zip_name = paste0("zip_file_", Sys.time(), ".zip")

  # Generate a zipfile with or without a password
  if (is.null(password)){
    utils::zip(zipfile = zip_name, file = dir_names)
  } else{
    utils::zip(zipfile = zip_name, file = dir_names,
               flags = paste("--password", password))
  }
}
