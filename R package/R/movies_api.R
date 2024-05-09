# Load required libraries
library(shiny)
library(dplyr)  # For data manipulation

# Path to the CSV file
movie_csv_path <- "movies.csv"  # Adjust the path to your CSV file

# Define the Shiny user interface
ui <- fluidPage(
  titlePanel("Movie Database"),
  sidebarLayout(
    sidebarPanel(
      # Inputs for top movies and search
      numericInput("num_movies", "Number of Top Movies", 10, min = 1, max = 50),
      textInput("search_query", "Search Movies", ""),
      actionButton("search_btn", "Search"),
      
      # Inputs for adding a new movie
      textInput("movie_title", "Movie Title", ""),
      numericInput("movie_year", "Movie Year", 2020, min = 1900, max = 2100),
      numericInput("movie_rating", "Movie Rating", 7, min = 1, max = 10),
      actionButton("add_movie_btn", "Add Movie")
    ),
    mainPanel(
      h3("Top Movies"),
      tableOutput("top_movies"),  # Display top movies
      
      h3("Search Results"),
      tableOutput("search_results"),  # Display search results
      
      h3("Add New Movie"),
      textOutput("add_movie_result")  # Display the result of adding a new movie
    )
  )
)

# Define the Shiny server function
server <- function(input, output, session) {
  # Function to read the CSV file
  read_movies <- function() {
    if (file.exists(movie_csv_path)) {
      read.csv(movie_csv_path, stringsAsFactors = FALSE)
    } else {
      data.frame(title = character(), year = numeric(), rating = numeric())
    }
  }
  
  # Fetch top movies when the app starts or when 'num_movies' changes
  observe({
    req(input$num_movies)  # Require the input to be non-null
    movie_data <- read_movies()
    
    # Get top movies sorted by rating
    top_movies <- movie_data %>% arrange(desc(rating)) %>% head(as.integer(input$num_movies))
    
    output$top_movies <- renderTable({
      top_movies  # Display the top movies
    })
  })
  
  # Search movies by title when the 'search_btn' is clicked
  observeEvent(input$search_btn, {
    req(input$search_query)  # Require a search query
    movie_data <- read_movies()
    
    # Find movies with titles matching the search query
    matching_movies <- movie_data %>% filter(grepl(input$search_query, title, ignore.case = TRUE))
    
    output$search_results <- renderTable({
      matching_movies  # Display search results
    })
  })
  
  # Add a new movie when the 'add_movie_btn' is clicked
  observeEvent(input$add_movie_btn, {
    req(input$movie_title)  # Require a movie title
    
    # Create a new movie entry
    new_movie <- data.frame(
      title = input$movie_title,
      year = as.numeric(input$movie_year),
      rating = as.numeric(input$movie_rating),
      stringsAsFactors = FALSE
    )
    
    # Read the existing data
    movie_data <- read_movies()
    
    # Add the new movie and save to CSV
    movie_data <- bind_rows(movie_data, new_movie)
    write.csv(movie_data, movie_csv_path, row.names = FALSE)
    
    # Display success message
    output$add_movie_result <- renderText({
      paste("New movie added:", new_movie$title)
    })
  })
}

# Create and run the Shiny app
shinyApp(ui = ui, server = server)
