.PHONY: all user watch downloaddata impressions sessions clean

all: downloaddata user watch impressions sessions

# Cross-platform helpers
MKDIR = Rscript -e "dir.create('$(1)', recursive = TRUE, showWarnings = FALSE)"
RM = Rscript -e "unlink('$(1)', force = TRUE)"


# =====================
# Download data
# =====================

downloaddata: data/raw/video_view.csv

data/raw/video_view.csv: src/Downloaddata.R
	$(call MKDIR,data/raw)
	Rscript src/Downloaddata.R


# =====================
# User analysis
# =====================

user: output/users/average_preferences.png

output/users/average_preferences.png: data/processed/users_clean.csv src/tiktok-user-analysis/Visualize.R
	$(call MKDIR,output/users)
	Rscript src/tiktok-user-analysis/Visualize.R

data/processed/users_clean.csv: data/raw/users.csv src/tiktok-user-analysis/Cleandata.R
	$(call MKDIR,data/processed)
	Rscript src/tiktok-user-analysis/Cleandata.R

data/raw/users.csv: src/tiktok-user-analysis/Downloaddata.R
	$(call MKDIR,data/raw)
	Rscript src/tiktok-user-analysis/Downloaddata.R


# =====================
# Watch events analysis
# =====================

watch: output/watch_events/action_distribution.png output/watch_events/watch_share_by_video_length.png

output/watch_events/action_distribution.png output/watch_events/watch_share_by_video_length.png: \
	data/processed/watch_events_clean.csv data/raw/video_view.csv \
	src/Tiktok-watch_events-analysis/Visualization.R
	$(call MKDIR,output/watch_events)
	Rscript src/Tiktok-watch_events-analysis/Visualization.R

data/processed/watch_events_clean.csv: data/raw/watch_events.csv src/Tiktok-watch_events-analysis/Cleandata.R
	$(call MKDIR,data/processed)
	Rscript src/Tiktok-watch_events-analysis/Cleandata.R

data/raw/watch_events.csv: src/Tiktok-watch_events-analysis/Downloaddata.R
	$(call MKDIR,data/raw)
	Rscript src/Tiktok-watch_events-analysis/Downloaddata.R


# =====================
# Impression analysis
# =====================

impressions: output/impressions/Plot_1_source_distribution.png output/impressions/Plot_2_ranking_scores_distribution.png \
	output/impressions/Plot_3_ranking_by_source.png output/impressions/Plot_4_position_distribution.png

output/impressions/Plot_1_source_distribution.png output/impressions/Plot_2_ranking_scores_distribution.png \
output/impressions/Plot_3_ranking_by_source.png output/impressions/Plot_4_position_distribution.png: \
	data/processed/impressions_clean.csv src/tiktok-impression-analysis/Visualization.R
	$(call MKDIR,output/impressions)
	Rscript src/tiktok-impression-analysis/Visualization.R

data/processed/impressions_clean.csv: data/raw/impressions.csv src/tiktok-impression-analysis/Cleaningdata.R
	$(call MKDIR,data/processed)
	Rscript src/tiktok-impression-analysis/Cleaningdata.R

data/raw/impressions.csv: src/tiktok-impression-analysis/Downloaddata.R
	$(call MKDIR,data/raw)
	Rscript src/tiktok-impression-analysis/Downloaddata.R


# =====================
# Session analysis
# =====================

sessions: data/processed/sessions_clean.csv output/sessions/session_duration.png output/sessions/videos_viewed.png \
	output/sessions/watch_seconds.png output/sessions/duration_vs_videos.png output/sessions/sessions_over_time.png \
	output/sessions/sessions_by_user.png output/sessions/videos_vs_watch_time.png

output/sessions/session_duration.png output/sessions/videos_viewed.png output/sessions/watch_seconds.png \
output/sessions/duration_vs_videos.png output/sessions/sessions_over_time.png output/sessions/sessions_by_user.png \
output/sessions/videos_vs_watch_time.png: data/processed/sessions_clean.csv src/tiktok-session-analysis/analysis.R
	$(call MKDIR,output/sessions)
	Rscript src/tiktok-session-analysis/analysis.R

data/processed/sessions_clean.csv: data/raw/sessions.csv src/tiktok-session-analysis/analysis.R
	$(call MKDIR,data/processed)
	Rscript src/tiktok-session-analysis/analysis.R

data/raw/sessions.csv: src/tiktok-session-analysis/download.R
	$(call MKDIR,data/raw)
	Rscript src/tiktok-session-analysis/download.R


# =====================
# Clean
# =====================

clean:
	$(call RM,data/raw/users.csv)
	$(call RM,data/processed/users_clean.csv)
	$(call RM,output/users/average_preferences.png)
	$(call RM,data/raw/watch_events.csv)
	$(call RM,data/raw/video_view.csv)
	$(call RM,data/processed/watch_events_clean.csv)
	$(call RM,output/watch_events/action_distribution.png)
	$(call RM,output/watch_events/watch_share_by_video_length.png)
	$(call RM,data/raw/impressions.csv)
	$(call RM,data/processed/impressions_clean.csv)
	$(call RM,output/impressions/Plot_1_source_distribution.png)
	$(call RM,output/impressions/Plot_2_ranking_scores_distribution.png)
	$(call RM,output/impressions/Plot_3_ranking_by_source.png)
	$(call RM,output/impressions/Plot_4_position_distribution.png)
	$(call RM,data/raw/sessions.csv)
	$(call RM,data/processed/sessions_clean.csv)
	$(call RM,output/sessions/session_duration.png)
	$(call RM,output/sessions/videos_viewed.png)
	$(call RM,output/sessions/watch_seconds.png)
	$(call RM,output/sessions/duration_vs_videos.png)
	$(call RM,output/sessions/sessions_over_time.png)
	$(call RM,output/sessions/sessions_by_user.png)
	$(call RM,output/sessions/videos_vs_watch_time.png)
