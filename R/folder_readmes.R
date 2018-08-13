#' folder_readmes
#'
#' @description Write the readme files for each subfolder when a project is created
#' @param proj_dir Directory path where the new project is located
#' @return
#' This function returns no values.
#' @export
folder_readmes <- function(proj_dir = NULL) {
  if(!is.null(proj_dir)) {
    # Writing readme file for analyses subfolder
    analyses_text     <- "Instructions: This folder holds the analyses scripts of the project."
    data_text         <- "Instrutions: This folder holds the raw and the manipulated data of the project."
    manuscript_text   <- "Instructions: This folder holds the manuscript in its different versions."
    material_text     <- "Instructions: This folder holds the materials of the project."
    prereg_text       <- "Instructions: This folder holds the preregistration document of the project."

    utils::write.table(analyses_text, paste(c(proj_dir, "analyses/Analyses_ReadMe.txt"),
        collapse = "/"), eol = "", quote = FALSE, row.names = FALSE, col.names = FALSE)

    utils::write.table(data_text, paste(c(proj_dir, "data/Data_ReadMe.txt"),
       collapse = "/"), eol = "", quote = FALSE, row.names = FALSE, col.names = F)

    utils::write.table(manuscript_text, paste(c(proj_dir,
        "manuscript/Manuscript_ReadMe.txt"), collapse = "/"), eol = "",
        quote = F, row.names = FALSE, col.names = FALSE)

    utils::write.table(material_text, paste(c(proj_dir,"material/Material_ReadMe.txt"),
       collapse = "/"), eol = "", quote = FALSE, row.names = FALSE, col.names = FALSE)

    utils::write.table(prereg_text, paste(c(proj_dir,
        "preregistration/Preregistration_ReadMe.txt"), collapse = "/"),
        eol = "", quote = FALSE, row.names = FALSE, col.names = FALSE)

  }
}
