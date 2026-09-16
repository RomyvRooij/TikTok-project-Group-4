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
	