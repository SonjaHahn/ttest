

library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
    
    # Application title
    headerPanel("Vergleich zweier unabhängiger Stichproben"),
    
    
    # Flow Layout
    sidebarPanel(
        
        
        # Input
        
        h4("Angaben:"),
        
        sliderInput("nx", " Stichprobe A: Größe (n)",
                    min =1, max = 500, 30),
        
        splitLayout(
        numericInput("mx", " Mittelwert", 50.00, step=5),
        numericInput("sdx", " SD", 10.00, min=0, step=5)
        ),

        
        sliderInput("ny", " Stichprobe B: Größe (n)",
                    min =1, max = 500, 30),
    
        splitLayout(   
        numericInput("my", " Mittelwert", 60.00, step=5),
        numericInput("sdy", " SD", 10.00, min=0, step=5)
        ),
        
        p(br()),
        
        
        # Output
        
        h4("Gewünschte Ausgaben:"),
        
        strong('Grafik(-optionen)'), 

        checkboxInput("Dichte", "Dichtekurven", FALSE),
        checkboxInput("Hist", "Histogramme überlagert", TRUE),
        
        strong('Tests'),
        checkboxInput("LevTest", "Levene-Test", FALSE),
        checkboxInput("tTest", "t-Test", FALSE),
        checkboxInput("WelchTest", "Welch-Test", FALSE),
    
        strong('Effektstärke'),
        checkboxInput("CohD", "Cohen's d", FALSE),
        
        br(),
        
        h4("Zusätzliche Materialien"),
        #a("Arbeitsaufträge als pdf öffnen",target="_blank",href="Arbeitsauftraege.pdf"),
        
        shiny::actionButton(inputId='ab1', label="Arbeitsaufträge (PDF)", 
                            icon = icon("th"), 
                            onclick ="window.open('Arbeitsauftraege.pdf', '_blank')")
        
        ),
    
    
    
    mainPanel(
        tabsetPanel(
            
            tabPanel(
                "Ausgaben",

                     h3("Deskriptive Kennwerte"),
                     tableOutput("values"),
                
                conditionalPanel(condition = "input.Dichte == true ",  
                                 h3("Dichte-Kurven"),
                                 p("vereinfacht, da Stichproben-Kennwerte verwendet"),
                                 plotOutput("Dichten", height = "200px")),
                     

                     h3("Histogramme mit Mittelwerten"),
                     p("für zwei mögliche Stichproben zu den Angaben"),
                     plotOutput("histogramms", height = "200px"),
                     
                     br(),
                
                # Tests
                
                conditionalPanel(condition = "input.tTest == true || input.WelchTest == true || input.LevTest == true",  
                   h4("Inferenzstatistische Tests")),
                   
                conditionalPanel(condition = "input.LevTest == true",
                     h5("Levene-Test:"),
                     textOutput("levtest")),
                br(),

                conditionalPanel(condition = "input.tTest == true",
                     h5("t-Test für gleiche Varianzen:"),
                     textOutput("ttest1")),
                br(),

                conditionalPanel(condition = "input.WelchTest == true",                
                     h5("Welch-Test (t-Test für ungleiche Varianzen):"),
                      textOutput("ttest2")),
                br(),
                
                # Effect size
                
                conditionalPanel(condition = "input.CohD == true",  
                                 h4("Effektstärke"),
                                 textOutput("CohensD")),
                
                
                     #verbatimTextOutput("ttest.out"),
                     #verbatimTextOutput("difference.out"),
                     

                     
                     br()
                     
            ),
            
            tabPanel("About",
                     includeMarkdown("About.md"))
            

        )
    )
))

# is it possible to convert instructions to a pdf?