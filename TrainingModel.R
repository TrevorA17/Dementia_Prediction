# Load necessary library
library(caret)

# Set seed for reproducibility
set.seed(123)

# Split the data: 70% for training, 30% for testing
train_index <- createDataPartition(dementia_data_clean$Group, p = 0.7, list = FALSE)
training_data <- dementia_data_clean[train_index, ]
testing_data <- dementia_data_clean[-train_index, ]

# Confirm the dimensions of the splits
cat("Training data dimensions:", dim(training_data), "\n")
cat("Testing data dimensions:", dim(testing_data), "\n")

# Display the first few rows of each split
head(training_data)
head(testing_data)

# Load necessary library
library(boot)

# Define a function to calculate the statistic (e.g., mean MMSE)
mean_mmse <- function(data, indices) {
  sample_data <- data[indices, ]  # Resample data with the given indices
  return(mean(sample_data$MMSE, na.rm = TRUE))  # Return the mean of MMSE
}

# Set seed for reproducibility
set.seed(123)

# Perform bootstrapping
# Using 1000 resamples to estimate the mean of MMSE
bootstrap_results <- boot(data = dementia_data_clean, statistic = mean_mmse, R = 1000)

# Display results
print(bootstrap_results)

# Plot bootstrap results to visualize the distribution of the mean MMSE
plot(bootstrap_results)
