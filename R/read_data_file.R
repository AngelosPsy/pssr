#' read_data_file
#'
#' @description Function for reading data file
#' @param file_name the name of the file, including the corresponding extension
#' @param header whether the data have a header. Default is set to TRUE
#' @param sep the seperation argument for the columns. Default is \code{"\t"}
#' @param quote the quote argument. Default is \code{"\'"}
#' @return
#' This function returns no values.
#' @export
read_data_file <- function(file_name = NULL, header = TRUE, sep = "\t", quote = "\'") {
  # Read data file based on extension
  if(is.null(file_name)){
    warning("No file was selected.")
  } else {
    # Read data files. A data file has to be selected
    ext <- tools::file_ext(file_name)
    if(ext == "txt"){
      datz <- utils::read.table(file_name, header = header,
                                sep = sep, quote = quote)
    } else if(ext == "csv"){
      datz <- utils::read.csv2(file_name, header = header,
                              sep = sep, quote = quote)
    } else if(ext == "sav"){
      datz <- foreign::read.spss(file = file_name,
                                 to.data.frame = TRUE)
    }
  }
}
