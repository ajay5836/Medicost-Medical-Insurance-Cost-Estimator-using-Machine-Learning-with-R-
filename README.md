# Medical Insurance Cost Prediction

This project aims to predict individual medical insurance charges based on demographic and health-related features using various machine learning models implemented in **R**. It includes complete data analysis, model development, evaluation, and saving trained models for deployment.

## 📊 Project Overview

Using a dataset (`expenses.csv`) that contains information such as age, BMI, number of children, smoking status, sex, and region, we:

- Conducted **exploratory data analysis (EDA)** to understand trends and relationships
- Performed **data preprocessing**, including normalization and factor conversion
- Built and evaluated three predictive models:
  - Linear Regression
  - Decision Tree
  - Random Forest
- Saved the trained models (`.rds` format) for deployment
- Created a **prediction script** using saved models for estimating charges
- Planned development of an **interactive R Shiny web application** for user input and real-time prediction

## 🔧 Key Components

| Section                        | Description |
|-------------------------------|-------------|
| `Exploratory Data Analysis`   | Visualizations: density plots, histograms, scatter plots, boxplots |
| `Data Preprocessing`          | Scaling numeric features, handling categorical variables, checking for nulls/duplicates |
| `Model Training & Evaluation` | Trained three models; evaluated using MAE, RMSE, and R² metrics |
| `Model Saving`                | Saved best models using `saveRDS()` for later use |
| `Prediction Script`           | Used saved models to make predictions based on user-provided inputs |
| `R Shiny App (Pending)`       | A web interface is planned for real-time user interaction and prediction |

## 📁 Files and Structure

- `expenses.csv` – Dataset used for training
- `insurance_modeling.R` – Complete analysis, modeling, and evaluation code
- `model_rf.rds` & `model_dt.rds` – Saved Random Forest and Decision Tree models
- `predictor.R` – Script for using saved models to predict new values
- `README.md` – Project documentation

## 📌 Dependencies

- `ggplot2`
- `tidyverse`
- `GGally`
- `caret`
- `randomForest`
- `rpart`
- `stats`

Install all required packages via:

```r
install.packages(c("ggplot2", "tidyverse", "GGally", "caret", "randomForest", "rpart"))
