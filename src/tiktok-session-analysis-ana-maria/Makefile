# TikTok Session Analysis Makefile

DATA = data/sessions.csv
OUTPUTS = output/session_duration.png \
          output/videos_viewed.png \
          output/watch_seconds.png \
          output/duration_vs_videos.png \
          output/sessions_over_time.png \
          output/sessions_by_user.png

# Default target: create all analysis outputs
all: $(OUTPUTS)

# Download the data only if sessions.csv does not exist
$(DATA):
	Rscript download.R

# Create all visualizations after the data is available
$(OUTPUTS): $(DATA)
	Rscript analysis.R