library(tidyverse)
library(lubridate)

url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/watch_events.csv"
watch <- "data/raw/watch_events.csv"

#to create the folder when it isn't there yet
dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)

# Check to see if the file already exists and otherwise download it:
if (!file.exists(watch)) {
  data <- read_csv(url)
  write_csv(data, watch)
} else {
  data <- read_csv(watch)}

watch_events <- read_csv(watch)

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

#CREATE DATA FOLDER
dir.create("src/Tiktokwatchevents/outputwatchevents", recursive = TRUE, showWarnings = FALSE)

# VISUALIZATION 1) Action counts
action_plot <- watch_events |>
  ggplot(aes(x = action, fill = action)) +
  geom_bar() +
  scale_fill_manual(values = c("exit_platform" = "#FF6B6B",
      "skip_after_partial" = "#A8DADC",
      "skip_immediate" = "#00B4D8",
      "watch_full" = "#C77DFF")) +
  scale_x_discrete(
    labels = c(
      "exit_platform" = "Exit platform",
      "skip_after_partial" = "Skipped later",
      "skip_immediate" = "Skipped immediately",
      "watch_full" = "Watched full video")) +
  theme_minimal() + theme(legend.position = "none", axis.text.x = element_text(angle = 20, hjust = 1)) +
  labs(title = "How users reacted to videos",
    subtitle = "distribution of viewing actions",
    x = NULL, y = "Number of watch events")

ggsave(
  filename = "src/Tiktokwatchevents/outputwatchevents/action_distribution.png",
  plot = action_plot,
  width = 8,
  height = 5)

# VISUALIZATION 2: Watch time vs video length
video_view <- read_csv("data/raw/video_view.csv")

watch_length_data <- watch_events |>
  left_join(video_view |>
      select(video_id, video_length_sec),
    by = "video_id") |>
  filter(!is.na(watch_seconds),
    !is.na(video_length_sec),
    video_length_sec > 0) |>
  mutate(watch_share = pmin(watch_seconds / video_length_sec, 1))

#calculate average share watched for each video length
watch_length_summary <- watch_length_data |>
  group_by(video_length_sec) |>
  summarise(
    avg_watch_share = mean(watch_share),
    .groups = "drop")

#plot
watch_length_plot <- watch_length_summary |>
  ggplot(aes(
    x = video_length_sec,
    y = avg_watch_share)) +
  geom_point(size = 2.5, color = "#A8DADC") +
  geom_smooth(
    method = "loess",
    se = FALSE,
    linewidth = 1.3,
    color = "#E75480") +
  scale_y_continuous(
    labels = scales::percent) +
  theme_minimal() +
  labs(
    title = "Do long TikToks retain viewers less effectively?",
    subtitle = "Average percentage of each video watched by video length",
    x = "Video length (seconds)",
    y = "Average share watched")

ggsave(
  filename = "src/Tiktokwatchevents/outputwatchevents/watch_share_by_video_length.png",
  plot = watch_length_plot,
  width = 8,
  height = 5)