# Server script for shinyr-stats-project

# import shiny library
library(shiny)

shinyServer(function(input, output) {

  # Read in data
  data <- read.csv("diamonds.csv")
  price <- data$price
  carat <- data$carat
  price_carat <- data.frame(price, carat)
  
  # Reactive function that generates a new sample when the samplesize is changed
  generateSample <- reactive({
    # get a sample from the data set
    samplesize <- input$samplesize
    price_carat[sample(nrow(price_carat), samplesize, replace=FALSE),]
  })
  
  # Gets the line to fit the current sample
  getFitLine <- reactive({
    pc_sample <- generateSample()
    price <- pc_sample$price
    carat <- pc_sample$carat
    lm(price ~ carat)
  })
  
  # Scatterplot showing linear regression
  output$mainPlot <- renderPlot({
    # Get sample
    pc_sample <- generateSample()

    # Generate Plot
    plot(pc_sample$carat, pc_sample$price, main="Price of Diamond vs Carat", xlab="Carat", ylab="Price")

    # If line checkbox ticked, then display regression line
    if(input$line){
      abline(getFitLine(), col="dark blue")
    }
  })
  
  # Calculate correlation coeffiecient
  output$correlationCoefficient <- renderText({
    #get sample
    pc_sample <- generateSample()
    cor <- cor(pc_sample$carat, pc_sample$price)
    paste(cor)
  })
  
  # regression
  output$residualsVsFitted <- renderPlot({
    plot(getFitLine(), which=1)
  })
  
  # regression
  output$normalQQ <- renderPlot({
    plot(getFitLine(), which=2)
  })
  
  # Predict the cost of a diamond given the carat value
  getCostPrediction <- reactive({
    fit <- getFitLine()
    newdata <- data.frame(carat=input$carats)
    predict(fit, newdata, interval='confidence')
  })
  
  # get the upper cost
  output$confidenceIntervalCostLower <- renderText({
    cost <- getCostPrediction()
    paste(cost[2])
  })
  
  # get the lower cost
  output$confidenceIntervalCostUpper <- renderText({
    cost <- getCostPrediction()
    paste(cost[1])
  })
})
