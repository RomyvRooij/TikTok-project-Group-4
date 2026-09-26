library(tidyverse)
library(RSQLite)
library(here)

# Connect to SQLite database
con <- dbConnect(
  SQLite(),
  here("data", "raw", "tiktok_students.sqlite")
)

# Load data from SQLite
users_sql <- dbGetQuery(
  con,
  "SELECT * FROM user_view"
)

# Look at the data
glimpse(users_sql)

# Simple SQL analysis
top_users <- dbGetQuery(
  con,
  "
  SELECT user_id, user_name, impressions_n, watched_n, total_watch_seconds
  FROM user_view
  ORDER BY impressions_n DESC
  LIMIT 10
  "
)

print(top_users)

# Close database connection
dbDisconnect(con)