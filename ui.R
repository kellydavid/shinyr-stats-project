# UI script for shinyr-stats-project

# import shiny library
library(shiny)

shinyUI(fluidPage(
  titlePanel("Linear Regression - Price of Diamond vs Carat"),
  
  sidebarLayout(
    
    sidebarPanel(
      # Sample size
      h3("Change Samplesize"),
      sliderInput("samplesize",
                  "Samplesize:",
                  min = 10,
                  max = 500,
                  value = 100),
      
      # Display correlation coefficient
      p("Correlation Coefficient:"),
      textOutput("correlationCoefficient"),
      br(),
    
      # Checkbox for regression line
      checkboxInput("line","Show regression line?", T),
      br(),
      br(),
      h3("Price Prediction"),
      
      # 95% confidence interval for price of diamond
      p("95% confidence interval for price of diamond given its carat."),
      sliderInput("carats",
                  "Carats:",
                  min = 0.5,
                  max = 3.0,
                  value = 1.0),
      p("Price:"),
      textOutput("confidenceIntervalCostLower"),
      p("to"),
      textOutput("confidenceIntervalCostUpper")
    ),
    
    mainPanel(
      plotOutput("mainPlot"),
      br(),
      plotOutput("residualsVsFitted"),
      br(),
      plotOutput("normalQQ")
    )
  )
))