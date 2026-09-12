# Script to download TikTok impression data to data/raw folder
library(here)

# Create data/raw directory if it doesn't exist relative to the project root
dir_path <- here("data", "raw")
if (!dir.exists(dir_path)) {
  dir.create(dir_path, recursive = TRUE)
  print("Data directory created: data/raw")
}

# Download the data
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/impressions.csv"
destination <- here("data", "raw", "impressions.csv")

print("Downloading data...")
download.file(url, destfile = destination)

print("Data downloaded successfully!")
print(paste("File saved to:", destination))
print(paste("File size:", file.size(destination), "bytes"))

