#' render_files
#'
#' @description This function is used to render output files for a list of selected
#' markdown ".Rmd" or ".md" files that are located in the same path/directory.
#' @param file_list vector with the names of the ".Rmd" files to render
#' @param location_path path where the target files are located
#' @param render_params list of parameters to be used
#' @param output_type defined format for all he ouptut files
#' @return
#' This function returns no values.
#' @details
#' The function creates a ".pdf" file for every input file that was added in the file_list
#' paramater.
#' @export
render_files<- function(file_list = NULL, location_path = NULL, render_params = NULL, output_type = ".pdf_document") {
  prevwd <- getwd()
  setwd(location_path)
  for(i in 1:length(file_list)){
    rmarkdown::render(file_list[i], params = render_params, output_format = "pdf_document")
  }
  setwd(prevwd)
}
