# File: R/plumber.R
library(plumber)

# Path to the CSV file
csv_path <- "../data/movies.csv"  # Adjust to your CSV path

# Endpoint to fetch top-rated movies
# @param n - Number of top movies to fetch
# @get /top_movies
function(n = 10) {
  # Read the CSV data
  movie_data <- read.csv(csv_path, stringsAsFactors = FALSE)
  
  # Order movies by rating (descending) and select top n
  top_movies <- head(movie_data[order(-movie_data$rating), ], as.integer(n))
  
  # Return the data as JSON
  list(movies = top_movies)
}
