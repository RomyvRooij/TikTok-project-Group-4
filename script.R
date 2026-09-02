# Load the data set and save it in the data:
library("tidyverse")
data <- read_csv("https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/video_view.csv")
write_csv(data, "data/raw/video_view.csv")

#Load the data set from the data section:
library("tidyverse")
data <- read_csv("data/raw/video_view.csv")