# **TikTok-project-template-2026**
This repository is a template for the **Data preparation and programming skills** course in fall 2026. 

## **GOAL of the project**
The goal of this project is to work together on the TikTok data in Positron with GitHub. 
We are analyzing the `video_view.csv` dataset to explore video performance, reach and viewing behaviour.  
The project focuses on downloading the data, preparing it, and performing an analysis to answer the research question of the project.

## **Set up the environment & install dependencies**
This project was developed using Positron.

To set up the project environment:

1. Install and open Positron.
2. Clone this Github repository to your computer.
3. Open the project folder in Positron. `TIKTOK-PROJECT-GROUP-4` in Positron.
4. Install the required packages by running:

```
    install.packages("tidyverse")
    install.packages("readr")
    install.packages("dplyr")
    install.packages("ggplot2")
    install.packages("here")
```

## **Reproducing the analysis**

The full project can be reproduced using the Makefile from the root of the repository.

Run in the terminal:

```
make
```

## **Group member and contributions**
*Tessa Breusers* 
- Made the data folder, added gitkeep because they were empty, wrote the whole README and set up folder structure.
- made the analysis section of users.

*Romy van Rooij* 
- Made the tiktok project, made a start on the Quarto summary, performed final updates on the README to improve clarity and structure.
- Made the analysis section of watch events and updated this README file afterwards.

*Ana Maria Iacob* 
- Completed the Quarto summary in summary.qmd, using the downloaded video data, saved it in the correct folder, and checked that it renders without errors. I also kept the project structure organized with the data in data/raw and the analysis files in src.
- made the analysis section of sessions. 

*Elsemieke van Gent* 
- Made the Downloaddata.R script and wrote the code for downloading the data. Added the .gitignore file and made sure that the data would not be tracked.
- made the analysis section of impressions. Also made sure the general Makefile runs smoothly and without errors.

## **Structure**
1. data
   - **raw/** — original downloaded data (ignored by Git)
   - **processed/** — reserved for cleaned/derived datasets (ignored by Git)

2. output
   - **impressions/** - the plots from the impression analysis
   - **sessions/** - the plots from the session analysis
   - **users/** the plots from the users analysis
   - **watch_events/** the plots from the watch_events analysis

3. src
   - ### `tiktok-impression-analysis/`
      #### Overview
      This folder inspects and analyzes TikTok feed impression data to evaluate content delivery and ranking mechanisms. Key aspects of the analysis include:
      - Mix of feed sources (e.g., followed, recommended, explore)
      - Distribution of total ranking scores across different feed sources
      - Analysis of feed position placement
      - Detection and removal of duplicated or malformed impressions
      #### Output
      Running the pipeline will automatically fetch the raw data, clean and process it, and save the generated visual reports to `output/impressions`:
      - `Plot_1_source_distribution.png`
      - `Plot_2_ranking_scores_distribution.png`
      - `Plot_3_ranking_by_source.png`
      - `Plot_4_position_distribution.png`

   - ### `tiktok-session-analysis/`
Contains the R scripts for downloading, cleaning, and visualization of the data. This folder also contains a README for this specific folder.
    #### Overview
   This folder inspects and analyzes TikTok session data to understand user engagement patterns and viewing habits across sessions. Key aspects of the analysis include:
   - Distribution of session durations
   - Number of sessions per user
   - Trends in session activity over time
   - Relationship between number of videos viewed and total watch time
   - Relationship between session duration and number of videos watched
   - Cleaning and preparation of the session data for analysis
     #### Output
   Running the pipeline will automatically fetch the raw data, clean and process it, and save the generated visual reports to `output/sessions`:
   - `session_duration.png` — distribution of how long sessions typically last.
   - `sessions_by_user.png` — number of sessions per user, highlighting more and less active users.
   - `sessions_over_time.png` — session activity trends over time.
   - `videos_viewed.png` — how many videos are watched in a typical session.
   - `videos_vs_watch_time.png` — whether watching more videos also means watching longer overall.
   - `duration_vs_videos.png` — whether longer sessions tend to include more videos.
   - `watch_seconds.png` — total watch time per session, in seconds.


   - ### `tiktok-user-analysis/`
    - - contains the R scripts for downloading, cleaning, and visualization of the data. This folder also contains a README for this specific folder. 
      #### Overview

      #### Output


   - ### `tiktok_watch_events-analysis/`
      #### Overview
      This folder inspects and analyzes TikTok watch event data to understand how users react to videos and how viewing behaviour relates to video characteristics. Key aspects of the analysis include:
      - Distribution of user actions (e.g., watched in full, skipped immediately, skipped after partially watching, exited the platform)
      - Normalisation of mixed timestamp formats in `started_at_raw`
      - Validation of the cleaned timestamps against the provided `started_at` variable
      - Analysis of watch behaviour in relation to video length
      - Cleaning and preparation of the watch event data for analysis
      #### Output
      Running the pipeline will automatically fetch the raw data, clean and process it, and save the generated visual reports to `output/watch_events`:
      - `action_distribution.png`
      - `watch_share_by_video_length.png`

   - Downloaddata.R — script to download the dataset
   - summary.qmd — Quarto file that reads the data and produces the summary
   - summary.html — rendered output of `summary.qmd`

4. .gitignore (ensures the data folder is not tracked by Git)
4. AI.md (description of AI usage)
5. README.md (explains the whole project)

Note: the data folder is excluded from Git via .gitignore, so raw and processed data files are never committed. Empty subfolders are kept using .gitkeep placeholder files, since Git does not track empty directories.

Group 4