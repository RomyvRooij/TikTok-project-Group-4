all: src/Tiktokwatchevents/outputwatchevents/action_distribution.png \
     src/Tiktokwatchevents/outputwatchevents/watch_share_by_video_length.png

src/Tiktokwatchevents/outputwatchevents/action_distribution.png \
src/Tiktokwatchevents/outputwatchevents/watch_share_by_video_length.png: \
src/Tiktokwatchevents/scriptwatchevents.R \
data/raw/video_view.csv
	Rscript src/Tiktokwatchevents/scriptwatchevents.R

clean:
	rm -f src/Tiktokwatchevents/outputwatchevents/action_distribution.png
	rm -f src/Tiktokwatchevents/outputwatchevents/watch_share_by_video_length.png
	