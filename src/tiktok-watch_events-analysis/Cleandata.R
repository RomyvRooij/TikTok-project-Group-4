library(tidyverse)
library(lubridate)

#to create the folder when it isn't there yet
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

watch_raw <- "data/raw/watch_events.csv"
watch_events <- read_csv(watch_raw)

#INSPECT DATA
glimpse(watch_events)
summary(watch_events)
names(watch_events)
colSums(is.na(watch_events))

#CLEAN DATA
#Fix the started_at_raw column to also look consistent like the started_at column
watch_events <- watch_events |>
  mutate(
    started_at_clean = case_when(
      str_detect(started_at_raw, "^\\d{10}$") ~
        as_datetime((as.numeric(started_at_raw)),
          tz = "UTC"),
      str_detect(started_at_raw, "^\\d{8} \\d{6}$") ~
        parse_date_time(
          started_at_raw,
          orders = "Ymd HMS",
          tz = "UTC"),
      TRUE ~ ymd_hms(started_at_raw, tz = "UTC")))

#check whether the normalisation worked
sum(is.na(watch_events$started_at_clean))
sum(watch_events$started_at_clean == watch_events$started_at)

# SAVE CLEANED DATA
write_csv(watch_events, "data/processed/watch_events_clean.csv")
watch_events_clean <- read_csv("data/processed/watch_events_clean.csv")