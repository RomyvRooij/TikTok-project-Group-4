# Load raw data
users <- read.csv("data/raw/users.csv")

# Make column names lowercase
names(users) <- tolower(names(users))

#Delete missing values
users <- na.omit(users)

# Save cleaned data
write.csv(users, "data/processed/users_clean.csv", row.names = FALSE)
