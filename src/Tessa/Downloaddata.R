# R-script
getwd()

# Create data folder if it does not exist
dir.create("data", showWarnings = FALSE)

# Define URL and destination file
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/users.csv"
destination <- "data/users.csv"

# Download the data
download.file(url, destfile = destination, mode = "wb")

# Print confirmation
message("Data downloaded successfully to: ", destination)