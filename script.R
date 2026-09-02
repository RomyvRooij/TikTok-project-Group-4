library("tidyverse")
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/video_view.csv"
destination <- "data/raw/video_view.csv"

# Check to see if the file already exists and otherwise download it:
if (!file.exists(destination)) {
  data <- read_csv(url)
  write_csv(data, destination)
} else {
  data <- read_csv(destination)
}