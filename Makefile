all: output/average_preferences.png

# Download raw data if it does not exist
data/raw/users.csv: src/Tessa/Downloaddata.R
	Rscript -e "source('src/Tessa/Downloaddata.R')"

# Clean data if processed file does not exist or raw data changed
data/processed/users_clean.csv: data/raw/users.csv src/Tessa/Cleandata.R
	Rscript -e "source('src/Tessa/Cleandata.R')"

# Create visualization if plot does not exist or processed data changed
output/average_preferences.png: data/processed/users_clean.csv src/Tessa/Visualize.R
	Rscript -e "source('src/Tessa/Visualize.R')"

clean:
	rm -rf data/raw data/processed output

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
	
