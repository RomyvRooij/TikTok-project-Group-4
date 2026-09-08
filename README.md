# **TikTok-project-template-2026**
This repository is a template for the **Data preparation and programming skills** course in fall 2026. 

## **GOAL of the project**
The goal of this project is to work together on the TikTok data in Positron with GitHub. 
We are analyzing the `video_view.csv` dataset.  
The project focuses on downloading the data, preparing it, and performing an analysis to answer the research question of the project.

## **Set up the environment & install dependencies**
This project was developed using Positron.

To set up the project environment:

1. Install and open Positron.
2. Clone this Github repository to your computer.
2. Open the project folder in Positron. `TIKTOK-PROJECT-GROUP-4` in Positron.
3. Install the required packages by running:

```
    install.packages("tidyverse")
    install.packages("readr")
    install.packages("dplyr")
    install.packages("ggplot2")
```

## **Reproducing the analysis**

To reproduce the full analysis, the files need to be run in the correct order.

### 1. Download the data
`src/Downloaddata.R`  
   Run this first (e.g. `Rscript src/Downloaddata.R` in the terminal). This downloads the dataset from the provided URL and saves it to `data/raw/video_view.csv`. If the file already exists, it will skip the download and just read the existing file.

```
Rscript src/Downloaddata.R
```

### 2. Render the analysis
`src/summary.qmd`  
   Once the data is downloaded, render this Quarto file to produce the summary report (e.g. `quarto render src/summary.qmd` in the terminal). This reads `data/raw/video_view.csv` and produces `src/summary.html` with an overview of the dataset, key statistics, and visualizations.

```
quarto render src/summary.qmd
```

## **Group member and contributions**
*Tessa Breusers* 
- Made the data folder, added gitkeep because they were empty, wrote the whole README and set up folder structure.

*Romy van Rooij* 
- Made the tiktok project, made a start on the Quarto summary, performed final updates on the README to improve clarity and structure.

*Ana Maria* 
- Completed the Quarto summary in summary.qmd, using the downloaded video data, saved it in the correct folder, and checked that it renders without errors. I also kept the project structure organized with the data in data/raw and the analysis files in src.

*Elsemieke van Gent* 
- Made the Downloaddata.R script and wrote the code for downloading the data. Added the .gitignore file and made sure that the data would not be tracked.

## **Structure**
1. data
> raw (all our downloaded data files, ignored by Git)
2. src
> Downloaddata.R (script to download the dataset)
> summary.qmd (Quarto file that reads the data and produces the summary)
> summary.html (rendered output of summary.qmd)
3. .gitignore (ensures the data folder is not tracked by Git)
4. AI.md (description of AI usage)
5. README.md (explains the project)

Group 4