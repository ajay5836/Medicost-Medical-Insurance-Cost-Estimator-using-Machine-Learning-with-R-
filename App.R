library(shiny)
library(randomForest)
library(caret)
library(bslib)
library(shinycssloaders)


# Load data and trained model
data <- read.csv("expenses.csv")

# Convert relevant columns to categorical variables (factors)
data$sex <- as.factor(data$sex)
data$smoker <- as.factor(data$smoker)
data$region <- as.factor(data$region)

# Save the unique levels for each categorical input
sex_levels <- levels(data$sex)
smoker_levels <- levels(data$smoker)
region_levels <- levels(data$region)

# Load pre-trained Random Forest model
rf_model <- readRDS("model_rf.rds")

# Define a dark theme using bslib
custom_theme <- bs_theme(
  version = 5,
  bootswatch = "darkly",
  primary = "#007bff",
  base_font = font_google("Poppins")
)

# ------------------------ UI Section ------------------------
ui <- fluidPage(
  theme = custom_theme,
  
  # App Title
  div(style = "text-align: center; margin-top: 30px; margin-bottom: 50px;",
      h1("💼 Medicost", style = "font-weight: bold;")),
  
  # Input Fields
  fluidRow(
    column(4, offset = 2,
           div(style = "margin-left: 90px;",
           textInput("name", "Patient Name", placeholder = "Optional"),
           numericInput("age", "Age", value = 25, min = 1, max = 120),
           numericInput("bmi", "BMI", value = 25.0, min = 10, max = 60)
           )
    ),
    column(4,
           div(style = "margin-left: 90px;",
           selectInput("sex", "Gender", choices = sex_levels),
           numericInput("children", "Number of Children", value = 0, min = 0, max = 5),
           selectInput("smoker", "Smoker?", choices = smoker_levels)
           )
    )
  ),
  
  # Region Input
  fluidRow(
    column(4, offset = 4, align = "center",
           selectInput("region", "Region", choices = region_levels)
    )
  ),
  
  # Predict Button
  fluidRow(
    column(12, align = "center",
           actionButton("predict", "🔍 Predict", class = "btn btn-primary mt-4 mb-3"))
  ),
  
  # Prediction Output with Spinner
  fluidRow(
    column(6, offset = 3,
           withSpinner(uiOutput("prediction_ui"), type = 4, color = "#007bff"))
  )
)

# ------------------------ Server Section ------------------------
server <- function(input, output) {
  
  observeEvent(input$predict, {
    # Prepare input as a dataframe for prediction
    new_input <- data.frame(
      age = input$age,
      sex = factor(input$sex, levels = sex_levels),
      bmi = input$bmi,
      children = input$children,
      smoker = factor(input$smoker, levels = smoker_levels),
      region = factor(input$region, levels = region_levels)
    )
    
    # Make prediction
    pred <- predict(rf_model, new_input)
    
    # Show prediction with formatting
    output$prediction_ui <- renderUI({
      name_text <- if (input$name != "") paste(" for", input$name) else ""
      HTML(paste0(
        "<div style='background-color: #2c2f33; border: 1px solid #3d3f43;
                     border-radius: 8px; padding: 25px; margin-top: 10px; text-align: center;'>",
        "<h5 style='color: #999999;'>Estimated Medical Charges", name_text, ":</h5>",
        "<p style='font-size: 32px; font-weight: 600; color: #28a745;'>₹",
        format(round(pred, 2), big.mark = ","),"/yr", "</p>",
        "</div>"
      ))
    })
  })
}

# ------------------------ Run the App ------------------------
shinyApp(ui = ui, server = server)
