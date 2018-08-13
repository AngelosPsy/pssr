#' decrypt_data
#'
#' @description Function for decrypting tabular data
#' @param file_name The name of the file containing the encrypted data.
#' @param password Password to be used.
#' @param nonce_file The name of the nonce file.
#' @return
#' This function returns no values.
#' @details
#' Function for decrypting tabular data.
#' @export
decrypt_data <- function(file_name, password = "password", nonce_file = "nonce") {

  # Hash the key
  key = sodium::hash(charToRaw(password))

  # Read in the nonce file
  nonce_char <- scan(nonce_file, what = "character")
  nonce      <- sodium::hex2bin(paste(nonce_char, collapse = ""))
  # Decrypt the data
  cipher     <- readRDS(paste0(file_name, ".rds"))
  dec_datz   <- sodium::data_decrypt(cipher, key, nonce)
  datz_un    <- unserialize(dec_datz)

  # Save the decrypted data
  saveRDS(datz_un, file = paste0(file_name, Sys.time(), "_decrypted_data.rds"))
}
