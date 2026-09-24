#Regression analysis

library(dplyr)
library(ggplot2)

# 1. Watch events samenvatten per impression
watch_summary <- watch_events %>%
  group_by(impression_id) %>%
  summarise(
    watch_seconds = sum(watch_seconds, na.rm = TRUE),
    .groups = "drop"
  )

# 2. Join impressions met watch data
reg_data <- impressions %>%
  left_join(watch_summary, by = "impression_id") %>%
  mutate(
    watch_seconds = ifelse(is.na(watch_seconds), 0, watch_seconds),
    source_bucket = as.factor(source_bucket),
    user_id = as.factor(user_id)
  )

# 3. Simpel regression
model1 <- lm(watch_seconds ~ score_total, data = reg_data)
summary(model1)

# 4. Multiple regression
model2 <- lm(
  watch_seconds ~ score_total + feed_rank + score_category_match +
    score_creator_match + score_satiation_penalty + source_bucket,
  data = reg_data
)
summary(model2)

# 5. Model with user fixed effects
model3 <- lm(
  watch_seconds ~ score_total + feed_rank + score_category_match +
    score_creator_match + score_satiation_penalty + source_bucket + user_id,
  data = reg_data
)
summary(model3)

# 6. Plot: relation between score_total and watch_seconds
ggplot(reg_data, aes(x = score_total, y = watch_seconds)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "lm", color = "blue") +
  labs(
    title = "Relation between recommendation score and watch time",
    x = "Score total",
    y = "Watch seconds"
  )

# 7. Residual plot
plot(model2)
