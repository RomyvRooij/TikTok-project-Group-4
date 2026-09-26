

library(tidyverse)
library(RSQLite)
library(here)

# -------------------------
# 1. Load data from SQLite
# -------------------------
users <- read.csv("data/raw/users.csv")

# -------------------------
# 2. Clean data
# -------------------------

# Make column names lowercase
names(users) <- tolower(names(users))

# Delete missing values
users <- na.omit(users)

# -------------------------
# 3. Create processed folder
# -------------------------

dir.create(
  "data/processed",
  showWarnings = FALSE
)

# -------------------------
# 4. Save cleaned data
# -------------------------

write.csv(
  users,
  "data/processed/users_clean.csv",
  row.names = FALSE
)

# -------------------------
# 5. Close database connection
# -------------------------

dbDisconnect(con)
