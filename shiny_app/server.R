library(shiny)
require("XML")
require(ggplot2)
require(reshape2)
library(lubridate)

source("yieldCurve.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
        defaultColors <- c("#2E7ABB", "#9E5596", "#E4AA2C", "#AB2B3B", "#41AF42", "#CD7B37", "#889E53","#3897A1", "#7F65A3", "#83C7FF", "#C699C2", "#FFDFAF")
        
 dataInput <-reactive({
         #print((input$header))
         if(input$header == FALSE)
                 yieldCurve(input$firstDate, NULL)
         else 
                 yieldCurve(as.Date(input$firstDate), input$secondDate)
         
#          if (!is.null(input$secondDate)){
#                  yieldCurve(as.Date(input$firstDate), input$secondDate)
#          }
#          else
#                  yieldCurve(input$firstDate)
 })
  
  output$distPlot <- renderPlot({
          if (!is.null(dataInput())){
                  source("yieldChart.R")
                  yield_chart(dataInput(), defaultColors)
          }
  })
})