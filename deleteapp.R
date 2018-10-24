ui <- shinyUI(bootstrapPage(
  shinyFilesButton('files', 'File select', 'Please select a file', FALSE),
  verbatimTextOutput('rawInputValue'),
  verbatimTextOutput('filepaths')
))
server <- shinyServer(function(input, output) {
  roots = c(wd='.')
  shinyFileChoose(input, 'files', roots=roots)
  reactive({return( as.character( print(parseFilePaths(roots, input$files)$name) )) }) 
  output$rawInputValue <- renderPrint({str(input$files)})
  output$filepaths <- renderPrint({parseFilePaths(roots, input$files)$name})
  
  #print(as.character(parseFilePaths(roots,
   #                                             input$files)))
})

runApp(list(
  ui=ui,
  server=server
))