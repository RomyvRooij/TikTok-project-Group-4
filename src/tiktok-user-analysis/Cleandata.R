library(tidyverse)

# -------------------------
# 1. Load data from csv
# -------------------------

users <- read.csv("data/raw/users.csv")

# -------------------------
# 2. Clean data
# -------------------------

# Make column names lowercase
names(users) <- tolower(names(users))

# Delete missing values
users_clean <- na.omit(users)

# -------------------------
# 3. Create processed folder
# -------------------------

dir.create(
  "data/processed",
  showWarnings = FALSE,
  recursive = TRUE
)

# -------------------------
# 4. Save cleaned data
# -------------------------

write.csv(
  users_clean,
  "data/processed/users_clean.csv",
  row.names = FALSE
)
