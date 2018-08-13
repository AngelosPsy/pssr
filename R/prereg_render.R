#' prereg_render
#'
#' @description Function for rendering the preregistration document
#' @param file_name The name of the preregistration document. Default name is \code{preregistration}.
#' @details
#' The function will render the \code{.Rmd} file with the name defined by the \code{file_name} argument. In case
#' no such name is given, it will render the \code{.Rmd} located in the preregistration directory. In case no such files
#' is present, or multiple preregistration documents are in the preregisrtation directory, it will
#' generate a warning
#' @export
prereg_render <- function(file_name = NULL){
  # Find files with the .Rmd extension. Generate warnings is case more or less than 1 files were detected.
  if(is.null(file_name)){
    tmp <- list.files(pattern = ".Rmd")
    if(length(tmp) > 1){
      warning(paste(c("The following files were detected: ", paste(tmp, collate = " "), "\nThe program can render only 1 file at a time. Please select the file you want to open.")), collapse = "\t")
    } else if (length(tmp) == 0){
      warning("No preregistration document was found. Please create one.")
    } else {
      rmarkdown::render(normalizePath(tmp))
      file_name_rm_ext <- stringr::str_sub(tmp, 1, -5)
      system(paste('open', normalizePath(paste0(file_name_rm_ext, ".pdf"))))
    }
  } else{
    # Put extension in the Rmd file, render it, and then open the pdf
    file_name_Rmd <- paste0(file_name, ".Rmd")
    file_name_pdf <- paste0(file_name, ".pdf")
    rmarkdown::render(normalizePath(file_name_Rmd))
    system(paste('open', normalizePath(file_name_pdf)))
  }
}
