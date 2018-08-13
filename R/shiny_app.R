#' Shiny app for the \code{pssr} package
#' @param browser Whether the app should use the browser or not -- default to \code{TRUE}
#' @description Lanches a Shiny app for performing the core analyses included
#' in \code{pssr}
#' @details
#' The function can be called without any arguments (i.e., pssr::shiny_app()).
#'
#' @export
shiny_app <- function (browser = TRUE){
  shiny::runApp(system.file('app', package='pssr'), launch.browser = browser)
}
