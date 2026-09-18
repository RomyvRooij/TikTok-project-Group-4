.PHONY: all user watch downloaddata impressions sessions clean

all: user watch downloaddata impressions sessions

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

user: output/average_preferences.png

output/average_preferences.png: data/processed/users_clean.csv src/tiktok-user-analysis/Visualize.R
	mkdir -p output
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

watch: output/action_distribution.png output/watch_share_by_video_length.png

output/action_distribution.png output/watch_share_by_video_length.png: \
	data/processed/watch_events_clean.csv data/raw/video_view.csv \
	src/Tiktokwatchevents/Visualization.R
	mkdir -p output
	Rscript src/Tiktokwatchevents/Visualization.R

data/processed/watch_events_clean.csv: data/raw/watch_events.csv src/Tiktokwatchevents/Cleandata.R
	mkdir -p data/processed
	Rscript src/Tiktokwatchevents/Cleandata.R

data/raw/watch_events.csv: src/Tiktokwatchevents/Downloaddata.R
	mkdir -p data/raw
	Rscript src/Tiktokwatchevents/Downloaddata.R


# =====================
# Impression analysis
# =====================

impressions: output/Plot_1_source_distribution.png output/Plot_2_ranking_scores_distribution.png \
	output/Plot_3_ranking_by_source.png output/Plot_4_position_distribution.png

output/Plot_1_source_distribution.png output/Plot_2_ranking_scores_distribution.png \
output/Plot_3_ranking_by_source.png output/Plot_4_position_distribution.png: \
	data/processed/impressions_clean.csv src/tiktok-impression-analysis/Visualization.R
	mkdir -p output
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

sessions: data/processed/sessions_clean.csv output/session_duration.png output/videos_viewed.png \
	output/watch_seconds.png output/duration_vs_videos.png output/sessions_over_time.png \
	output/sessions_by_user.png output/videos_vs_watch_time.png

output/session_duration.png output/videos_viewed.png output/watch_seconds.png \
output/duration_vs_videos.png output/sessions_over_time.png output/sessions_by_user.png \
output/videos_vs_watch_time.png: data/processed/sessions_clean.csv src/tiktok-session-analysis-ana-maria/analysis.R
	mkdir -p output
	Rscript src/tiktok-session-analysis-ana-maria/analysis.R

data/processed/sessions_clean.csv: data/raw/sessions.csv src/tiktok-session-analysis-ana-maria/analysis.R
	mkdir -p data/processed
	Rscript src/tiktok-session-analysis-ana-maria/analysis.R

data/raw/sessions.csv: src/tiktok-session-analysis-ana-maria/download.R
	mkdir -p data/raw
	Rscript src/tiktok-session-analysis-ana-maria/download.R


# =====================
# Clean
# =====================

clean:
	rm -f data/raw/users.csv
	rm -f data/processed/users_clean.csv
	rm -f output/user_analysis/average_preferences.png
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