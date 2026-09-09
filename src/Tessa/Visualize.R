# Visualize users data

# Load packages
library(ggplot2)
library(dplyr)
library(tidyr)

# Load processed data
users <- read.csv("data/processed/users_clean.csv")

# Select preference columns
pref_cols <- c(
  "pref_comedy",
  "pref_dance",
  "pref_beautyfashion",
  "pref_food",
  "pref_fitnesssports",
  "pref_gaming",
  "pref_diyhome",
  "pref_travel",
  "pref_education",
  "pref_pets"
)

# Calculate average preference per category
avg_preferences <- data.frame(
  category = pref_cols,
  mean_preference = colMeans(users[pref_cols])
)

avg_preferences
# Create plot
plot_preferences <- ggplot(avg_preferences, aes(x = category, y = mean_preference)) +
  geom_col(fill = "steelblue") + coord_flip() + 
  labs(
    title = "Average user preference by content category",
    x = "Content category",
    y = "Average preference score"
  ) +
  theme_minimal()

# Save plot
ggsave(
  filename = "output/average_preferences.png",
  plot = plot_preferences,
  width = 8,
  height = 5,
  dpi = 300
)

plot_preferences
