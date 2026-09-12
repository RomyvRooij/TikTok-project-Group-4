# Script to visualize TikTok impression data

library(ggplot2)
library(tidyverse)
library(here)

# Create output directory relative to project root if needed
output_dir <- here("src", "tiktok-impression-analysis", "output")
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Load cleaned data using here()
impressions <- read.csv(here("data", "processed", "impressions_clean.csv"))

# Reusable base theme to eliminate code duplication
base_theme <- theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 13),
    panel.grid.minor = element_blank()
  )

# 1. Distribution of sources
plot1 <- impressions %>%
  mutate(source_bucket = fct_infreq(source_bucket)) %>%
  ggplot(aes(x = source_bucket)) +
  geom_bar(fill = "#2b5c8f") +
  base_theme +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Distribution of Feed Sources",
       x = "Source",
       y = "Count")
ggsave(here("src", "tiktok-impression-analysis", "output", "Plot_1_source_distribution.png"), plot1, width = 8, height = 6)

# 2. Ranking scores distribution
plot2 <- ggplot(impressions, aes(x = score_total)) +
  geom_histogram(bins = 30, fill = "#e07a5f", color = "white") +
  base_theme +
  labs(title = "Distribution of Ranking Scores",
       x = "Ranking Score",
       y = "Frequency")
ggsave(here("src", "tiktok-impression-analysis", "output", "Plot_2_ranking_scores_distribution.png"), plot2, width = 8, height = 6)

# 3. Ranking scores by source (boxplot)
plot3 <- impressions %>%
  mutate(source_bucket = fct_reorder(source_bucket, score_total, .fun = median)) %>%
  ggplot(aes(x = source_bucket, y = score_total, fill = source_bucket)) +
  geom_boxplot(show.legend = FALSE) +
  base_theme +
  scale_fill_viridis_d(option = "mako", begin = 0.3, end = 0.9) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Ranking Scores by Source",
       x = "Source",
       y = "Ranking Score")
ggsave(here("src", "tiktok-impression-analysis", "output", "Plot_3_ranking_by_source.png"), plot3, width = 8, height = 6)

# 4. Feed position distribution
plot4 <- ggplot(impressions, aes(x = feed_rank)) +
  geom_histogram(bins = 20, fill = "#81b29a", color = "white") +
  base_theme +
  labs(title = "Distribution of Feed Positions",
       x = "Position in Feed",
       y = "Count")
ggsave(here("src", "tiktok-impression-analysis", "output", "Plot_4_position_distribution.png"), plot4, width = 8, height = 6)