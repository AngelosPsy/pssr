#' Shiny app for the \code{pssr} package
#'
#' @description Lanches a Shiny app for performing the core analyses included
#' in \code{pssr}
#' @details
#' The function can be called without any arguments (i.e., pssr::shiny_app()).
#'
#' @export
shiny_app <- function (){
  shiny::runApp(system.file('app', package='pssr'))
}
