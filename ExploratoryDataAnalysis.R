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

# Load necessary libraries
library(tidyverse)
library(GGally)  # For pairwise plots
library(reshape2) # For melting data for the heatmap

# Univariate Plots

# Histogram for EDUC (Education)
ggplot(dementia_data, aes(x = EDUC)) +
  geom_histogram(bins = 15, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Education Level (EDUC)", x = "Education Level", y = "Frequency") +
  theme_minimal()

# Boxplot for MMSE by Group
ggplot(dementia_data, aes(x = Group, y = MMSE, fill = Group)) +
  geom_boxplot() +
  labs(title = "MMSE Scores by Group", x = "Group", y = "MMSE") +
  theme_minimal() +
  scale_fill_manual(values = c("Demented" = "orange", "Nondemented" = "green"))

# Bar plot for Gender Distribution
ggplot(dementia_data, aes(x = Gender)) +
  geom_bar(fill = "coral") +
  labs(title = "Gender Distribution", x = "Gender", y = "Count") +
  theme_minimal()

# Multivariate Plots

# Scatter plot of MMSE vs. eTIV, colored by Group
ggplot(dementia_data, aes(x = eTIV, y = MMSE, color = Group)) +
  geom_point(alpha = 0.6, size = 3) +
  labs(title = "Scatter Plot of eTIV vs. MMSE by Group", x = "eTIV (Total Intracranial Volume)", y = "MMSE") +
  theme_minimal() +
  scale_color_manual(values = c("Demented" = "red", "Nondemented" = "blue"))

# Pairwise plot for selected numerical variables
# Select only numeric columns for the pair plot
numeric_data <- dementia_data %>% select(MR_Delay, EDUC, MMSE, CDR, eTIV, nWBV, ASF)
ggpairs(numeric_data, aes(color = dementia_data$Group), title = "Pairwise Plot of Numeric Variables by Group")

# Correlation heatmap
# Calculate correlations only for numeric columns
cor_data <- cor(numeric_data, use = "complete.obs")
# Melt correlation data for ggplot
melted_cor_data <- melt(cor_data)
ggplot(melted_cor_data, aes(Var1, Var2, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  theme_minimal() +
  labs(title = "Correlation Heatmap", x = "Variable", y = "Variable") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Box plot for MMSE across SES levels
ggplot(dementia_data, aes(x = SES, y = MMSE, fill = SES)) +
  geom_boxplot() +
  labs(title = "MMSE Scores by Socioeconomic Status (SES)", x = "SES", y = "MMSE") +
  theme_minimal() +
  scale_fill_brewer(palette = "Pastel1")
