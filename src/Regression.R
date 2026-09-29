# TikTok User Behaviour Regression
# RQ: What predicts how many videos users consume during a TikTok session?

library(tidyverse)

sessions <-  read_csv("data/processed/sessions_clean.csv")
users <- read_csv("data/processed/users_clean.csv")
impressions <- read_csv("data/processed/impressions_clean.csv")
watch <- read_csv("data/processed/watch_events_clean.csv")

# Aggregate impression data to session level
# A session contains multiple impressions. We calculate the average category-match score per session
impressions_session <- impressions %>%
  group_by(session_id) %>%
  summarise(
    avg_category_match = mean(score_category_match, na.rm = TRUE),
    .groups = "drop")

# Aggregate watch-event data to session level
# Calculate the proportion of videos that were watched fully within each session.
watch_session <- watch %>%
  group_by(session_id) %>%
  summarise(
    full_watch_rate = mean(action == "watch_full", na.rm = TRUE),
    .groups = "drop")

# Combine all four datasets
regression_data <- sessions %>%
  left_join(
    users %>%
      select(
        user_id,
        base_videos_watched_mean),
    by = "user_id") %>%
  left_join(impressions_session, by = "session_id") %>%
  left_join(watch_session, by = "session_id")

# Keep only the variables required for analysis
regression_complete <- regression_data %>%
  select(videos_viewed, 
        session_duration_sec,
        base_videos_watched_mean,
        avg_category_match,
        full_watch_rate) %>%
  drop_na()

# Correlation of interest
cor(regression_complete$videos_viewed, 
    regression_complete$session_duration_sec)

correlation_matrix <- cor(
  regression_complete,
  use = "complete.obs"
)

correlation_matrix


# Starter model
model1 <- lm(videos_viewed ~ session_duration_sec,
  data = regression_complete)

summary(model1)

# Expanded model
model2 <- lm(
  videos_viewed ~
    session_duration_sec +
    base_videos_watched_mean +
    avg_category_match +
    full_watch_rate,
  data = regression_complete)

summary(model2)

# Compare models
summary(model1)$r.squared
summary(model2)$r.squared

summary(model1)$adj.r.squared
summary(model2)$adj.r.squared

anova(model1, model2)

# Plot
regression_plot <- ggplot(regression_complete,
      aes(x= session_duration_sec/60,
          y= videos_viewed))+
  geom_point(
    alpha=0.2,
    color = "Pink") +
  geom_smooth(
    method = "lm",
    se= TRUE,
    color = "blue",
    linewidth = 1.2) +
  theme_minimal()+
  labs(
    title = "Do longer Tiktok sessions include more videos?",
    subtitle = "Relationship between session duration and videos viewed",
    x = "session duration (minutes)",
    y= "Videos viewed")

regression_plot
