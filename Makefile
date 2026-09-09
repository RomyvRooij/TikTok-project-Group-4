# Download raw data if it does not exist
data/raw/users.csv: src/Tessa/Downloaddata.R
	Rscript -e "source('src/Tessa/Downloaddata.R')"

# Clean data if processed file does not exist or raw data changed
data/processed/users_clean.csv: data/raw/users.csv src/Tessa/Cleandata.R
	Rscript -e "source('src/Tessa/Cleandata.R')"

# Create visualization if plot does not exist or processed data changed
src/Tessa/output/average_preferences.png: data/processed/users_clean.csv src/Tessa/Visualize.R
	Rscript -e "source('src/Tessa/Visualize.R')"