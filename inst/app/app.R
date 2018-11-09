library(shiny)
library(pssr)
library(shinyFiles)
library(dplyr)
library(markdown)
library(shinyjs)
library(git2r)
library(devtools)
options(editor = "internal")

'.navbar-default .navbar-brand {
                         color: #cc3f3f;}'

read_pre_file <- function(text_file, object, session_in = session, file_path = "none") {
  if (file.exists(x = text_file)){
    rt <- readLines(text_file)
    updateTextAreaInput(session = session_in, object, value = rt)
  } else {
    write.table(object, text_file,
                eol = "", quote = FALSE, row.names = FALSE, col.names = FALSE)
  }
}

update_pre_file <- function(text_file, object, file_path = "none"){
  #if(file_path == "none"){

    #text_file <- paste0("preregistration/backuptext/", text_file)
  #}else{
    #text_file <- paste0("preregistration/backuptext/", file_path, "/", text_file)

  #}
  write.table(object, text_file,
              eol = "", quote = FALSE, row.names = FALSE, col.names = FALSE)
}

ui <- fluidPage(
  shinyjs::useShinyjs(),
  titlePanel("The Preregistration and Sharing Software"),
  sidebarLayout(
    sidebarPanel(
                h2("General instructions"),
                  p("Use the present app for creating a project, creating a
                  preregistration, and for time stamping changes in your project directory.
                  For executing any of these actions you can use the corresponding tabs
                  on the right."),
                h3("Disclaimer"),
                p("The present app is distributed for free without any guarantee."),
                h4("Contact"),
                p("Angelos Krypotos: amkrypotos@gmail.com"),
                p("Nicolas Perez: nicolasp89@gmail.com"),
                h5("Reference"),
                p("Krypotos, A-M., Klugkist, I., Mertens, G., & Engelhard, I. M. (submitted). A Step-By-Step Guide on Preregistration and Effective Data Sharing for Psychopathology Research.")),
    mainPanel(
      tabsetPanel(type = "tabs", id = "tabs",
                  tabPanel("Create project", id="create_tab",
                           br(),
                           p("Use this tab for either creating a new project or finding an existing one.
                              For creating a new project, just provide a name and select the folder in which the project will be saved.
                              For finding an existing project, you just need to locate it using the 'Find existing project' button."),
                           br(),
                           textInput("text", label = h4("Project name", value = "")),
                           br(),
                          div(style="display:inline-block", shinyDirButton('folder',
                               label='Create new project', title='Please select a folder',
                              buttonType = "primary")),
                          div(style="display:inline-block", shinyDirButton(
                            'folderexisting', label = 'Find existing project', title =
                              'Please select an existing project', buttonType = "primary")),
                           br(),
                           h4(textOutput("currentDir"),style="color:limegreen"),
                           h4(textOutput("currentDirWarning"),style="color:red;")
                           ),
                  tabPanel("Preregistration",  id = "prereg_tab",
                          br(),
                          p("Here you can create and manage preregistration documents.
                          If you want to create a new preregistration file, please
                          type in a name and then choose one of the available
                          templates. A new window with the editor will be shown to modify
                          the template. To select an existing file, just locate it ('Choose file' button). After that
                          a button will be shown named 'Continue editing'. After clicking on it you can continue
                          editing the pre-registration file.Once the text file is edited, please save the file
                          and close the text editor window. The 'Search' button will show
                          the available preregistrations that are in the specified
                          project. To generate PDF files of the preregistrations
                          please click on the 'Choose Files' button and select one or
                          multiple files (for mutiple files press CTRL/Cmd + click on the
                          desired files). Once the files are selected, the
                          'Create PDFs button' will be shown, click on it and wait for
                          the message below confirming that the files were rendered
                          succesfully (this might take some time)."),
                          br(),
                          textInput("preregistrationtext", label = h4("Enter name of the
                                    preregistration", value = "")),
                          selectInput("selectTemplate", label = h4("Choose a pre-registration template"), choices =
                                        list("pss" = "pss", "aspredicted" = "aspredicted",
                                             "cos" = "cos"), selected = 2),
                          div(style="display:inline-block",
                              actionButton("f_prer_button", "Search Preregistrations",icon = icon("search"),
                              style="color: #fff; background-color: #337ab7;
                              border-color: #337ab7")),
                            div(style="display:inline-block", shinyFilesButton('pdfButton',
                                                                             label='Choose files', title='Please select the files
                                                                             to convert', multiple = TRUE, buttonType = "success"),
                              filetype=list(markdown = c("Rmd","md"))),

                            div(style="display:inline-block", actionButton("openpre",
                                                                         label = "Continue editing",icon = icon("edit"),
                                                                         style="color: #fff; background-color: #337ab7;
                                                                         border-color: #337ab7")),
                          div(style="display:inline-block", actionButton("createpre",
                                                                         label = "Create",icon = icon("plus"),
                                                                         style="color: #fff; background-color: #337ab7;
                                                                         border-color: #337ab7")),
                          div(style="display:inline-block", actionButton("render_button",
                              "Create PDFs",icon = icon("file"),
                              style="color: #fff; background-color: #32cd32; border-color: #32cd32")),
                          h4(textOutput("summary"),style="color:limegreen"),
                             verbatimTextOutput("availableRmd")
                          ),
                  tabPanel("Template control",  value="template_tab",
                           textAreaInput("title_par", h1("Title"), "Insert title", width = "600px", height = "80px"),
                           textAreaInput("author_par", h2("Author list"), "Insert Authors", width = "600px", height = "80px"),
                           textAreaInput("affiliation_par", h3("Affiliation list"), "Insert Affiliations", width = "600px", height = "80px"),
                           h1("Background of the study"),
                           textAreaInput("study_questions_par", "Study questions", "Define the study's research questions", width = "600px", height = "80px"),
                           textAreaInput("study_hypotheses_par", "Study hypotheses", "Define the study's hypotheses", width = "600px", height = "80px"),
                           h1("Methods"),
                           textAreaInput("stimuli_par", "Stimuli", "Stimuli to be used", width = "600px", height = "80px"),
                           textAreaInput("questionnaire_par", "Questionnaires", "Questionnaires to be used", width = "600px", height = "80px"),
                           textAreaInput("equipment_par", "Equipment", "Equipment to be used", width = "600px", height = "80px"),
                           textAreaInput("procedure_par", "Procedure", "Describe the procedure to be followed", width = "600px", height = "80px"),
                           textAreaInput("protocol_par", "Protocol", "Paste the protocol", width = "600px", height = "80px"),
                           h1("Statistical analyses"),
                           textAreaInput("participant_number_par", "Participant number", "Argue about the number of participants", width = "600px", height = "80px"),
                           textAreaInput("stopping_rule_par", "Stopping rule", "Rule for stopping data collection", width = "600px", height = "80px"),
                           textAreaInput("confirming_theershold_par", "Confirm hypotheses", "Amount of evidence for confirming each hypothesis", width = "600px", height = "80px"),
                           textAreaInput("disconfirming_theershold_par", "Disconfirm hypotheses", "Amount of evidence for disconfirming each hypothesis", width = "600px", height = "80px"),
                           textAreaInput("other_par", "Other", "Add any additional information here", width = "600px", height = "80px"),
                           textAreaInput("references_par", "References", "Add any references here", width = "600px", height = "80px")
                          ),

                  tabPanel("Anonymize data",  id="anon_tab",
                          br(),
                          p("Here you can anonymize the data of your project. For that you need to select the data file -- at this moment
                            only .csv files are supported. Then, select the columns to be anonymized. The software will fill in the columns
                            with random numbers or any of the encryption choices. By clicking on 'Yes' at save data, the anonymized data are
                            will be saved in the data directory of the project."),
                          h1("Upload data"),
                          fileInput("file1", "Choose CSV File",
                                     multiple = FALSE, accept =
                                      c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                           checkboxInput("header", "Header", TRUE),
                           radioButtons("sep", "Separator",
                                        choices = c(Comma = ",", Semicolon = ";",
                                                    Tab = "\t"), selected = ";"),
                          h1("Original data"),
                          dataTableOutput("data_contents"),

                          selectInput("columns", "Select columns to be anonymized",
                                      choices = NULL, multiple = TRUE),

                          selectInput("anony_options", "How to anonymize data?",
                                       choices = c(NULL, "random", "md5", "sha1", "crc32",
                                      "sha256", "sha512", "xxhash32", "xxhash64",
                                      "murmur32")),

                          radioButtons("save_data", "Do you want the data to be saved?",
                                      choices = c(Yes = TRUE, No = FALSE), selected =
                                      "FALSE"),

                          h1("Anonymized data"), dataTableOutput("table_display")),

                 tabPanel("Zip and encrypt data",  id="encrypt_tab",
                          br(),
                          p("You can use this tab for zipping and encrypting the folders in the project.
                            To do that, just tick on the folders you want to encrypt, select a password,
                            and then click on 'Encrypt Project files' button."),
                          textInput("encryptPassword", label = h4("Enter password",
                                  value = "")),
                          h4("Select the subfolders to encrypt"),
                          div(style="display:inline-block", checkboxInput("cb_analyses",
                            label = "Analyses", value = FALSE, width = "180px")),
                          div(style="display:inline-block", checkboxInput("cb_data",
                            label = "Data", value = FALSE, width = "180px")),
                          div(style="display:inline-block", checkboxInput("cb_manu",
                            label = "Manuscript", value = FALSE, width = "180px")),
                          br(),
                          div(style = "display:inline-block", checkboxInput("cb_material",
                               label = "Material", value = FALSE, width = "180px")),
                          div(style = "display:inline-block", checkboxInput("cb_prer",
                               label = "Preregistrations", value = FALSE, width = "180px")),
                          br(),
                          div(style = "display:inline-block", actionButton("encryptData",
                               "Encrypt Project files",icon = icon("lock"),
                               style = "color: #fff; background-color: #32cd32; border-color: #32cd32")),
                          h4(textOutput("zips"),style = "color:limegreen"),
                          h5("The following links consitute sources that are often used to backup
                             personal data in cloud storage. Click on one of them if you want
                             to manually upload your ZIP project file."),
                          h5(helpText(a("Upload to The Open Science Foundation",
                                        href = "http://www.osf.io",target="_blank"))),
                          h5(helpText(a("Upload to The GitHub",
                                        href = "http://www.github.com",target="_blank")))
                          ),
                   tabPanel("Record changes",  value="changes_tab",
                           br(),
                           p("Here, you can see what changes have been done in your
                           project as well as creating new timestamps. To start
                           recording your changes choose a user name, a user email
                           and a commit message, then press the start button. After that,
                           you can timestamp thechanges in the files by pressing the
                           'Timestamp changes' button."),
                           div(style = "display:inline-block", textInput("username",
                                  label = h4("User name", value = ""),width = "280px")),
                           div(style = "display:inline-block",  textInput("useremail",
                                  label = h4("User email", value = "",width = "280px"))),
                           br(),
                           textInput("message_commit",label = h4("Message to commit"),"",
                                     width = "585px" ),
                           div(style="display:inline-block", actionButton("f_commits",
                               "Track changes", icon = icon("search"),
                               style="color: #fff; background-color: #337ab7; border-color: #337ab7")),
                           div(style="display:inline-block",
                               actionButton("commit", "Timestamp changes",icon = icon("hourglass"),
                               style = "color: #fff; background-color: #337ab7; border-color: #337ab7")),
                           h4(textOutput("commit_succes"), style="color:limegreen"),
                           h5("The following files were changed and/or created and have
                              not been timestamped"),
                           verbatimTextOutput("status")
                           ),
                  tabPanel("Version control",  value="versions_tab",
                           br(),
                           p("Here you can check for older versions of your project and
                           track the specific changes that exist between the different
                           timestamped versions. Details about the changes between
                           versions are shown in the text in the grey box.To restore a
                           previous version of your project, please choose the timestamp
                           from the dropdown list and press the 'Go To Coomit' button.
                           NOTE: When you restore to a previous version a new commit
                           is added as the last commit and it will contain the content
                           of the commit that you selected to restore. We recommend to
                           restore commits only when necesary since this can create a
                           large amount of commits in your actual respository." ),
                           div(style = "display:inline-block",uiOutput("commit_list")),
                           div(style = "display:inline-block", selectInput("backupSelect",
                               label = h4("Backup original repository?"),
                               choices = list("Yes"="Yes", "No" = "No"),width="280px")),
                           br(),
                           div(style = "display:inline-block", checkboxInput("cb_analyses2",
                                  label = "Analyses", value = FALSE, width = "180px")),
                           div(style = "display:inline-block", checkboxInput("cb_data2",
                                  label = "Data", value = FALSE, width = "180px")),
                           div(style = "display:inline-block", checkboxInput("cb_manu2",
                                  label = "Manuscript", value = FALSE, width = "180px")),
                           br(),
                           div(style = "display:inline-block", checkboxInput("cb_material2",
                                  label = "Material", value = FALSE, width = "180px")),
                           div(style = "display:inline-block", checkboxInput("cb_prer2",
                               label = "Preregistrations", value = FALSE,
                               width = "180px")),
                           br(),
                           div(style = "display:inline-block", actionButton("Restore",
                               "Go To Commit",icon = icon("back"),
                                style = "color: #fff;background-color: #337ab7; border-color: #337ab7")),
                           h5(""),
                           verbatimTextOutput("commit_info")
                           )
      )
    )
  )
)

server <- function(input, output, session) {

  session$onSessionEnded(stopApp)

  # Function to recall the current volumes based on the project directory
  ui_volumes <- function() {
    sel_path <- parseDirPath(volumes, input$folderChoose)
    volumes <- volumes()
    if (length(sel_path()) > 0 && !sel_path() %in% volumes) {
      vnames <- c(basename(proj_dir()), names(volumes))
      setNames(c(proj_dir(), volumes), vnames)
    }
    else if (length(sel_path_exist()) > 0 && !sel_path_exist() %in% volumes) {
      vnames <- c(basename(proj_dir()), names(volumes))
      setNames(c(proj_dir(), volumes), vnames)
    }
    else {
      volumes
    }
  }

  # Load available volumes in the computer
  volumes = getVolumes()
  shinyjs::disable("versions_tab")

  ## -------------------------- SCRIPTS AND FUNCS TAB 1: PROJECT -------------------------

  # Disable create project button if no text is present in the Project name field
  observe({ shinyjs::toggleState("folder", !is.null(input$text) && input$text != "")})

  # Create Project Tab
  project_name <- reactive({as.character(input$text)})

  # Refer to the proper paths and roots in each button that requires it
  shinyDirChoose(input, 'folder', roots = volumes, session = session)
  shinyDirChoose(input, 'folderexisting', roots = volumes, session = session)

  # Reactive variables to store the paths (new or existing)
  sel_path <- reactive({return(print(parseDirPath(volumes, input$folder)))})
  sel_path_exist <- reactive({return(print(parseDirPath(volumes, input$folderexisting)))})

  # Create a new project
  creat_proj <- eventReactive(input$folder, {
    setwd(sel_path())
    pssr::make_project(proj_name = input$text)
    creat_proj <- paste(sel_path(), input$text, sep = "/")
    setwd(creat_proj)
    pssr::folder_readmes(creat_proj)
    pssr::init_repo(creat_proj)

    # Load a standard message for the first time commit
    updateTextInput(session,"message_commit",value = "This is a standard message for the first commit")
    creat_proj
  })

  # Load existing project
  exist_proj <- eventReactive(input$folderexisting, {
    setwd(sel_path_exist())
    exist_proj <- sel_path_exist()
  })

  # Track project working directory
  proj_dir <- reactive({
    cur_dir <- ""
    if (length(sel_path())>0){
      cur_dir <- creat_proj()
    } else if(length(sel_path_exist())>0){
      cur_dir <- exist_proj()
    }
    cur_dir
  }
  )

  # Print the destination folder (new or existing) for the currant project
  output$currentDir <- renderText({
    if(proj_dir()=="") "" else paste0("Your project is located in: ", proj_dir())
  })

  # Warning
  output$currentDirWarning <- renderText({
    folder_structure <- c(".git", "analyses", "data", "manuscript", "material", "preregistration")
    ldr <- list.dirs(path = ".", full.names = FALSE, recursive = FALSE)
    if(any(!ldr %in% folder_structure) && proj_dir()!=""){
     updateTextInput(session, "text", value = "")
      "The folder structure is not correct. Please select a folder generated by this software."
    } else if(proj_dir()!=""){
      updateTextInput(session, "text", value = tail(unlist(strsplit(getwd(), "/")), 1))
      ""
      }
    }
  )

  ## -------------------------- SCRIPTS AND FUNCS TAB 2: Pre-registration tab-------------------------


  # Hide version control tab if project is not selected
  observe({hideTab("tabs","template_tab")})

  # Parameters for pss template
  title_par                     <- reactive({input$title_par})
  author_par                    <- reactive({input$author_par})
  affiliation_par               <- reactive({input$affiliation_par})
  study_questions_par           <- reactive({input$study_questions_par})
  study_hypotheses_par          <- reactive({input$study_hypotheses_par})
  stimuli_par                   <- reactive({input$stimuli_par})
  questionnaire_par             <- reactive({input$questionnaire_par})
  equipment_par                 <- reactive({input$equipment_par})
  procedure_par                 <- reactive({input$procedure_par})
  protocol_par                  <- reactive({input$protocol_par})
  participant_number_par        <- reactive({input$participant_number_par})
  stopping_rule_par             <- reactive({input$stopping_rule_par})
  confirming_theershold_par     <- reactive({input$confirming_theershold_par})
  disconfirming_theershold_par  <- reactive({input$disconfirming_theershold_par})
  other_par                     <- reactive({input$other_par})
  references_par                <- reactive({input$references_par})

  # Define standard path to for the choose view for  PDF files to render
  shinyFileChoose(input, 'pdfButton', roots = ui_volumes, session = session, filetypes=c('', 'Rmd'))

  template_reac    <- reactive({input$selectTemplate})
  prereg_name_reac <- reactive({input$preregistrationtext})

  # Disable create preregistration button if name field is empty
  observe({
    shinyjs::toggleState("createpre",
                         !is.null(input$preregistrationtext) && input$preregistrationtext != "" && proj_dir() != "")
  })

  # Hide render PDFs button if nothing has been chose
   shinyjs::hide("render_button")
   shinyjs::onclick("pdfButton", show("render_button"))

  # Create a preregistration template
  observeEvent(input$createpre, {
    cw <- proj_dir()
    setwd(paste(c(cw, "preregistration"), collapse = "/"))
    if(directoryReact() %in% c("cos", "aspredicted")){
      # In case of the cos or the aspredicted template, we save only the .rmd file
      pssr::prereg_create(file_name = prereg_name_reac(),
                          template_name = template_reac())
    } else {
      # In case of the pss template, we need to save different txt files.
      pssr::prereg_create(file_name = prereg_name_reac(),
                          template_name = template_reac(), edit = FALSE)
      setwd("backuptext")
      shiny::showTab("tabs","template_tab", select = TRUE)
      dir.create(prereg_name_reac())
      setwd(prereg_name_reac())
      pathz <- getwd()

      read_pre_file("title.txt", "title_par", session, pathz)
      observeEvent(input$title_par, {setwd(print(pathz)); update_pre_file("title.txt", title_par(), pathz)})
      read_pre_file("author.txt", "author_par", session, pathz)
      observeEvent(input$author_par, {update_pre_file("author.txt", author_par(), pathz)})
      read_pre_file("affiliation.txt", "affiliation_par", session, pathz)
      observeEvent(input$affiliation_par, {update_pre_file("affiliation.txt", affiliation_par(), pathz)})
      read_pre_file("study_questions.txt", "study_questions_par", session, pathz)
      observeEvent(input$study_questions_par, {update_pre_file("study_questions.txt", study_questions_par(), pathz)})
      read_pre_file("study_hypotheses.txt", "study_hypotheses_par", session, pathz)
      observeEvent(input$study_hypotheses_par, {update_pre_file("study_hypotheses.txt", study_hypotheses_par(), pathz)})
      read_pre_file("stimuli.txt", "stimuli_par", session, pathz)
      observeEvent(input$stimuli_par, {update_pre_file("stimuli.txt", stimuli_par(), pathz)})
      read_pre_file("questionnaire.txt", "questionnaire_par", session, pathz)
      observeEvent(input$questionnaire_par, {update_pre_file("questionnaire.txt", questionnaire_par(), pathz)})
      read_pre_file("equipment.txt", "equipment_par", session, pathz)
      observeEvent(input$equipment_par, {update_pre_file("equipment.txt", equipment_par(), pathz)})
      read_pre_file("procedure.txt", "procedure_par", session, pathz)
      observeEvent(input$procedure_par, {update_pre_file("procedure.txt", procedure_par(), pathz)})
      read_pre_file("protocol.txt", "protocol_par", session, pathz)
      observeEvent(input$protocol_par, {update_pre_file("protocol.txt", protocol_par(), pathz)})
      read_pre_file("participant_number.txt", "participant_number_par", session, pathz)
      observeEvent(input$participant_number_par, {update_pre_file("participant_number.txt", participant_number_par(), pathz)})
      read_pre_file("stopping_rule.txt", "stopping_rule_par", session, pathz)
      observeEvent(input$stopping_rule_par, {update_pre_file("stopping_rule.txt", stopping_rule_par(), pathz)})
      read_pre_file("confirming_theershold.txt", "confirming_theershold_par", session, pathz)
      observeEvent(input$confirming_theershold_par, {update_pre_file("confirming_theershold.txt", confirming_theershold_par(), pathz)})
      read_pre_file("disconfirming_theershold.txt", "disconfirming_theershold_par", session, pathz)
      observeEvent(input$disconfirming_theershold_par, {update_pre_file("disconfirming_theershold.txt", disconfirming_theershold_par(), pathz)})
      read_pre_file("other.txt", "other_par", session, pathz)
      observeEvent(input$other_par, {update_pre_file("other.txt", other_par(), pathz)})
      read_pre_file("references.txt", "references_par", session, pathz)
      observeEvent(input$references_par, {update_pre_file("references.txt", references_par(), pathz)})
    }
    setwd(cw)
  }) # return to project folder wd

  # Reactive names from the input files dialog window
  input_files <- reactive({shinyFiles::parseFilePaths(ui_volumes, input$pdfButton)$name})

  # Render the selected markdown files into pdf files
  renderSelectedPDF <- observeEvent(input$render_button,{
    if (length(input_files()) > 0 ){

      print(paste("check: ", input_files() ))

      cw <- proj_dir()

      preregPath <- (paste(c(cw, "preregistration"), collapse = "/"))

      pssr::render_files(file_list = input_files(), location_path = preregPath,
                         render_params = list(title_par = title_par(),
                                              author_par = author_par(),
                                              affiliation_par = affiliation_par(),
                                              study_questions_par = study_questions_par(),
                                              study_hypotheses_par = study_hypotheses_par(),
                                              stimuli_par = stimuli_par(),
                                              questionnaire_par = questionnaire_par(),
                                              equipment_par = equipment_par(),
                                              procedure_par = procedure_par(),
                                              protocol_par = protocol_par(),
                                              participant_number_par = participant_number_par(),
                                              stopping_rule_par = stopping_rule_par(),
                                              confirming_theershold_par = confirming_theershold_par(),
                                              disconfirming_theershold_par = disconfirming_theershold_par(),
                                              other_par = other_par(),
                                              references_par = references_par()))
      output$summary <- renderText(paste0("Files rendered succesfully in: ", proj_dir(),
                                          "/preregistration"))
    } else{
      output$summary <- renderText("No file was selected.")
    }
  }
  )

  # Open the file for manipulation
  observeEvent(input$pdfButton, {
    updateTextInput(session, "preregistrationtext", value = input_files())
  })

  openPrereg <- observeEvent((input$createpre || input$openpre),{
    if (length(input_files()) > 0  && (proj_dir() != "")){

      cw <- proj_dir()
      preregPath <- paste(c(cw, "preregistration", input_files()), collapse = "/")
      pathz <- tools::file_path_sans_ext(input_files())
      preregPath2 <- (paste(c(cw, "preregistration/backuptext", pathz), collapse = "/"))

      if(dir.exists(preregPath2)){
        setwd(preregPath2)
        read_pre_file("title.txt", "title_par", session, pathz)
        observeEvent(input$title_par, {update_pre_file("title.txt", title_par(), pathz)})
        read_pre_file("author.txt", "author_par", session, pathz)
        observeEvent(input$author_par, {update_pre_file("author.txt", author_par(), pathz)})
        read_pre_file("affiliation.txt", "affiliation_par", session, pathz)
        observeEvent(input$affiliation_par, {update_pre_file("affiliation.txt", affiliation_par(), pathz)})
        read_pre_file("study_questions.txt", "study_questions_par", session, pathz)
        observeEvent(input$study_questions_par, {update_pre_file("study_questions.txt", study_questions_par(), pathz)})
        read_pre_file("study_hypotheses.txt", "study_hypotheses_par", session, pathz)
        observeEvent(input$study_hypotheses_par, {update_pre_file("study_hypotheses.txt", study_hypotheses_par(), pathz)})
        read_pre_file("stimuli.txt", "stimuli_par", session, pathz)
        observeEvent(input$stimuli_par, {update_pre_file("stimuli.txt", stimuli_par(), pathz)})
        read_pre_file("questionnaire.txt", "questionnaire_par", session, pathz)
        observeEvent(input$questionnaire_par, {update_pre_file("questionnaire.txt", questionnaire_par(), pathz)})
        read_pre_file("equipment.txt", "equipment_par", session, pathz)
        observeEvent(input$equipment_par, {update_pre_file("equipment.txt", equipment_par(), pathz)})
        read_pre_file("procedure.txt", "procedure_par", session, pathz)
        observeEvent(input$procedure_par, {update_pre_file("procedure.txt", procedure_par(), pathz)})
        read_pre_file("protocol.txt", "protocol_par", session, pathz)
        observeEvent(input$protocol_par, {update_pre_file("protocol.txt", protocol_par(), pathz)})
        read_pre_file("participant_number.txt", "participant_number_par", session, pathz)
        observeEvent(input$participant_number_par, {update_pre_file("participant_number.txt", participant_number_par(), pathz)})
        read_pre_file("stopping_rule.txt", "stopping_rule_par", session, pathz)
        observeEvent(input$stopping_rule_par, {update_pre_file("stopping_rule.txt", stopping_rule_par(), pathz)})
        read_pre_file("confirming_theershold.txt", "confirming_theershold_par", session, pathz)
        observeEvent(input$confirming_theershold_par, {update_pre_file("confirming_theershold.txt", confirming_theershold_par(), pathz)})
        read_pre_file("disconfirming_theershold.txt", "disconfirming_theershold_par", session, pathz)
        observeEvent(input$disconfirming_theershold_par, {update_pre_file("disconfirming_theershold.txt", disconfirming_theershold_par(), pathz)})
        read_pre_file("other.txt", "other_par", session, pathz)
        observeEvent(input$other_par, {update_pre_file("other.txt", other_par(), pathz)})
        read_pre_file("references.txt", "references_par", session, pathz)
        observeEvent(input$references_par, {update_pre_file("references.txt", references_par(), pathz)})
        shiny::showTab("tabs","template_tab", select = TRUE)
      } else {
        print(input_files())
        print("here")
        utils::file.edit(normalizePath(preregPath))
      }
    }
  }

  )

  # Load a list of exisitng preregistrations in the project
  list_rmd_react <-eventReactive({c(input$f_prer_button)}, {

    if(input$f_prer_button > 0){
      lf <- paste(list.files(path = paste(c(proj_dir(), "preregistration"),
                                          collapse = "/"), pattern = ".Rmd"), sep = "\n")
      if (length(lf) == 0){ lf <- ""
      } else{
        lf <- paste(c("The following .Rmd files were found:", lf), collapse = "\n",
                    sep = "\n")
      }
    } else {
      lf = NULL
    }
    lf
  })

  # Print the list of available preregistrations
  output$availableRmd <- renderText({list_rmd_react()})


  ## -------------------------- SCRIPTS AND FUNCS TAB 3: Anonymize data -------------------------

  # Hide version changes tab if project is not selected
  observe({shiny::hideTab("tabs","anon_tab")})

  # Show tab when project directory is loaded
  observe({
    if(proj_dir() != ""){
      shiny::showTab("tabs","anon_tab")
    }
  })

  directoryReact <- reactive({input$selectTemplate})

  anony_data_set <- reactive({
    req(input$file1)
    tryCatch({
      df <- read.csv(input$file1$datapath,
                     header = input$header,
                     sep = input$sep)
    },
    error = function(e) {
      # return a safeError if a parsing error occurs
      stop(safeError(e))
    }
    )
  })

  # Anonymize data
  output$data_contents <- renderDataTable({
    req(input$file1)
    anony_data_set()
  }, options = list(pageLength = 2))

  info <- eventReactive(input$file1, {
    vars <- colnames(anony_data_set())
    # Update select input immediately after clicking on the action button.
    updateSelectInput(session, "columns","Select Columns", choices = vars)
    anony_data_set()
  })

  anony_options_sel <- reactive({input$anony_options})
  save_data_reac <- reactive({input$save_data})

  output$table_display <- renderDataTable({
    f <- info()
    an_data <- pssr::anonymize_data(data = f, col_names = input$columns, algo = anony_options_sel(),
                                    save = save_data_reac())
    an_data
  }, options = list(pageLength = 5))

  ## -------------------------- SCRIPTS AND FUNCS TAB 4 -------------------------

  # Hide version encrypt tab if project is not selected
  observe({shiny::hideTab("tabs","encrypt_tab")})

  # Show tab when project directory is loaded
  observe({
    if(proj_dir()!=""){
      shiny::showTab("tabs","encrypt_tab")}
  })

  # Disable encrypt button if no password or subfolders are chosen
  observe({
    shinyjs::toggleState("encryptData", !is.null(input$encryptPassword) &&
                           input$encryptPassword != "" && (input$cb_analyses | input$cb_data |
                                                             input$cb_manu | input$cb_material | input$cb_prer))
  })

  # Paramters for ecnryption
  myPassword <- renderText(input$encryptPassword)
  selection_encrypt <- reactive(c(input$cb_analyses, input$cb_data, input$cb_manu,
                                  input$cb_material, input$cb_prer))

  # Function to encrypt selected subfolders
  encryption <- observeEvent(input$encryptData,{
    if (proj_dir() == ""){
      output$zips <- renderText("It appears that this is not a project generated by this software. No zip file was created.")
    } else{
      pssr::zip_selection(proj_dir(), selection_encrypt(), myPassword(), FALSE)
      output$zips <- renderText(paste0("ZIP file created in: ", proj_dir()))
    }
  })

  ## -------------------------- SCRIPTS AND FUNCS TAB 5 -------------------------

  # Hide version encrypt tab if project is not selected
  observe({shiny::hideTab("tabs", "changes_tab")})

  # Show tab when project directory is loaded
  observe({
    if(proj_dir()!=""){
      shiny::showTab("tabs", "changes_tab")
    }
  })

  # disable output of pending files if no project is selected or created
  shinyjs::hide("status")
  shinyjs::onclick("folder", show("status"))
  shinyjs::onclick("folderexisting", show("status"))

  # Only enable button if email and user exist
  observe({
    shinyjs::toggleState("commit", !is.null(input$username) &&
                           input$username != "" &&
                           !is.null(input$useremail) && input$useremail != "" &&
                           !is.null(input$message_commit) && input$message_commit != "" &&
                           !is.null(files_to_commit()))
  })
  # Load the Git repository
  git_repo <- reactive({tryCatch(git2r::repository(proj_dir()), error = function(e) NULL,
                               warning = function(w) NULL)})

  # Preload username and user email if they exist in github repository config file
  observeEvent(git_repo(),{
    if(proj_dir()!=""){
      updateTextInput(session, "username", value = config(git_repo())$local$user.name)
      updateTextInput(session, "useremail", value = config(git_repo())$local$user.email)
    }
  })

  # Check for files that have been not added to the latest commit
  files_to_commit <- eventReactive({c(input$f_commits, input$tabs, input$commit)},{
    unname(unlist(git2r::status(git_repo(), all_untracked = TRUE)))
  })

  # Check status of Files in folder
  output$status <- renderText({
    if(!is.null(files_to_commit())){
      paste(files_to_commit(),collapse="\n")
    }
    else{
      "No pending files or changes were found"
    }
  })

  # Commit changes
  commit_pending <- observeEvent(input$commit, {
    config_repo(git_repo(), input$username, input$useremail)
    if(!is.null(files_to_commit())) {
      #print(git_repo())
      #print(input$message_commit)
      pssr::commit_files(repo_obj = git_repo(), file_list = files_to_commit(), message = input$message_commit)
      shiny::updateTabsetPanel(session, "tabs", selected = "versions_tab")
      shiny::updateTabsetPanel(session, "tabs", selected = "changes_tab")
    }
  })

  ## -------------------------- SCRIPTS AND FUNCS TAB 6 -------------------------

  # Hide version control tab if project is not selected
  observe({shiny::hideTab("tabs","versions_tab")})

  # Show tab when project directory is loaded
  observe({if(proj_dir()!=""){
    shiny::showTab("tabs", "versions_tab")}
  })

  # Input values of the check boxes for backup
  selection_backup <- reactive(c(input$cb_analyses2, input$cb_data2, input$cb_manu2,
                                 input$cb_material2, input$cb_prer2))

  # Disable restore button if no subfolders are chosen and backup is yes
  observe({
    shinyjs::toggleState("Restore", !(input$backupSelect=="Yes" &&
                                        sum(selection_backup())==0))
  })

  # A reactive value to force an update on the commit list after restoring
  forUpComList <- reactiveVal()

  # variable that contains the commits
  commits_repo <- eventReactive(c(input$commit, forUpComList(), proj_dir(), git_repo()),
                                {git2r::commits(git_repo())})

  commits_list <- eventReactive(c(input$tabs,commits_repo()),{
    commits_list <- seq(1:length(commits_repo()))
    names(commits_list) <- paste("Commit", seq_along( length(commits_repo())))
    commits_list <- as.list(commits_list)
  })

  # Dynamically render the input select list box
  # THIS RENDERING GENERATES A WARNING WHEN FIRST ATTEMPTING TO CHOOSE A 0 INDEX IN ARRAY
  output$commit_list <- renderUI({
    print(commits_list())
    selectInput("commit_list", h4("Select Commit"),
                                              commits_list(), width="280px")})

  # Print info about the commit
  output$commit_info <- renderPrint({
    # There should be at least one commit before the list shows up
    req(as.integer(input$commit_list) > 0)
    summary(commits_repo()[[as.integer(input$commit_list)]])})

  # Restore a previous verson and backup if needed
  restore_git<-observeEvent(input$Restore,{
    if(input$backupSelect=="Yes" && sum(selection_backup()) > 0 ){
      pssr::zip_selection(proj_dir(), selection_backup(), NULL, TRUE)
    }

    # Set the working directory to be proj_dir
    setwd(proj_dir())
    # Identify the selected commit
    currentCommit <- commits_repo()[[as.integer(input$commit_list)]]
    os <- .Platform$OS.type

    if(os == "windows"){ # Windows configuration
      # Remove all files in the actual head to start an empty commit
      system("cmd.exe /c git rm -r .")
      # Checkout the commit that would be restored
      commandCheckout <- paste0(paste0("cmd.exe /c git checkout ", unlist(currentCommit$sha))," .")
      system(commandCheckout)
      # Commit with standard message
      commandCommit <- commandCommit<-paste0(paste0(paste0(paste0('cmd.exe /c git commit -m "'),
                                                           "This is a commit that reverts to state in commit # "),
                                                    as.integer(length(commits_repo()))-as.integer(input$commit_list)+1),'"')
      system(commandCommit)

    } else {
      # Remove all files in the actual head to start an empty commit
      system("git rm -r .")
      # Checkout the commit that would be restored
      commandCheckout <- paste0(paste0("git checkout ", unlist(currentCommit$sha))
                                ," .")
      system(commandCheckout)
      # Commit with standard message
      commandCommit <- commandCommit <- paste0(paste0(paste0(paste0('git commit -m "'),
                                                             "This is a commit that reverts to state in commit # "),
                                                      as.integer(length(commits_repo()))-as.integer(input$commit_list)+1), '"')
      system(commandCommit)
    }

    # Force commit list update
    forUpComList(runif(n=1))
  })

}

# Run the application
shinyApp(ui = ui, server = server)
