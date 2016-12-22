# Load the passenger data in from the .csv file
passengers <- read.csv("titanic_original.csv")

# Part 1: Find missing values in "embarked" column and replace them with "S"
passengers$embarked <- sub("^$", "S", passengers$embarked)

# Part 2: Find missing "age" values and replace them with the mean of the ages
mean_age <- mean(passengers$age, na.rm = TRUE)
passengers["age"][is.na(passengers["age"])] <- mean_age

# Part 3: Find missing "boat" values and fill them with "None"
passengers$boat <- sub("^$", "None", passengers$boat)

# Part 4: Create new binary column that indicates whether cabin number is present
passengers$has_cabin_number <- as.integer(!((passengers$cabin) == ""))

write.csv(passengers, file="titanic_clean.csv")
