require(tidyr)

# Load the toy data in from the .csv file
toyData <- read.csv("refine_original.csv")

# Part 1: Clean up brand names
toyData$company <- sub("[Ph|ph|f].+[Ss]", "philips", toyData$company)
toyData$company <- sub("[Aa].+[oO0]", "azko", toyData$company)
toyData$company <- sub("[Vv].+n", "van houten", toyData$company)
toyData$company <- sub("[Uu].+r", "unilever", toyData$company)

# Part 2: Separate product code and number
toyData <- separate(toyData, "Product.code...number", c("Product.code", "Product.number"), "-")

# Part 3: Add product categories
# Generate "Product.category" column from "Product.code" for greater readability
translate <- list("p"="Smartphone", "v"="TV", "x"="Laptop", "q"="Tablet")
toyData$Product.category <- as.character(translate[toyData$Product.code])

# Part 4: Add full address for geocoding
toyData <- unite(toyData, full.address, c(address, city, country), sep = ", ")

# Part 5: Create dummy variables for company and product category
toyData$company_philips	    <- as.integer(toyData$company == "philips")
toyData$company_azko        <- as.integer(toyData$company == "azko")
toyData$company_van_houten  <- as.integer(toyData$company == "van houten")
toyData$company_unilever    <- as.integer(toyData$company == "unilever")

toyData$product_smartphone  <- as.integer(toyData$Product.code == "p")
toyData$product_tv          <- as.integer(toyData$Product.code == "v")
toyData$product_laptop      <- as.integer(toyData$Product.code == "x")
toyData$product_tablet      <- as.integer(toyData$Product.code == "q")

write.csv(toyData, file="refine_clean.csv")
