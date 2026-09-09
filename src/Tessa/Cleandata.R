# Load raw data
users <- read.csv("data/raw/users.csv")

# Make column names lowercase
names(users) <- tolower(names(users))