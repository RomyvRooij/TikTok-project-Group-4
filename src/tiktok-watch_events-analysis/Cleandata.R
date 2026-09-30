library(tidyverse)
library(lubridate)

# Define project paths once so they can be reused throughout the script
data_raw_dir <- "data/raw"
data_processed_dir <- "data/processed"

dir.create(data_processed_dir, recursive = TRUE, showWarnings = FALSE)

watch_raw <- file.path(data_raw_dir, "watch_events.csv")
watch_processed <- file.path(data_processed_dir, "watch_events_clean.csv")

watch_events <- read_csv(watch_raw)

# INSPECT DATA
glimpse(watch_events)
summary(watch_events)
names(watch_events)
colSums(is.na(watch_events))

# CLEAN DATA
# Use regular expressions to identify different timestamp formats
# before converting them into a consistent datetime format.
watch_events <- watch_events |>
  mutate(
    started_at_clean = case_when(
      # 10-digit Unix timestamp
      str_detect(started_at_raw, "^\\d{10}$") ~
        as_datetime(
          as.numeric(started_at_raw),
          tz = "UTC"
        ),

      # Timestamp formatted as YYYYMMDD HHMMSS
      str_detect(started_at_raw, "^\\d{8} \\d{6}$") ~
        parse_date_time(
          started_at_raw,
          orders = "Ymd HMS",
          tz = "UTC"
        ),

      # Handle remaining standard datetime formats
      TRUE ~ ymd_hms(
        started_at_raw,
        tz = "UTC"
      )
    )
  )

# Validate the cleaned timestamps against the provided started_at variable
timestamp_validation <- watch_events |>
  summarise(
    total_rows = n(),
    missing_cleaned = sum(is.na(started_at_clean)),
    matching_timestamps = sum(
      started_at_clean == started_at,
      na.rm = TRUE
    ),
    mismatching_timestamps = sum(
      started_at_clean != started_at,
      na.rm = TRUE
    ),
    match_rate = matching_timestamps / total_rows
  )

print(timestamp_validation)

# SAVE CLEANED DATA
write_csv(watch_events, watch_processed)

# Reload the saved dataset to verify that the output can be read successfully
watch_events_clean <- read_csv(watch_processed)