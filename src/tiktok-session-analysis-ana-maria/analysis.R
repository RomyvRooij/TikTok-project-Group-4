# TikTok Session Analysis

library(tidyverse)

# -------------------------
# 1. Load data
# -------------------------

sessions <- read_csv("data/sessions.csv")


# -------------------------
# 2. Clean data
# -------------------------

sessions <- sessions %>%
  mutate(
    login_at = as.POSIXct(
      login_at,
      format = "%Y-%m-%dT%H:%M:%SZ",
      tz = "UTC"
    ),
    logout_at = as.POSIXct(
      logout_at,
      format = "%Y-%m-%dT%H:%M:%SZ",
      tz = "UTC"
    )
  ) %>%
  filter(
    !is.na(session_id),
    !is.na(user_id),
    !is.na(login_at),
    !is.na(logout_at),
    !is.na(session_duration_sec),
    !is.na(videos_viewed),
    !is.na(watch_seconds),
    session_duration_sec >= 0,
    videos_viewed >= 0,
    watch_seconds >= 0
  )

glimpse(sessions)
summary(sessions)

dir.create("output", showWarnings = FALSE)


# -------------------------
# 3. How long do sessions last?
# -------------------------

duration_plot <- ggplot(
  sessions,
  aes(x = session_duration_sec / 60)
) +
  geom_histogram(
    bins = 40,
    fill = "#B8A1E8"
  ) +
  geom_vline(
    xintercept = median(sessions$session_duration_sec / 60),
    linetype = "dashed",
    color = "#7B5AA6",
    linewidth = 1
  ) +
  labs(
    title = "How Long Do TikTok Sessions Last?",
    subtitle = "Distribution of session duration; dashed line shows the median",
    x = "Session duration (minutes)",
    y = "Number of sessions"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "#8A7A91"),
    panel.grid.minor = element_blank()
  )

ggsave(
  "output/session_duration.png",
  duration_plot,
  width = 8,
  height = 5
)


# -------------------------
# 4. How many videos are viewed?
# -------------------------

videos_plot <- ggplot(
  sessions,
  aes(x = videos_viewed)
) +
  geom_histogram(
    bins = 30,
    fill = "#C9B6F2"
  ) +
  geom_vline(
    xintercept = median(sessions$videos_viewed),
    linetype = "dashed",
    color = "#8E6BB8",
    linewidth = 1
  ) +
  labs(
    title = "How Many Videos Are Viewed per TikTok Session?",
    subtitle = "Distribution of videos viewed; dashed line shows the median",
    x = "Videos viewed",
    y = "Number of sessions"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "#8A7A91"),
    panel.grid.minor = element_blank()
  )

ggsave(
  "output/videos_viewed.png",
  videos_plot,
  width = 8,
  height = 5
)


# -------------------------
# 5. How much content is actually watched?
# -------------------------

watch_plot <- ggplot(
  sessions,
  aes(x = watch_seconds / 60)
) +
  geom_histogram(
    bins = 40,
    fill = "#F3A6C8"
  ) +
  geom_vline(
    xintercept = median(sessions$watch_seconds / 60),
    linetype = "dashed",
    color = "#C56B98",
    linewidth = 1
  ) +
  labs(
    title = "How Much Time Do Users Actually Spend Watching?",
    subtitle = "Distribution of watch time per session; dashed line shows the median",
    x = "Watch time (minutes)",
    y = "Number of sessions"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "#8A7A91"),
    panel.grid.minor = element_blank()
  )

ggsave(
  "output/watch_seconds.png",
  watch_plot,
  width = 8,
  height = 5
)


# -------------------------
# 6. Do longer sessions include more videos?
# -------------------------

duration_videos_plot <- ggplot(
  sessions,
  aes(
    x = session_duration_sec / 60,
    y = videos_viewed
  )
) +
  geom_bin2d(
    bins = 30
  ) +
  scale_fill_gradient(
    low = "#F8D7E6",
    high = "#9B6BC3",
    name = "Sessions"
  ) +
  geom_smooth(
    method = "lm",
    se = FALSE,
    color = "#B34D8C",
    linewidth = 1
  ) +
  labs(
    title = "Do Longer TikTok Sessions Include More Videos?",
    subtitle = "Darker areas show where sessions are most concentrated",
    x = "Session duration (minutes)",
    y = "Videos viewed"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "#8A7A91"),
    panel.grid.minor = element_blank()
  )

ggsave(
  "output/duration_vs_videos.png",
  duration_videos_plot,
  width = 8,
  height = 5
)


# -------------------------
# 7. How does session activity change over time?
# -------------------------

sessions_by_day <- sessions %>%
  mutate(date = as.Date(login_at)) %>%
  count(date)

sessions_time_plot <- ggplot(
  sessions_by_day,
  aes(x = date, y = n)
) +
  geom_line(
    color = "#E58FB1",
    linewidth = 1.2
  ) +
  geom_point(
    color = "#E58FB1",
    size = 2
  ) +
  labs(
    title = "How Does TikTok Session Activity Change Over Time?",
    subtitle = "Number of recorded sessions per day",
    x = "Date",
    y = "Number of sessions"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "#8A7A91"),
    panel.grid.minor = element_blank()
  )

ggsave(
  "output/sessions_over_time.png",
  sessions_time_plot,
  width = 8,
  height = 5
)


# -------------------------
# 8. How does session activity vary across users?
# -------------------------

sessions_by_user <- sessions %>%
  count(user_id, name = "sessions")

user_sessions_plot <- ggplot(
  sessions_by_user,
  aes(x = sessions)
) +
  geom_histogram(
    bins = 30,
    fill = "#D89BCB"
  ) +
  geom_vline(
    xintercept = median(sessions_by_user$sessions),
    linetype = "dashed",
    color = "#9A5C91",
    linewidth = 1
  ) +
  labs(
    title = "How Does Session Activity Vary Across Users?",
    subtitle = "Distribution of sessions per user; dashed line shows the median",
    x = "Number of sessions per user",
    y = "Number of users"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "#8A7A91"),
    panel.grid.minor = element_blank()
  )

ggsave(
  "output/sessions_by_user.png",
  user_sessions_plot,
  width = 8,
  height = 5
)