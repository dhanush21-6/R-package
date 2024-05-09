library(shiny)

ui <- fluidPage(
  titlePanel("Simple Shiny App"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("num", "Number of observations:", 10, 100, 30)
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)
