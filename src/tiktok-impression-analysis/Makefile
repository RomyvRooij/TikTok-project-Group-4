# Makefile for TikTok Impression Analysis
all: output/Plot_1_source_distribution.png \
     output/Plot_2_ranking_scores_distribution.png \
     output/Plot_3_ranking_by_source.png \
     output/Plot_4_position_distribution.png

../../data/raw/impressions.csv: Downloaddata.R
	Rscript Downloaddata.R

../../data/processed/impressions_clean.csv: ../../data/raw/impressions.csv Cleaningdata.R
	Rscript Cleaningdata.R

output/Plot_1_source_distribution.png \
output/Plot_2_ranking_scores_distribution.png \
output/Plot_3_ranking_by_source.png \
output/Plot_4_position_distribution.png: ../../data/processed/impressions_clean.csv Visualization.R
	Rscript Visualization.R

clean:
	rm -f ../../data/raw/impressions.csv
	rm -f ../../data/processed/impressions_clean.csv
	rm -rf output