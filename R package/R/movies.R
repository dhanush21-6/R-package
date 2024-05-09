# Install required packages if not already installed
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  install.packages("jsonlite")
}

# Load required libraries
library(jsonlite)

# Define a function to generate random movie data
generate_movie_data <- function(n) {
  set.seed(123)  # for reproducibility
  movie_titles <- c("The Matrix", "Inception", "The Shawshank Redemption", "Pulp Fiction", "Fight Club")
  movie_ratings <- runif(n, min = 5, max = 9)
  movie_data <- data.frame(title = sample(movie_titles, n, replace = TRUE),
                           rating = round(movie_ratings, 1))
  return(movie_data)
}

# Define a function to serve movie data as JSON
serve_movie_data <- function() {
  movie_data <- generate_movie_data(10)  # Generate 10 random movies
  json_data <- toJSON(movie_data)
  return(json_data)
}

# Run the script if called directly
if (interactive()) {
  movie_json <- serve_movie_data()
  cat(movie_json)
}

