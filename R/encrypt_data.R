#' encrypt_data
#'
#' @description Function for encrypting the files included in the data directory
#' @param file_name the name of the data file to be encrypted
#' @param password password to be used
#' @return
#' This function returns no values.
#' @export
encrypt_data <- function(file_name, password = "password") {
  # Read data files. A data file has to be selected
  datz <- read_data_file(file_name = file_name)
  file_name_rm_ext <- stringr::str_sub(file_name, 1, -5)

  # Start working on encryptions
  key_string = password
  key <- sodium::hash(charToRaw(key_string))
  msg <- serialize(datz, NULL)

  ## nonce file creation
  nonce <- sodium::random(24)
  nonce_file_name <- paste0(file_name_rm_ext, "_nonce")
  # Save the nonce file
  if(file.exists(nonce_file_name)){
    stop("The nonce file exists already.")
  } else {
    write(nonce, file = paste0(file_name_rm_ext, "_nonce"))
    # encrypt the data
    cipher <- sodium::data_encrypt(msg, key, nonce)
    # Save the encrypted data
    saveRDS(cipher, file = paste0(file_name_rm_ext, ".rds"))
  }
}
