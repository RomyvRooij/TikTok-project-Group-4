library(tidyverse)
library(RSQLite)
library(here)

# ==============================================================================
# PART 1: DOWNLOAD DATA
# ==============================================================================

cat("=== DOWNLOADING DATA ===\n")

# Download SQLite file from the provided URL
url <- "https://filesender.surf.nl/download.php?token=29803da2-2322-4844-aebf-7e0b95129957&files_ids=38390042"
destination <- here("data", "raw", "tiktok_students.sqlite")

# Create data/raw directory if it doesn't exist relative to the project root
dir_path <- here("data", "raw")
if (!dir.exists(dir_path)) {
  dir.create(dir_path, recursive = TRUE)
  cat("Data directory created: data/raw\n")
}

# Check to see if the file already exists and otherwise download it:
if (!file.exists(destination)) {
  cat("Downloading SQLite database...\n")
  download.file(url, destfile = destination, mode = "wb")
  cat("Database downloaded successfully!\n")
  cat("File saved to:", destination, "\n")
  cat("File size:", file.size(destination), "bytes\n")
} else {
  cat("Database already exists at:", destination, "\n")
}

# Verify the download by listing tables
cat("\nVerifying database connection...\n")
con <- dbConnect(SQLite(), dbname = destination)
cat("Tables in database:\n")
print(dbListTables(con))

# ==============================================================================
# PART 2: LOAD DATA FROM DATABASE
# ==============================================================================

cat("\n=== LOADING DATA ===\n")

# Load all tables from the database
# (Update these table names based on what's actually in your database)
users <- dbReadTable(con, "users")
video_view <- dbReadTable(con, "video_view")

dbDisconnect(con)

cat("Data loaded successfully!\n")
cat("Users:", nrow(users), "rows\n")
cat("Video view:", nrow(video_view), "rows\n")

