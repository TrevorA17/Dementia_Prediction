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

# Load necessary libraries
library(tidyverse)
library(psych)

# Measures of Frequency
# Frequency of categorical variables
group_freq <- table(dementia_data$Group)
visit_freq <- table(dementia_data$Visit)
gender_freq <- table(dementia_data$Gender)
hand_freq <- table(dementia_data$Hand)
ses_freq <- table(dementia_data$SES)

# Measures of Central Tendency
# Mean, Median for numerical variables
mean_age <- mean(dementia_data$Age, na.rm = TRUE)
median_age <- median(dementia_data$Age, na.rm = TRUE)
mean_mmse <- mean(dementia_data$MMSE, na.rm = TRUE)
median_mmse <- median(dementia_data$MMSE, na.rm = TRUE)

# Mode function
get_mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
mode_education <- get_mode(dementia_data$EDUC)

# Measures of Distribution
# Standard Deviation, Variance, Skewness, and Kurtosis
sd_age <- sd(dementia_data$Age, na.rm = TRUE)
var_age <- var(dementia_data$Age, na.rm = TRUE)
skew_age <- skew(dementia_data$Age, na.rm = TRUE)
kurt_age <- kurtosi(dementia_data$Age, na.rm = TRUE)

sd_mmse <- sd(dementia_data$MMSE, na.rm = TRUE)
var_mmse <- var(dementia_data$MMSE, na.rm = TRUE)
skew_mmse <- skew(dementia_data$MMSE, na.rm = TRUE)
kurt_mmse <- kurtosi(dementia_data$MMSE, na.rm = TRUE)

# Measures of Relationship
# Correlation matrix for numerical variables
cor_matrix <- cor(dementia_data %>% select(Age, EDUC, MMSE, CDR, eTIV, nWBV, ASF), use = "complete.obs")

# Contingency table for categorical variables
group_gender_table <- table(dementia_data$Group, dementia_data$Gender)

# Print results
print("Frequency of Group:")
print(group_freq)
print("Frequency of Visit:")
print(visit_freq)
print("Frequency of Gender:")
print(gender_freq)
print("Frequency of Handedness:")
print(hand_freq)
print("Frequency of SES:")
print(ses_freq)

print(paste("Mean Age:", mean_age))
print(paste("Median Age:", median_age))
print(paste("Mode Education:", mode_education))
print(paste("Standard Deviation Age:", sd_age))
print(paste("Variance Age:", var_age))
print(paste("Skewness Age:", skew_age))
print(paste("Kurtosis Age:", kurt_age))

print(paste("Mean MMSE:", mean_mmse))
print(paste("Median MMSE:", median_mmse))
print(paste("Standard Deviation MMSE:", sd_mmse))
print(paste("Variance MMSE:", var_mmse))
print(paste("Skewness MMSE:", skew_mmse))
print(paste("Kurtosis MMSE:", kurt_mmse))

print("Correlation Matrix:")
print(cor_matrix)

print("Contingency Table of Group and Gender:")
print(group_gender_table)

# Load necessary libraries
library(tidyverse)
library(car)   # For Levene's Test
library(psych) # For skewness and kurtosis

# Perform ANOVA

# Perform ANOVA on MMSE by Group
anova_mmse <- aov(MMSE ~ Group, data = dementia_data)
summary(anova_mmse)

# Perform ANOVA on CDR by Group
anova_cdr <- aov(CDR ~ Group, data = dementia_data)
summary(anova_cdr)

# Check Assumptions for ANOVA
# 1. Homogeneity of Variances (Levene's Test)
leveneTest(MMSE ~ Group, data = dementia_data)
leveneTest(CDR ~ Group, data = dementia_data)

# 2. Normality of Residuals
shapiro.test(residuals(anova_mmse))
shapiro.test(residuals(anova_cdr))

# Post-hoc Analysis if ANOVA is significant
# Tukey's Honest Significant Difference (HSD) test
tukey_mmse <- TukeyHSD(anova_mmse)
tukey_cdr <- TukeyHSD(anova_cdr)

# Print results of post-hoc tests
print(tukey_mmse)
print(tukey_cdr)


