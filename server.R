

library(shiny)
library(ggplot2)
library(plyr)
library(car)
library(effsize)

shinyServer(function(input, output) {
    
    options(warn=-1)
    
    # Old dataset for the old functions (should be deleted at the end)
    
    gendat <- reactive ({
        nx <- input$nx
        mx <- input$mx
        sdx <- input$sdx
        ny <- input$ny
        my <- input$my
        sdy <- input$sdy
        
        gendat1 <- function(n, mean, sd) return(scale(rnorm(n))*sd+mean)
        
        x <- gendat1(nx, mx, sdx)
        
        y <- gendat1(ny, my, sdy)
        
        list(x = x, y = y)
    })
    


# Show the input values as a table
    
    # Generate a dataset according to input values for descriptive statistcs
    
    sliderValues <- reactive ({
      n1 <- as.integer(input$nx)
      n2 <- as.integer(input$ny)
      
      data.frame(
        Stichprobe = c("A", "B"),
        n = c(n1, n2),
        Mittelwert = c(input$mx, input$my),
        Standardabweichung = c(input$sdx, input$sdy),
        stringsAsFactors=FALSE)
    })
    
    # Show the values using an HTML table
    output$values <- renderTable({
      sliderValues()
    })
    
# Generate a data example according to these values that can be used with formulas
    
    daten <- reactive({
      nx <- input$nx
      mx <- input$mx
      sdx <- input$sdx
      ny <- input$ny
      my <- input$my
      sdy <- input$sdy
      
      data.frame(aV = c(scale(rnorm(nx)),scale(rnorm(ny)))*rep(c(sdx,sdy), c(nx,ny))+rep(c(mx,my), c(nx,ny)),
                 uV = factor(rep(c("A","B"), c(nx,ny)), levels= c("A","B"), labels=c("Stichprobe A", "Stichprobe B")) )
      
    })
    
    
# Plot an histogramm of the generated data example
    
    output$histogramms <- renderPlot({
      
      daten_mw <- ddply(daten(), "uV", summarise, aV.mean=mean(aV))
      
      ggplot(daten(), aes(x=aV, fill=uV)) +
        geom_histogram(alpha=.5, position="identity", binwidth = 5) +
        geom_vline(data=daten_mw, aes(xintercept=aV.mean,  colour=uV),
                   linetype="solid", size=1, show.legend = FALSE) +
        xlab("") +
        ylab("Anzahl")+   
        ggtitle("für zwei mögliche Stichproben zu den obigen Angaben")+
        guides(fill=guide_legend(title=NULL)) +
        theme_minimal()
      
    })
    

# Conduct and present the Levene-Test
    
    output$levtest <- renderText({
      
      # Levene-Test
      lev.test <- leveneTest(aV ~ uV, data=daten())
      
      # F and dfs
      levene.1 <- paste(c("F = ", round(lev.test$F[1],2), ", df1 = ", lev.test$Df[1], ", df2 = ", lev.test$Df[2], ", "), sep = "")
      
      # p-value
      levene.2 <- if (lev.test$`Pr(>F)`[1]>= 0.0005) paste(c("p = ", round(lev.test$`Pr(>F)`[1],3))) else  "p < 0.001"
      
      # Report results
      paste(c(levene.1, levene.2), sep = "")
    })
    
# Conduct and present the t-Test
    
    output$ttest1 <- renderText({
     
       # t-Test
        t.test1 <- t.test(aV ~ uV, data=daten(), var.equal = TRUE)
        
        # t and df
        ttest.1 <- paste(c("t = ", round(t.test1$statistic,2), ", df = ", t.test1$parameter, ", "), sep = "")
        
        # p-value
        ttest.2 <- if (t.test1$p.value>= 0.0005) paste(c("p = ", round(t.test1$p.value,3))) else  "p < 0.001"
      
       # Report results
        paste(c(ttest.1, ttest.2), sep = "")
    })
    
# Conduct and present the Welch-Test
    
    output$ttest2 <- renderText({
      
      # Welch-Test/t-Test 2
      t.test2 <- t.test(aV ~ uV, data=daten(), var.equal = FALSE)
      
      # t and df
      welch.1 <- paste(c("t = ", round(t.test2$statistic,2), ", df = ", round(t.test2$parameter,2), ", "), sep = "")
      
      # p-value
      welch.2 <- if (t.test2$p.value>= 0.0005) paste(c("p = ", round(t.test2$p.value,3))) else  "p < 0.001"
      
      # Report results
      paste(c(welch.1, welch.2), sep = "")
    })
    
# Estimate effect size d
    
    output$CohensD <- renderText({
      paste("Cohen's d = ", round(cohen.d(aV ~ uV, data = daten())$estimate, 2))
    })
    
    
# * Make it possible to switch between English and German
    
    
    
})

