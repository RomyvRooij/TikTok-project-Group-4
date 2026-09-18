library(tidyverse)
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/watch_events.csv"
watch_raw <- "data/raw/watch_events.csv"

#to create the folder when it isn't there yet
dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)

# Check to see if the file already exists and otherwise download it:
if (!file.exists(watch_raw)) {
  data <- read_csv(url)
  write_csv(data, watch_raw)
} else {
  data <- read_csv(watch_raw)
}

watch_events <- read_csv(watch_raw)