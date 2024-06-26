# Load necessary libraries
library(tidyverse)

# Load dataset
dementia_data <- read.csv("data/demantia.csv", colClasses = c(
  Group = "factor",        # Demented/Nondemented
  Visit = "integer",       # Visit number
  MR_Delay = "integer",    # MR Delay
  M_F = "factor",          # M/F (Gender)
  Hand = "factor",         # Hand (Handedness)
  Age = "integer",         # Age
  EDUC = "integer",        # Education
  SES = "integer",         # Socioeconomic Status
  MMSE = "integer",        # Mini-Mental State Examination
  CDR = "numeric",         # Clinical Dementia Rating
  eTIV = "integer",        # Estimated Total Intracranial Volume
  nWBV = "numeric",        # Normalized Whole Brain Volume
  ASF = "numeric"          # Atlas Scaling Factor
))


# Display the structure of the dataset
str(dementia_data)

# View the first few rows of the dataset
head(dementia_data)

# View the dataset in a separate viewer window
View(dementia_data)
