# Load necessary libraries
library(tidyverse)

# Load dataset
dementia_data <- read.csv("data/demantia.csv", colClasses = c(
  Group = "factor",        # Demented/Nondemented
  Visit = "factor",       # Visit number
  MR_Delay = "numeric",    # MR Delay
  Gender = "factor",          # M/F (Gender)
  Hand = "factor",         # Hand (Handedness)
  EDUC = "numeric",        # Education
  SES = "factor",         # Socioeconomic Status
  MMSE = "numeric",        # Mini-Mental State Examination
  CDR = "numeric",         # Clinical Dementia Rating
  eTIV = "numeric",        # Estimated Total Intracranial Volume
  nWBV = "numeric",        # Normalized Whole Brain Volume
  ASF = "numeric"          # Atlas Scaling Factor
))


# Display the structure of the dataset
str(dementia_data)

# View the first few rows of the dataset
head(dementia_data)

# View the dataset in a separate viewer window
View(dementia_data)

# Load necessary library
library(tidyverse)

# Check for missing values in the dataset
# Summarize the number of missing values per column
missing_values_summary <- sapply(dementia_data, function(x) sum(is.na(x)))
print("Missing values per column:")
print(missing_values_summary)

# Display a summary of missing values across the dataset
total_missing_values <- sum(is.na(dementia_data))
cat("Total missing values in the dataset:", total_missing_values, "\n")

# Visualize missing values using a heatmap
library(ggplot2)
library(naniar) # For visualizing missing data

# Plot missing data pattern
gg_miss_var(dementia_data) +
  labs(title = "Missing Data Pattern", x = "Variables", y = "Missing Count")

# Show rows with missing values
missing_rows <- dementia_data[rowSums(is.na(dementia_data)) > 0, ]
print("Rows with missing values:")
print(missing_rows)

# Remove rows with missing values
dementia_data_clean <- na.omit(dementia_data)

# Confirm that there are no missing values in the cleaned dataset
sum(is.na(dementia_data_clean))  # Should return 0 if all missing values are removed

# Display the cleaned dataset
head(dementia_data_clean)

# Check the dimensions of the original vs cleaned dataset
cat("Original dataset dimensions:", dim(dementia_data), "\n")
cat("Cleaned dataset dimensions:", dim(dementia_data_clean), "\n")

