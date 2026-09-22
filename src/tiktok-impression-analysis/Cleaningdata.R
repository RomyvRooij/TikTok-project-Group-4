# Script to clean and inspect TikTok impression data
library(tidyverse)
library(here)

# Load data using here() to point to the project root
impressions <- read.csv(here("data", "raw", "impressions.csv"))

print("=== ORIGINAL DATA ===")
print(paste("Dimensions:", nrow(impressions), "rows,", ncol(impressions), "columns"))
print("\nFirst few rows:")
print(head(impressions))

# Basic cleaning
impressions_clean <- impressions %>%
  distinct() %>%
  drop_na(score_total, feed_rank, source_bucket)

print("\n=== AFTER CLEANING ===")
print(paste("Dimensions:", nrow(impressions_clean), "rows,", ncol(impressions_clean), "columns"))
print(paste("Rows removed:", nrow(impressions) - nrow(impressions_clean)))

print("\n=== MISSING VALUES ===")
print(colSums(is.na(impressions_clean)))

print("\n=== SOURCE DISTRIBUTION ===")
print(table(impressions_clean$source_bucket))

# Create processed directory if needed relative to project root
processed_dir <- here("data", "processed")
if (!dir.exists(processed_dir)) {
  dir.create(processed_dir, recursive = TRUE)
}

# Save cleaned data using here()
output_path <- here("data", "processed", "impressions_clean.csv")
write.csv(impressions_clean, output_path, row.names = FALSE)
print(paste("\n✓ Cleaned data saved to", output_path))

