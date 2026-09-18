all: ../../data/processed/sessions_clean.csv \
     output/session_duration.png \
     output/videos_viewed.png \
     output/watch_seconds.png \
     output/duration_vs_videos.png \
     output/sessions_over_time.png \
     output/sessions_by_user.png \
     output/videos_vs_watch_time.png

../../data/raw/sessions.csv: download.R
	Rscript download.R

../../data/processed/sessions_clean.csv \
output/session_duration.png \
output/videos_viewed.png \
output/watch_seconds.png \
output/duration_vs_videos.png \
output/sessions_over_time.png \
output/sessions_by_user.png \
output/videos_vs_watch_time.png: \
analysis.R \
../../data/raw/sessions.csv
	Rscript analysis.R

clean:
	rm -f output/*.png
	rm -f ../../data/processed/sessions_clean.csv
	rm -f ./../data/raw/sessions.csv
