% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/render_files.R
\name{render_files}
\alias{render_files}
\title{render_files}
\usage{
render_files(file_list = NULL, location_path = NULL,
  render_params = NULL, output_type = ".pdf_document")
}
\arguments{
\item{file_list}{vector with the names of the ".Rmd" files to render}

\item{location_path}{path where the target files are located}

\item{render_params}{list of parameters to be used}

\item{output_type}{defined format for all he ouptut files}
}
\value{
This function returns no values.
}
\description{
This function is used to render output files for a list of selected
markdown ".Rmd" or ".md" files that are located in the same path/directory.
}
\details{
The function creates a ".pdf" file for every input file that was added in the file_list
paramater.
}
