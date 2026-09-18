.PHONY: all user watch impressions sessions clean

all: user watch impressions sessions

# =====================
# User analysis
# =====================

user: output/average_preferences.png

output/average_preferences.png: data/processed/users_clean.csv src/tiktok-user-analysis/Visualize.R
	mkdir -p output
	Rscript -e "source('src/tiktok-user-analysis/Visualize.R')"

data/processed/users_clean.csv: data/raw/users.csv src/tiktok-user-analysis/Cleandata.R
	mkdir -p data/processed
	Rscript -e "source('src/tiktok-user-analysis/Cleandata.R')"

data/raw/users.csv: src/tiktok-user-analysis/Downloaddata.R
	mkdir -p data/raw
	Rscript -e "source('src/tiktok-user-analysis/Downloaddata.R')"


# =====================
# Watch events analysis
# =====================

watch: \
	output/action_distribution.png \
	output/watch_share_by_video_length.png

output/action_distribution.png \
output/watch_share_by_video_length.png: \
	data/processed/watch_events_clean.csv \
	data/raw/video_view.csv \
	src/Tiktokwatchevents/Visualization.R
	mkdir -p output
	Rscript src/Tiktokwatchevents/Visualization.R

data/processed/watch_events_clean.csv: data/raw/watch_events.csv src/Tiktokwatchevents/Cleandata.R
	mkdir -p data/processed
	Rscript src/Tiktokwatchevents/Cleandata.R

data/raw/watch_events.csv data/raw/video_view.csv: src/Tiktokwatchevents/Downloaddata.R
	mkdir -p data/raw
	Rscript src/Tiktokwatchevents/Downloaddata.R


# =====================
# Impression analysis
# =====================

impressions: \
	output/Plot_1_source_distribution.png \
	output/Plot_2_ranking_scores_distribution.png \
	output/Plot_3_ranking_by_source.png \
	output/Plot_4_position_distribution.png

data/raw/impressions.csv: Downloaddata.R
	mkdir -p data/raw
	Rscript Downloaddata.R

data/processed/impressions_clean.csv: data/raw/impressions.csv Cleaningdata.R
	mkdir -p data/processed
	Rscript Cleaningdata.R

output/Plot_1_source_distribution.png \
output/Plot_2_ranking_scores_distribution.png \
output/Plot_3_ranking_by_source.png \
output/Plot_4_position_distribution.png: data/processed/impressions_clean.csv Visualization.R
	mkdir -p output
	Rscript Visualization.R


# =====================
# Session analysis
# =====================

sessions: \
	data/processed/sessions_clean.csv \
	output/session_duration.png \
	output/videos_viewed.png \
	output/watch_seconds.png \
	output/duration_vs_videos.png \
	output/sessions_over_time.png \
	output/sessions_by_user.png \
	output/videos_vs_watch_time.png

data/raw/sessions.csv: download.R
	mkdir -p data/raw
	Rscript download.R

data/processed/sessions_clean.csv \
output/session_duration.png \
output/videos_viewed.png \
output/watch_seconds.png \
output/duration_vs_videos.png \
output/sessions_over_time.png \
output/sessions_by_user.png \
output/videos_vs_watch_time.png: analysis.R data/raw/sessions.csv
	mkdir -p data/processed output
	Rscript analysis.R


# =====================
# Clean
# =====================

clean:
	rm -f data/raw/users.csv
	rm -f data/processed/users_clean.csv
	rm -f output/average_preferences.png
	rm -f data/raw/watch_events.csv
	rm -f data/raw/video_view.csv
	rm -f data/processed/watch_events_clean.csv
	rm -f src/Tiktokwatchevents/outputwatchevents/action_distribution.png
	rm -f src/Tiktokwatchevents/outputwatchevents/watch_share_by_video_length.png
	rm -f data/raw/impressions.csv
	rm -f data/processed/impressions_clean.csv
	rm -f output/Plot_*.png
	rm -f data/raw/sessions.csv
	rm -f data/processed/sessions_clean.csv
	rm -f output/session_duration.png
	rm -f output/videos_viewed.png
	rm -f output/watch_seconds.png
	rm -f output/duration_vs_videos.png
	rm -f output/sessions_over_time.png
	rm -f output/sessions_by_user.png
	rm -f output/videos_vs_watch_time.png
