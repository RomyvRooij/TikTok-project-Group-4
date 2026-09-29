library(tidyverse)
library(DBI)
library(RSQLite)

# -------------------------
# 1. Load data from SQLite
# -------------------------

con <- dbConnect(
  SQLite(),
  "data/raw/tiktok_students.sqlite"
)
users <- dbReadTable(con, "users")

dbDisconnect(con)

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
  showWarnings = FALSE,
  recursive = TRUE
)

# -------------------------
# 4. Save cleaned data
# -------------------------

write.csv(
  users,
  "data/processed/users_clean.csv",
  row.names = FALSE
)