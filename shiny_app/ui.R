library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Yield Curve Chart"),
  # Sidebar with a slider input for the number of bins
  
          sidebarPanel(
                  dateInput('firstDate', label = 'Choose a date', 
                            value = as.character("2014-06-13"), min = "2014-01-01", max = "2014-12-31", 
                            format = "yyyy-mm-dd", startview = "month", 
                            weekstart = 0, language = "en"),
                  
                  
                  checkboxInput('header', 'Select to compare', FALSE),
                  
                  conditionalPanel(condition = "input.header == '1'",
                                   dateInput('secondDate', label = 'Enter comparison date', 
                                             value = NULL, min = "2014-01-02", max = "2014-12-31", 
                                             format = "yyyy-mm-dd", startview = "month", 
                                             weekstart = 0, language = "en"  )
                  )
                  
                  
          ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)