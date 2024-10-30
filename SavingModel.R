# Saving the model
saveRDS(rf_model, "./models/saved_rf_model.rds")

# Load the saved model
loaded_rf_model <- readRDS("./models/saved_rf_model.rds")

# Example new data for prediction (replace values with actual test data as needed)
new_data <- data.frame(
  Visit = factor(1),
  MR_Delay = 0,
  Gender = factor("M"),
  EDUC = 16,
  SES = factor(2),
  MMSE = 28,
  CDR = 0.5,
  eTIV = 1500,
  nWBV = 0.7,
  ASF = 1.05
)

# Use the loaded model to make predictions
predictions_loaded_model <- predict(loaded_rf_model, newdata = new_data)

# Print predictions
print(predictions_loaded_model)
