# **TikTok-project-template-2026**

This repository is a template for the **Data preparation and programming skills** course in fall 2026.

## **GOAL of the project**

The goal of this project is to work together on the TikTok data in Positron with GitHub. We are analyzing the `video_view.csv` dataset to explore video performance, reach and viewing behaviour.\
The project focuses on downloading the data, preparing it, and performing an analysis to answer the research question of the project.

## **Set up the environment & install dependencies**

This project was developed using Positron.

To set up the project environment:

1.  Install and open Positron.
2.  Clone this Github repository to your computer.
3.  Open the project folder in Positron. `TIKTOK-PROJECT-GROUP-4` in Positron.
4.  Install the required packages by running:

```         
install.packages(c("tidyverse", "readr", "dplyr", "ggplot2", "here", "lubridate"))
```

## **Reproducing the analysis**

The full project can be reproduced using the Makefile from the root of the repository.

Run in the terminal:

```         
make
```

To test whether it works from scrap you could also run:

```         
make clean
make 
```

# **Project Structure**

- TIKTOK-PROJECT-GROUP-4

  - data

    - processed

      - impressions_clean.csv

      - sessions_clean.csv

      - users_clean.csv

      - watch_events_clean.csv

    - raw

      - impressions.csv

      - sessions.csv

      - users.csv

      - video_view.csv

      - watch_events.csv

  - output

    - impressions

      - Plot_1_source_distribution.png

      - Plot_2_ranking_scores_distribution.png

      - Plot_3_ranking_by_source.png

      - Plot_4_position_distribution.png

    - sessions

      - duration_vs_videos.png

      - session_duration.png

      - sessions_by_user.png

      - sessions_over_time.png

      - videos_viewed.png

      - videos_vs_watch_time.png

      - watch_seconds.png

    - users

      - average_preferences.png

    - watch_events

      - action_distribution.png

      - watch_share_by_video_length.png

  - src

    - tiktok-impression-analysis

      - Downloaddata.R

      - Cleaningdata.R

      - Visualization.R

    - tiktok-session-analysis

      - download.R

      - analysis.R

    - tiktok-user-analysis

      - Downloaddata.R

      - Cleandata.R

      - Visualize.R

    - tiktok-watch_events-analysis

      - Downloaddata.R

      - Cleandata.R

      - Visualization.R

    - Downloaddata.R

    - summary.qmd

    - summary.html

  - .gitignore

  - AI.md

  - Makefile

  - README.md

# **About the analyses**

### ***TikTok Impression Analysis (src/tiktok-impression-analysis/)***

Inspects and analyzes TikTok feed impression data to evaluate content delivery and ranking mechanisms.

Key aspects:

- Mix of feed sources (e.g., followed, recommended, explore)

- Distribution of total ranking scores across different feed sources

- Analysis of feed position placement

- Detection and removal of duplicated or malformed impressions

Output files:

- Plot_1_source_distribution.png

- Plot_2_ranking_scores_distribution.png

- Plot_3_ranking_by_source.png

- Plot_4_position_distribution.png

### ***TikTok Session Analysis (src/tiktok-session-analysis/)***

Analyzes TikTok session data to understand user engagement patterns and viewing habits across sessions.

**Key aspects:**

- Distribution of session durations

- Number of sessions per user

- Trends in session activity over time

- Relationship between number of videos viewed and total watch time

- Relationship between session duration and number of videos watched

- Cleaning and preparation of the session data for analysis

**Output files:**

- session_duration.png — distribution of how long sessions typically last

- sessions_by_user.png — number of sessions per user, highlighting more and less active users

- sessions_over_time.png — session activity trends over time

- videos_viewed.png — how many videos are watched in a typical session

- videos_vs_watch_time.png — whether watching more videos also means watching longer overall

- duration_vs_videos.png — whether longer sessions tend to include more videos

- watch_seconds.png — total watch time per session, in seconds

### ***TikTok User Analysis (src/tiktok-user-analysis/)***

Analyzes user behavior and preferences in the TikTok project.

**Output files:**

- average_preferences.png — average user preferences across the platform

### ***TikTok Watch Events Analysis (src/tiktok-watch_events-analysis/)***

Analyzes TikTok watch event data to understand how users react to videos and how viewing behaviour relates to video characteristics.

**Key aspects:**

- Distribution of user actions (e.g., watched in full, skipped immediately, skipped after partially watching, exited the platform)

- Normalisation of mixed timestamp formats in started_at_raw

- Validation of cleaned timestamps against the provided started_at variable

- Analysis of watch behaviour in relation to video length

- Cleaning and preparation of the watch event data for analysis

**Output files:**

- action_distribution.png — distribution of user actions by category

- watch_share_by_video_length.png — average percentage of each video watched by video length

# **Group member and contributions**

*Tessa Breusers*

- Made the data folder, added gitkeep because they were empty, wrote the whole README and set up folder structure.

- Made the analysis section of users.

*Romy van Rooij*

- Made the tiktok project, made a start on the Quarto summary, performed final updates on the README to improve clarity and structure.

- Made the analysis section of watch events and updated this README file afterwards.

*Ana Maria Iacob*

- Completed the Quarto summary in summary.qmd, using the downloaded video data, saved it in the correct folder, and checked that it renders without errors. I also kept the project structure organized with the data in data/raw and the analysis files in src.

- Made the analysis section of sessions.

- Edited the README.md with adding a part about the peer reviews and the pull requests

*Elsemieke van Gent*

- Made the Downloaddata.R script and wrote the code for downloading the data. Added the .gitignore file and made sure that the data would not be tracked.

- Made the analysis section of impressions. Also made sure the general Makefile runs smoothly and without errors.

- Edited the README.md so that the structure was added in correctly. And that the headings were used in a consistent way.

## Peer review and pull requests

Team members worked on separate branches and contributed their changes through pull requests. Pull requests were reviewed by another team member, feedback was addressed where applicable, and the updated changes were checked before merging into `main`.

| Pull request | Contribution | Author | Reviewer | Feedback addressed |
|---------------|---------------|---------------|---------------|---------------|
| #11 | User analysis | Tessa Breusers | Ana Maria Iacob | Yes |
| #12 | Impression analysis | Elsemieke van Gent | Tessa Breusers | Yes |
| #13 | Session analysis | Ana Maria Iacob | Romy van Rooij | Yes |
| #14 | Watch events analysis | Romy van Rooij | Elsemieke van Gent | Yes |

The review process included feedback on code structure, data paths, README documentation, Makefile functionality, and reproducibility. After feedback was addressed, the relevant workflows were tested before the pull requests were merged into `main`.

# Note:

The data folder is excluded from Git via .gitignore, so raw and processed data files are never committed. Empty subfolders are kept using .gitkeep placeholder files, since Git does not track empty directories.

Group 4.
