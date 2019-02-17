#' prereg_create
#'
#' @description Function for creating markdown file for a preregistration f.
#' @param file_name The name of the preregistration document. Default name is \code{preregistration}.
#' @param template_name The selected template to use. Default is set to "osf". See details for options.
#' @param overwrite Whether the preregistration file should be overwritten or not. Default to \code{FALSE}.
#' @param edit Whether the file should be edited. Default to \code{TRUE}.
#' @return
#' Only a warning is generated in case the file exists already and the \code{overwrite} argument is set
#' to FALSE.
#' @details
#' The options for the \code{template_name} are: \code{pss}, \code{secondary_analyses}, \code{aspredicted}, \code{cos}. See the
#' \code{prereg} package for more details on these options. When the \code{aspredicted} or the \code{cos} options are used,
#' the function uses the templates of the \code{prereg} package of Frederik Aust.
#' @export
prereg_create <- function(file_name = "preregistration", template_name = "pss",
                          overwrite = FALSE, edit = TRUE){
  # Check if the template argument has one of the four preferred choices
  match.arg(template_name, c("pss", "secondary_analyses",
                             "aspredicted", "cos"))

  # Define preregistration package
  prereg_package <- ifelse(template_name %in% c("pss"), "pssr", "prereg")

  # Put extension in the file and template name
  file_name <- paste0(file_name, ".Rmd")
  template_name <- paste0(template_name, "_prereg")

  # Create the file. Take into account if the overwrite option has been selected.
  if(!overwrite & file.exists(file_name)){
     warning(paste("The file named", file_name, "exists already.
                    Select 'overwite' if you want to overwrite the file. Note
                   that this would remove any text you have written"))
  } else if(!file.exists(file_name)){
    rmarkdown::draft(file = file_name, template = template_name, package = prereg_package, create_dir = FALSE, edit = FALSE)
  } else if(overwrite & file.exists(file_name)){
    # First remove the file in order not to get an error
    file.remove(file_name)
    rmarkdown::draft(file = file_name, template = template_name, package = prereg_package, create_dir = FALSE, edit = FALSE)
  }
  if (edit){
    utils::file.edit(normalizePath(file_name))
  }
}
