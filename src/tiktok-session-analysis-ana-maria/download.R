# Download TikTok session data

data_dir <- "data"

# Create data folder if it does not exist
dir.create(data_dir, showWarnings = FALSE)

# URL of the session data
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/sessions.csv"

# Download the data
download.file(
  url,
  destfile = file.path(data_dir, "sessions.csv"),
  mode = "wb"
)