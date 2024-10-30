# Load necessary libraries
library(plumber)
library(dplyr)

# Load the saved Random Forest model
loaded_rf_model <- readRDS("./models/saved_rf_model.rds")

#* @apiTitle Dementia Prediction API
#* @apiDescription This API predicts the dementia group (Demented/Nondemented) based on input features.

#* Predict dementia group based on input data
#* @param Visit:int The visit number
#* @param MR_Delay:numeric The MR delay time
#* @param Gender:string The gender ("M" or "F")
#* @param EDUC:numeric Education level
#* @param SES:int Socioeconomic status (1-5)
#* @param MMSE:numeric Mini-Mental State Examination score
#* @param CDR:numeric Clinical Dementia Rating
#* @param eTIV:numeric Estimated Total Intracranial Volume
#* @param nWBV:numeric Normalized Whole Brain Volume
#* @param ASF:numeric Atlas Scaling Factor
#* @post /predict
function(Visit, MR_Delay, Gender, EDUC, SES, MMSE, CDR, eTIV, nWBV, ASF) {
  
  # Prepare the input data for prediction
  new_data <- data.frame(
    Visit = factor(as.integer(Visit)),
    MR_Delay = as.numeric(MR_Delay),
    Gender = factor(Gender),
    EDUC = as.numeric(EDUC),
    SES = factor(as.integer(SES)),
    MMSE = as.numeric(MMSE),
    CDR = as.numeric(CDR),
    eTIV = as.numeric(eTIV),
    nWBV = as.numeric(nWBV),
    ASF = as.numeric(ASF)
  )
  
  # Make a prediction using the loaded model
  prediction <- predict(loaded_rf_model, newdata = new_data)
  
  # Return the prediction result
  list(prediction = as.character(prediction))
}
