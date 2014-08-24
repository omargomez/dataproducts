library(shiny)
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Correlation of Suicide rates against Economical, Social, and Spiritual Factors"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        selectInput("factor", "Select a Factor:", 
                    choices=c("Unemployment Rate","GDP Per Capita", "Divorce Rate", "First Marriage Age", "Number of Households", "Religion Importance", "Irreligion Level")),
        hr(),
        helpText("This humble App tries to find what which factors could be associated to the risk of sucide. Please select those factors from list above to see the regression graph. All data comes from Wikipedia"),
        hr(),
        helpText("NOTE: Please wait until the data is loaded")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("plot"),
        verbatimTextOutput("summary")
      )
      
    )
  )
)