library(caret)
library(randomForest)

# Load the dataset (to retain factor levels)
data <- read.csv("expenses.csv")
data$sex <- as.factor(data$sex)
data$smoker <- as.factor(data$smoker)
data$region <- as.factor(data$region)

# Define factor levels as in training data
sex_levels <- levels(data$sex)
smoker_levels <- levels(data$smoker)
region_levels <- levels(data$region)

# Create new input for prediction
new_input <- data.frame(
  age = 60,
  sex = factor("female", levels = sex_levels),
  bmi = 30.5,
  children = 2,
  smoker = factor("yes", levels = smoker_levels),
  region = factor("southwest", levels = region_levels)
)

# Load trained Random Forest model
model <- readRDS("model_rf.rds")
  
# Predict
predicted_charges <- predict(model, new_input)

# Output
cat("Predicted Medical Charges:", round(predicted_charges, 2), "\n")
