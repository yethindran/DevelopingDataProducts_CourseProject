library(shiny)
library(datasets)


# change the "am" variable o factor type
df <- mtcars
df$am <- factor(df$am, labels = c("Automatic", "Manual"))

# The server will react to the chosen input and plot the output mpg
# against the input. It will alos fit a linear model and display it
shinyServer(function(input, output) {

  # store the y versus x in a reactive function to be used in later calls 
  lmStr <- reactive({
   sprintf("mpg ~ %s", input$variable)
  })

  # use the lmStr for the caption
  output$mpgLMCaption <- renderText({
    lmStr()
  })

  # plot mpg versus x, also the linear regression model fit
  output$mpgLMPlot <- renderPlot({
    
    plot(as.formula(lmStr()), data = df)
    fit <- lm(as.formula(lmStr()), data = mtcars)
    abline(fit)
            
  })
})