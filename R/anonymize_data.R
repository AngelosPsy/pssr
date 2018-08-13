#' anonymize_data
#'
#' @description Function for anonymizing tabular data
#' @param data A data frame containing the data
#' @param col_names A character vector with the names of the columns to be anonymized
#' @param algo The algorithm to be used in case the data are going to be hashed. Default is "random". See details for options
#' @param save Whether a new file with the anonymized data should be saved. Default is \code{FALSE}
#' @details
#' The function will take the selected columns and fill them in with either random numbers or one of the encryption algorithms.
#' Specifally, the different options for the \code{algo} argument are: \code{random}, \code{md5}, \code{sha1},
#' \code{crc32}, \code{sha256}, \code{sha512}, \code{xxhash32}, \code{xxhash64}, and \code{murmur32}.
#'
#' In case the \code{algo} argument is set to random, the algorithm will generate random numbers from
#' a gaussian distribution with a mean of 0 and a standard deviation of 1 -- this is the default arguments in the
#' \code{base::rnorm} function.
#'
#' In case the \code{save} argument is set to \code{TRUE}, a csv file is created with the anonymized data.
#'
#' @export
anonymize_data <- function(data, col_names = NULL, algo = "md5", save = FALSE){
  stopifnot(is.data.frame(data))
  data_orig <- data.table::copy(data)
  if(!is.null(col_names)){
    if (algo != "random"){
      data[, col_names] <- apply(dplyr::select(data, col_names), c(1, 2), digest::digest, algo = algo)
    } else{
      # First, create random numbers based on the dimensions of the data selected
      rand_num_dim <- prod(dim(dplyr::select(data, col_names)))
      data[, col_names] <- stats::rnorm(rand_num_dim)
    }

    # Change colnames of the columns that have been anonymized.
    colnames(data)[which(colnames(data) %in% col_names)] <- paste(col_names, "anonym", sep = "_")

    # Save data as a csv file in case this is asked.
    if(save){
      # Set name for the file
      file_name <- paste0("anonymized_data_", Sys.time(), ".csv")
      utils::write.csv2(data, file_name, row.names = FALSE)
    }

    # Return the anonymized data
    return(data)
  }

}
