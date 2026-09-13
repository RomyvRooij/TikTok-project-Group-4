# TikTok Session Analysis

## About this project

This project looks at TikTok user session data. The data contains information about
different sessions, such as when a user logged in and logged out, how long the
session lasted, how many videos were viewed, and how many seconds the user watched. A session represents one visit to TikTok by a user. It starts when the user logs in
and ends when they log out. Each session records information such as the start and
end time, the session duration, the number of videos viewed, and the total number
of seconds watched.

The goal of the analysis is to better understand how users use TikTok during a
session. I look at session duration, the number of videos viewed, watch time,
and how the number of sessions changes over time.

## Files in this folder

### `download.R`

This script downloads the TikTok session data from the provided GitHub URL.

The script automatically creates the `data` folder if it does not already exist.
The downloaded `sessions.csv` file is then saved inside this folder.

### `analysis.R`

This script loads the downloaded session data and performs the analysis.

The data is checked and cleaned where needed. The script also creates several
visualizations using `ggplot2`. The plots are saved as PNG files in the
`output` folder using `ggsave()`.

### `Makefile`

The Makefile is used to run the scripts in the correct order.

It first makes sure that the session data is available. It then runs the analysis
when the required output files need to be created or updated. This means that
the scripts do not have to be run manually every time.

### `data`

This folder contains the downloaded `sessions.csv` file used for the analysis.

### `output`

This folder contains the PNG visualizations created by `analysis.R`.

## How to run the analysis

Make sure you are working in the `tiktok-session-analysis-ana-maria` folder before running the scripts.

### Option 1: Run the scripts separately

First, download the data by running `source("download.R")` in R. This downloads the session data and saves it as `data/sessions.csv`.

Then, run the analysis by using `source("analysis.R")` in R. This loads and cleans the data, performs the analysis, and creates the visualizations in the `output` folder.

### Option 2: Use the Makefile

You can also run the analysis using the Makefile. Open the Terminal in the `tiktok-session-analysis-ana-maria` folder and run `make`. The Makefile checks which files are already available and runs the necessary scripts to create the required outputs.