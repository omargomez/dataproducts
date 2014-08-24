library(shiny) 
library(RCurl)
library(ggplot2)
library(labeling)

RAW <- read.csv(text=getURL("https://03a22e53e220aa9d1c98c2dc3cbf5359ba61ac3f.googledrive.com/host/0B82pD6IuRl_7R0VfLTYxQjlicWM/suicidedata.html"), header=TRUE, sep = "\t")

shinyServer(
  function(input, output) {

      ## choices=c("Unemployment Rate","GDP Per Capita", "Divorce Rate", "First Marriage Age", "Number of Households", "Religion Importance", "Irreligion Level"))
    predictor <- reactive({
      ##hr()
      switch(input$factor,
             "Unemployment Rate" = "unemployment.rate",
             "GDP Per Capita" = "pci.int.dollar",
             "Divorce Rate" = "divorce.ratio",
             "First Marriage Age" = "first.marriage.age",
             "Number of Households" = "household.size.persons",
             "Religion Importance" = "rel.importance.percentage",
             "Irreligion Level" = "irreligion.percentage"
      )
    })
    
    
    
    output$plot <- renderPlot({
       # generate an rnorm distribution and plot it
      PRED <- predictor()
      IRR <- RAW[, c( "num.by.100k", PRED ) ]
      IRR <- IRR[ complete.cases(IRR), ]
      sp <- ggplot(IRR, aes_string(x=PRED, y="num.by.100k"))
      sp + geom_point() + stat_smooth(method=lm) + xlab(input$factor) + ylab("Suicides per 100,000 people per year")
    })
    
    output$summary <- renderPrint({
      PRED <- predictor()
      IRR <- RAW[, c( "num.by.100k", PRED ) ]
      IRR <- IRR[ complete.cases(IRR), ]
      x <- IRR[, PRED]
      y <- IRR$num.by.100k
      summary(lm( y~x )  )
    })
    
  } 
)