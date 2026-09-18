#User analysis
all: output/average_preferences.png

data/raw/users.csv: src/tiktok-user-analysis/Downloaddata.R
	Rscript -e "source('src/tiktok-user-analysis/Downloaddata.R')"

data/processed/users_clean.csv: data/raw/users.csv src/tiktok-user-analysis/Cleandata.R
	Rscript -e "source('src/tiktok-user-analysis/Cleandata.R')"

output/average_preferences.png: data/processed/users_clean.csv src/tiktok-user-analysis/Visualize.R
	Rscript -e "source('src/tiktok-user-analysis/Visualize.R')"

clean:
	rm -rf data/raw data/processed output

#Watch events analysis
all:	src/Tiktokwatchevents/outputwatchevents/action_distribution.png \
    src/Tiktokwatchevents/outputwatchevents/watch_share_by_video_length.png

src/Tiktokwatchevents/outputwatchevents/action_distribution.png \
src/Tiktokwatchevents/outputwatchevents/watch_share_by_video_length.png: \
	data/processed/watch_events_clean.csv \
	data/raw/video_view.csv
	Rscript src/Tiktokwatchevents/Visualization.R

data/processed/watch_events_clean.csv: data/raw/watch_events.csv
	Rscript src/Tiktokwatchevents/Cleandata.R

data/raw/watch_events.csv:
	Rscript src/Tiktokwatchevents/Downloaddata.R
clean:
	rm -f data/raw/watch_events.csv
	rm -f data/processed/watch_events_clean.csv
	rm -f src/Tiktokwatchevents/outputwatchevents/action_distribution.png
	rm -f src/Tiktokwatchevents/outputwatchevents/watch_share_by_video_length.png
	
#Impression analysis
all: output/Plot_1_source_distribution.png \
     output/Plot_2_ranking_scores_distribution.png \
     output/Plot_3_ranking_by_source.png \
     output/Plot_4_position_distribution.png

data/raw/impressions.csv: Downloaddata.R
	Rscript Downloaddata.R

data/processed/impressions_clean.csv: data/raw/impressions.csv Cleaningdata.R
	Rscript Cleaningdata.R

	output/Plot_1_source_distribution.png \
	output/Plot_2_ranking_scores_distribution.png \
	output/Plot_3_ranking_by_source.png \
	output/Plot_4_position_distribution.png: ../../data/processed/impressions_clean.csv Visualization.R
	Rscript Visualization.R

clean:
	rm -f data/raw/impressions.csv
	rm -f data/processed/impressions_clean.csv
	rm -rf output

#Session analysis
all: data/processed/sessions_clean.csv \
     output/session_duration.png \
     output/videos_viewed.png \
     output/watch_seconds.png \
     output/duration_vs_videos.png \
     output/sessions_over_time.png \
     output/sessions_by_user.png \
     output/videos_vs_watch_time.png

data/raw/sessions.csv: download.R
	Rscript download.R

data/processed/sessions_clean.csv \
	output/session_duration.png \
	output/videos_viewed.png \
	output/watch_seconds.png \
	output/duration_vs_videos.png \
	output/sessions_over_time.png \
	output/sessions_by_user.png \
	output/videos_vs_watch_time.png: \
analysis.R \
data/raw/sessions.csv
	Rscript analysis.R

clean:
	rm -f output/*.png
	rm -f data/processed/sessions_clean.csv
	rm -f data/raw/sessions.csv
