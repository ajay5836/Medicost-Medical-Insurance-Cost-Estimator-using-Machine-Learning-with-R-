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
  sex = factor("male", levels = sex_levels),
  bmi = 30.5,
  children = 2,
  smoker = factor("yes", levels = smoker_levels),
  region = factor("southwest", levels = region_levels)
)

dt_model <- readRDS("model_dt.rds")

#Predict Using Decision Tree Model
predicted_charges_dt <- predict(dt_model, new_input)

cat("Predicted Medical Charges:", round(predicted_charges_dt, 2), "\n")
