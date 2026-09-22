.PHONY: all user watch downloaddata impressions sessions clean

all: downloaddata user watch impressions sessions

# =====================
# Download data
# =====================

downloaddata: data/raw/video_view.csv

data/raw/video_view.csv: src/Downloaddata.R
	mkdir -p data/raw
	Rscript src/Downloaddata.R


# =====================
# User analysis
# =====================

user: output/users/average_preferences.png

output/users/average_preferences.png: data/processed/users_clean.csv src/tiktok-user-analysis/Visualize.R
	mkdir -p output/users
	Rscript src/tiktok-user-analysis/Visualize.R

data/processed/users_clean.csv: data/raw/users.csv src/tiktok-user-analysis/Cleandata.R
	mkdir -p data/processed
	Rscript src/tiktok-user-analysis/Cleandata.R

data/raw/users.csv: src/tiktok-user-analysis/Downloaddata.R
	mkdir -p data/raw
	Rscript src/tiktok-user-analysis/Downloaddata.R


# =====================
# Watch events analysis
# =====================

watch: output/watch_events/action_distribution.png output/watch_events/watch_share_by_video_length.png

output/watch_events/action_distribution.png output/watch_events/watch_share_by_video_length.png: \
	data/processed/watch_events_clean.csv data/raw/video_view.csv \
	src/Tiktok-watch_events-analysis/Visualization.R
	mkdir -p output/watch_events
	Rscript src/Tiktok-watch_events-analysis/Visualization.R

data/processed/watch_events_clean.csv: data/raw/watch_events.csv src/Tiktok-watch_events-analysis/Cleandata.R
	mkdir -p data/processed
	Rscript src/Tiktok-watch_events-analysis/Cleandata.R

data/raw/watch_events.csv: src/Tiktok-watch_events-analysis/Downloaddata.R
	mkdir -p data/raw
	Rscript src/Tiktok-watch_events-analysis/Downloaddata.R


# =====================
# Impression analysis
# =====================

impressions: output/impressions/Plot_1_source_distribution.png output/impressions/Plot_2_ranking_scores_distribution.png \
	output/impressions/Plot_3_ranking_by_source.png output/impressions/Plot_4_position_distribution.png

output/impressions/Plot_1_source_distribution.png output/impressions/Plot_2_ranking_scores_distribution.png \
output/impressions/Plot_3_ranking_by_source.png output/impressions/Plot_4_position_distribution.png: \
	data/processed/impressions_clean.csv src/tiktok-impression-analysis/Visualization.R
	mkdir -p output/impressions
	Rscript src/tiktok-impression-analysis/Visualization.R

data/processed/impressions_clean.csv: data/raw/impressions.csv src/tiktok-impression-analysis/Cleaningdata.R
	mkdir -p data/processed
	Rscript src/tiktok-impression-analysis/Cleaningdata.R

data/raw/impressions.csv: src/tiktok-impression-analysis/Downloaddata.R
	mkdir -p data/raw
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
	mkdir -p output/sessions
	Rscript src/tiktok-session-analysis/analysis.R

data/processed/sessions_clean.csv: data/raw/sessions.csv src/tiktok-session-analysis/analysis.R
	mkdir -p data/processed
	Rscript src/tiktok-session-analysis/analysis.R

data/raw/sessions.csv: src/tiktok-session-analysis/download.R
	mkdir -p data/raw
	Rscript src/tiktok-session-analysis/download.R


# =====================
# Clean
# =====================

clean:
	rm -f data/raw/users.csv
	rm -f data/processed/users_clean.csv
	rm -f output/users/average_preferences.png
	rm -f data/raw/watch_events.csv
	rm -f data/raw/video_view.csv
	rm -f data/processed/watch_events_clean.csv
	rm -f output/watch_events/action_distribution.png
	rm -f output/watch_events/watch_share_by_video_length.png
	rm -f data/raw/impressions.csv
	rm -f data/processed/impressions_clean.csv
	rm -f output/impressions/Plot_1_source_distribution.png
	rm -f output/impressions/Plot_2_ranking_scores_distribution.png
	rm -f output/impressions/Plot_3_ranking_by_source.png
	rm -f output/impressions/Plot_4_position_distribution.png
	rm -f data/raw/sessions.csv
	rm -f data/processed/sessions_clean.csv
	rm -f output/sessions/session_duration.png
	rm -f output/sessions/videos_viewed.png
	rm -f output/sessions/watch_seconds.png
	rm -f output/sessions/duration_vs_videos.png
	rm -f output/sessions/sessions_over_time.png
	rm -f output/sessions/sessions_by_user.png
	rm -f output/sessions/videos_vs_watch_time.png