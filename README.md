# **TikTok-project-template-2026**
This repository is a template for the **Data preparation and programming skills** course in fall 2026. 

## **GOAL of the project**
The goal of this project is to work together on the TikTok data in Positron with GitHub. 

We analyze TikTok user behaviour using data on users, sessions, impressions, watch events, and video views.

The project focuses on downloading the data, preparing it, performing several analyses, running a regression analysis, and combining the results into one final reproducible report.

As an additional database exercise, the project also demonstrates how the TikTok data can be accessed through a SQLite database.

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
    install.packages("RSQLite")
```

## **Reproducing the analysis**

The full project can be reproduced using the Makefile from the root of the repository.

Run in the terminal:

```
make
```

The makefile automates the analysis workflow and ensures that the required scripts are run in the correct order.

Run in the terminal:

```
make clean
```

This will remove all generated files and output but makes sure the raw data stays.

## Project workflow

The project follows these main steps:

1. Raw TikTok data is downloaded and stored in `data/raw/`.
2. The analysis scripts clean and prepare the relevant data.
3. The cleaned data is stored in `data/processed/` where applicable.
4. The analysis scripts generate visualizations.
5. The visualizations are saved in the corresponding `output/` folders.
6. `Regression.R` combines variables from multiple datasets and performs the regression analysis.
7. `summary.qmd` combines the project results into one final report.
8. The final report is rendered to `output/final-analysis.pdf`

In addition, `DownloadDataSQL.R` and `SQL_analysis.R` demonstrate how the same project data can be downloaded and accessed through a SQLite database.

## Troubleshooting

If `make` does not run as expected, check the following:

- Make sure you are running `make` from the root of the repository.
- Make sure R and all required packages are installed.
- Make sure you have cloned the repository correctly.
- Make sure the required data can be downloaded using the project's download scripts.
- Check whether the expected folders exist in `data/`, `src/`, and `output/`.

If an expected output is missing, check the corresponding analysis folder in `src/` and run `make` again.

If the problem persists, check the error message in the terminal to identify which script or dependency caused the issue.

## **Group member and contributions**
*Tessa Breusers* 
- Made the data folder, added gitkeep because they were empty, wrote the README and set up folder structure.
- Made the analysis section of users. 
- Wrote the downloaddataSQL script to show we can also work with sqlite databases.
- Build a regression model and run an analysis on it, creating a plot.
- Updated the makefile so it runs on both Windows and Mac.
- Updated README.


*Romy van Rooij* 
- Made the tiktok project, made a start on the Quarto summary, performed final updates on the README to improve clarity and structure.
- Made the analysis section of watch events and updated this README file afterwards.
- Made final improvements to compute everything into one Quarto file and helped with the regression analysis and updating of the README.

*Ana Maria Iacob* 
- Completed the Quarto summary in summary.qmd, using the downloaded video data, saved it in the correct folder, and checked that it renders without errors. I also kept the project structure organized with the data in data/raw and the analysis files in src.
- Made the analysis section of sessions. 
- Completed the final analysis file and checked that it runs and renders successfully and saved it as pdf in output folder.

*Elsemieke van Gent* 
- Made the Downloaddata.R script and wrote the code for downloading the data. Added the .gitignore file and made sure that the data would not be tracked.
- Made the analysis section of impressions. Also made sure the general Makefile runs smoothly and without errors.
- Made the final Makefile, now it has the option to run 'make' to generate the report. But also 'make SQL' to show that we know how to use the .sqlite database. 
- Finalised all the src files, to make sure there were no errors with loading the data from csv, cleaning it and running the right analysis. 

## **Structure**
1. data
   - **raw/** — original downloaded data (ignored by Git)
   - **processed/** — reserved for cleaned/derived datasets (ignored by Git)

2. output
   - **impressions/** - the plots from the impression analysis
   - **sessions/** - the plots from the session analysis
   - **users/** the plots from the users analysis
   - **watch_events/** the plots from the watch_events analysis
   - **final-analysis.pdf** final rendered report combining the project analyses.
   - **`summary.qmd** Quarto file that reads the data and produces the summary.

3. src

   ### `tiktok-impression-analysis/`
   Contains the R scripts for downloading, cleaning, and visualization of the data.

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

   ### `tiktok-session-analysis/`
   Contains the R scripts for downloading, cleaning, and visualization of the data.

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

   ### `tiktok-user-analysis/`
   Contains the R scripts for downloading, cleaning, and visualization of the data. 

   #### Overview
   This folder analyzes TikTok user preferences to explore differences in average preferences across users.

   #### Output
   Running the pipeline generates the visual report in `output/users`:

