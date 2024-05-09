# Corrected file path with forward slashes
plumber_path <- "C:/MCA/R package/R/movies_api.R"

# Start the server on port 8000
library(plumber)
pr(plumber_path)$run(port = 5500)
