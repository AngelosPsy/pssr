#' make_rproject
#'
#' @description Short function for creating an R project and a basic R script
#' @param proj_dir Directory path where the new project is located
#' @return
#' This function returns no values.
#' @export
make_rproject <- function(proj_dir = NULL) {
  # Create R project
  path <- file.path(paste0(proj_dir, "/analyses"), paste0('Rproject', ".Rproj"))
  template_path <- system.file("templates/template.Rproj", package = "devtools")
  file.copy(template_path, path)

  # Create .R file
  write(x = "#This is a script that could be used for writing up the
        relevant analyses of the present project. In case you do not
        the following resources: https://github.com/AngelosPsy/EPPR/wiki/Links",
        file = paste0(proj_dir, "/analyses/analyses.R"))
}