- `average_preferences.png` — This plot shows the average user preference score for each content category in the cleaned users dataset. 
   The selected categories include comedy, dance, beauty/fashion, food, fitness/sports, gaming, DIY/home, travel, education, and pets.

   For each category, the mean preference score is calculated across all users, excluding missing values. The resulting bar chart makes it easy to compare which content categories users prefer most on average. Higher bars indicate stronger average preference for that category, while lower bars indicate weaker average preference.

   ### `tiktok_watch_events-analysis/`
   Contains the R scripts for downloading, cleaning, and visualization of the data.

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

   ### `Downloaddata.R`
   Script to download the dataset.

   ### `DownloadDataSQL.R`
   Demonstrates how the SQLite databse can be downloaded as an alternative data source.

   ### `SQL_analysis.R`
   Demonstrates how tables can be accessed from the SQLite database. 
   The main analysis pipeline continues to use the CSV and processed datasets.

   ### `Regression.R`
   Contains the regression analysis with a starter model, that is then expanded with multiple variables. Read further to learn more about what the regression is about.

4. `.gitignore` (ensures the data folder is not tracked by Git)

5. `AI.md` (description of AI usage)

6. `final-analysis.qmd` (Quarto source file for the final report)

7. `Makefile` (automates the project workflow and generates the final report)

8. `README.md` (explains the whole project)

Note: the data folder is excluded from Git via .gitignore, so raw and processed data files are never committed. Empty subfolders are kept using .gitkeep placeholder files, since Git does not track empty directories.

## Regression analysis 
# Goal
The goal of this assignment is to identify one interesting correlation in the data and investigate it further using regression analysis.

In this analysis, we focus on the relationship between the total recommendation score of an impression (`score_total`) and the amount of time a user watches the video (`watch_seconds`).

The main research question is: **Is a higher recommendation score associated with longer video watch time?**
The expectation is that videos with a higher recommendation score are more relevant to users and are therefore watched for a longer period of time.

# Data
This analysis uses two datasets:
- impressions.csv
- watch_events.csv

These datasets need to be downloaded first. This can be done using the downloaddata.R script. 
The `watch_events` dataset is first summarized at the impression level. This creates one total value for `watch_seconds` for each `impression_id`.
Then, this summarized watch data is joined with the `impressions` dataset.
If an impression does not have a matching watch event, the watch time is set to `0`. This means that the video was shown to the user but was not watched.

# Model 1: simple linear regression
The first model investigates the simple relationship between `score_total` and `watch_seconds`.
This model shows whether impressions with a higher recommandation score are associated with a higher watch time on average.

# Model 2: multiple linear regression
This model controls for different variables: 'feed_rank', 'score_category_match', 'score_creator_match', 'score_satiation_penalty', 'source_bucket'.
This extended model is the main model in the analysis because it accounts for multiple factors that may influence watch time.

# Model 3
The third model adds user fixed effects by including `user_id` as a factor variable. This model controls for stable differences between users, such as some users generally watching more videos or spending more time watching than others.

# Output
The script saves two outputs in the output/regression folder:

   - score_watch_regression.png: a scatter plot showing the relationship between score_total and watch_seconds, including a fitted regression line.
   - score_watch_diagnostics.png: diagnostic plots for the multiple regression model, used to assess model assumptions such as residual patterns, normality, and influential observations. 

## Peer review and pull requests

Team members worked on separate branches and contributed their changes through pull requests. Pull requests were reviewed by another team member, feedback was addressed where applicable, and the updated changes were checked before merging into `main`.

| Pull request | Contribution | Author | Reviewer | Feedback addressed |
|---|---|---|---|---|
| #11 | User analysis | Tessa Breusers | Ana Maria Iacob | Yes |
| #12 | Impression analysis | Elsemieke van Gent | Tessa Breusers | Yes |
| #13 | Session analysis | Ana Maria Iacob | Romy van Rooij | Yes |
| #14 | Watch events analysis | Romy van Rooij | Elsemieke van Gent | Yes |

The review process included feedback on code structure, data paths,
README documentation, Makefile functionality, and reproducibility.
After feedback was addressed, the relevant workflows were tested
before the pull requests were merged into `main`.

During final integration, the team checked the project structure,
file paths, Makefile dependencies and generated outputs.

No unresolved conflicts remained in the final `main` branch. The
integrated workflow was tested after merging to verify that the
project remained reproducible.

## Week 4 coding improvements

For Week 4, we added a few of the techniques from the tutorial to our existing analysis.

In the session analysis, we used `lag()` to compare the number of sessions on each day with the previous day. This gives us a better idea of how session activity changes over time.

We also used `rank()` to rank users based on the number of sessions they had. This builds on our existing analysis of session activity and makes it easier to compare users.

We tested both changes by running the session analysis again and checking that the outputs were generated correctly.

## Final report
The results from the different parts of the project are combined into one final Quarto report.

The final report includes:

- basic data inspection;
- impression analysis;
- session analysis;
- user analysis;
- watch-event analysis;
- regression analysis;
- visualizations;
- conclusions and limitations.

The source document is:
`final-analysis.qmd`

The rendered final output is:
`output/final-analysis.pdf`
The final report can be reproduced automatically by running `make` from the root of the repository.


Group 4