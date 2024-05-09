server <- function(input, output) {
  output$hist <- renderPlot({
    hist(rnorm(input$num), main = "Random Normal Distribution", xlab = "Value", ylab = "Frequency")
  })
}

# Run the app
shinyApp(ui = ui, server = server)