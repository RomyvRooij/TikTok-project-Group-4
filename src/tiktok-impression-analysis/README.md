# TikTok Impression Analysis

## Overview
This project inspects and analyzes TikTok feed impression data to evaluate content delivery and ranking mechanisms. Key aspects of the analysis include:
- Mix of feed sources (e.g., followed, recommended, explore)
- Distribution of total ranking scores across different feed sources
- Analysis of feed position placement
- Detection and removal of duplicated or malformed impressions

---

## Prerequisites
Make sure you have **R** installed on your system along with the following packages:
- `tidyverse`
- `ggplot2`
- `here`

You can install any missing packages in your R console:
```R
install.packages(c("tidyverse", "ggplot2", "here"))
```

---

## How to Run

1. Open your terminal and navigate to the `src/tiktok-impression-analysis` directory:
   ```bash
   cd src/tiktok-impression-analysis
   ```

2. Execute the pipeline using the Makefile:
   ```bash
   make
   ```

---

## Output
Running the pipeline will automatically fetch the raw data, clean and process it, and save the generated visual reports to `src/tiktok-impression-analysis/output/`:
- `Plot_1_source_distribution.png`
- `Plot_2_ranking_scores_distribution.png`
- `Plot_3_ranking_by_source.png`
- `Plot_4_position_distribution.png`