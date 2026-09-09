# Script to clean and inspect TikTok impression data

library(tidyverse)
# Load data
impressions <- read.csv("data/raw/impressions.csv")

print("=== ORIGINAL DATA ===")
print(paste("Dimensions:", nrow(impressions), "rows,", ncol(impressions), "columns"))
print("\nFirst few rows:")
print(head(impressions))

# Basic cleaning
impressions_clean <- impressions %>%
  distinct() %>%
  filter(if_any(everything(), ~ !is.na(.)))

print("\n=== AFTER CLEANING ===")
print(paste("Dimensions:", nrow(impressions_clean), "rows,", ncol(impressions_clean), "columns"))
print(paste("Rows removed:", nrow(impressions) - nrow(impressions_clean)))

print("\n=== MISSING VALUES ===")
print(colSums(is.na(impressions_clean)))

print("\n=== SOURCE DISTRIBUTION ===")
print(table(impressions_clean$source))

print("\n=== TIMESTAMP CHECK ===")
print(paste("Missing timestamps:", sum(is.na(impressions_clean$shown_at))))
print(paste("First timestamp:", impressions_clean$shown_at[1]))
print(paste("Last timestamp:", impressions_clean$shown_at[nrow(impressions_clean)]))

# Create processed directory if needed
if (!dir.exists("data/processed")) {
  dir.create("data/processed", recursive = TRUE)
}

# Save cleaned data
write.csv(impressions_clean, "data/processed/impressions_clean.csv", row.names = FALSE)
print("\n✓ Cleaned data saved to data/processed/impressions_clean.csv")

