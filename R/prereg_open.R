#' prereg_open
#'
#' @description Function opening the preregistration document
#' @param file_name The name of the preregistration document. Default name is \code{preregistration}.
#' @details
#' The function will open the \code{.Rmd} file with the name defined by the \code{file_name} argument. In case
#' no such name is given, it will open the \code{.Rmd} file located in the preregistration directory.
#' In case no such files are present, or multiple preregistration documents are in the preregisrtation directory,
#' it will generate a warning
#' @export
prereg_open <- function(file_name = NULL){
  # Find files with the .Rmd extension. Generate warnings is case more or less than 1 files were detected.
  if(is.null(file_name)){
    tmp <- list.files(pattern = ".Rmd")
    if(length(tmp) > 1){
      warning(paste(c("The following files were detected: ", paste(tmp, collate = " "),
                      "\nThe program can open only 1 file at a time. Please select the file you want to open.")),
              collapse = "\t")
    } else if (length(tmp) == 0){
      warning("No preregistration document was found. Please create one.")
    } else {
      utils::file.edit(normalizePath(tmp))
    }
  } else{
    # Put extension in the file and template name and open it.
    #file_name <- paste0(file_name, ".Rmd")
    utils::file.edit(normalizePath(file_name))
  }
}
