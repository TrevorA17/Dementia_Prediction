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

# Load necessary libraries
library(dplyr)
library(caret)

# Install the MLmetrics package if not already installed
if (!requireNamespace("MLmetrics", quietly = TRUE)) {
  install.packages("MLmetrics")
}

# Load the MLmetrics library
library(MLmetrics)

# Remove the 'Hand' column from the dataset
dementia_data_clean <- dementia_data_clean %>% select(-Hand)

# Check the structure of the cleaned dataset
str(dementia_data_clean)

# Set seed for reproducibility
set.seed(123)

# Define cross-validation settings with stratified sampling
train_control <- trainControl(
  method = "cv", 
  number = 10, 
  classProbs = TRUE,
  summaryFunction = multiClassSummary
)

# Fit the logistic regression model
model_cv <- train(
  Group ~ ., 
  data = dementia_data_clean, 
  method = "glm", 
  family = "binomial", 
  trControl = train_control
)

# Display cross-validation results
print(model_cv)

# Display summary of cross-validation metrics
print(model_cv$results)

# Load necessary libraries
library(dplyr)
library(caret)
library(MLmetrics)

# Remove the 'Hand' column from the dataset
dementia_data_clean <- dementia_data_clean %>% select(-Hand)

# Check the structure of the cleaned dataset
str(dementia_data_clean)

# Set seed for reproducibility
set.seed(123)

# Define cross-validation settings
train_control <- trainControl(
  method = "cv", 
  number = 10, 
  classProbs = TRUE,
  summaryFunction = multiClassSummary
)

# K-Nearest Neighbors Model
knn_model <- train(
  Group ~ ., 
  data = dementia_data_clean, 
  method = "knn", 
  trControl = train_control,
  tuneLength = 10  # Search for the optimal value of k
)

# Random Forest Model
rf_model <- train(
  Group ~ ., 
  data = dementia_data_clean, 
  method = "rf", 
  trControl = train_control
)

# Support Vector Machine Model
svm_model <- train(
  Group ~ ., 
  data = dementia_data_clean, 
  method = "svmRadial", 
  trControl = train_control
)

# Display results of each model
cat("K-Nearest Neighbors Model:\n")
print(knn_model$results)

cat("\nRandom Forest Model:\n")
print(rf_model$results)

cat("\nSupport Vector Machine Model:\n")
print(svm_model$results)

# Combine the results of the models
model_list <- resamples(list(KNN = knn_model, RF = rf_model, SVM = svm_model))

# Summarize the results
summary(model_list)

# Plot the comparison of model performance
bwplot(model_list, metric = "Accuracy")  # You can change 'Accuracy' to other metrics like 'Kappa' if needed
