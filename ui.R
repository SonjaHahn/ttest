

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
        numericInput("mx", " Mittelwert", 60.00, step=5),
        numericInput("sdx", " SD", 10.00, min=0, step=5)
        ),

        
        sliderInput("ny", " Stichprobe B: Größe (n)",
                    min =1, max = 500, 30),
    
        splitLayout(   
        numericInput("my", " Mittelwert", 50.00, step=5),
        numericInput("sdy", " SD", 10.00, min=0, step=5)
        ),
        
        p(br()),
        
        
        # Output
        
        h4("Gewünschte Ausgaben:"),
        
        strong('Tests'),
        checkboxInput("LevTest", "Levene-Test", FALSE),
        checkboxInput("tTest", "t-Test", FALSE),
        checkboxInput("WelchTest", "Welch-Test", FALSE),
    
        strong('Effektstärke'),
        checkboxInput("CohD", "Cohen's d", FALSE)
        ),
    
    
    
    mainPanel(
        tabsetPanel(
            
            tabPanel(
                "Ausgaben",

                     h4("Deskriptive Kennwerte"),
                     tableOutput("values"),
                     

                     h4("Histogramme mit Mittelwerten"),
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
            
            tabPanel("Verwendung",
                     
                     h3("Verwendung der App"),
                     
                     p("Mit dieser App können, ausgehend von den Kennwerten zweier Stichproben, Ergebnisse inferenzstatistischer Tests berechnet 
                     sowie der Einfluss von Stichproben-Eigenschaften, wie z.B. der Stichprobengrößen, betrachtet werden.", br(),
                       
                       "Im linken Bereich können entsprechende Angaben zur Stichprobe gemacht sowie verschiedene Ausgaben und Berechnungen angefordert werden.", br(),
                     
                     "Im rechten Bereich erscheinen auf der Grundlage dieser Eingaben statistische Kennwerte und Grafiken:"),
                     
                     h4("Deskriptive Kennwerte und Histogramme"),
                     
                     tags$ul(
                         tags$li("Deskriptive Kennwerte zu beiden Stichproben, die lediglich die Eingaben wiedergeben. 
                                 Hinweis: Mittelwerte und Standardabweichungen können im linken Bereich Zahlen auch über die Tastatur eingegeben werden können."),
                         tags$li("Ene Grafik, die durch zwei Histogramme diese Angaben visualisiert. 
                                  Hinweis: Diese Histogramme stellen eine von mehren möglichen Stichproben da, die mit den entsprechenden 
                                 Angaben zu den Stichproben-Größen, -Mittelwerten und Standardabweichungen gebildet werden können.")
                     ),
                     
                     h4("Inferenzstatistische Tests"), 
                         tags$ul(
                             tags$li("Levene-Test: Hier wird getestet, ob sich die Standardabweichungen bzw. Varianzen in den beiden Gruppen signifikant unterscheiden."), 
                             tags$li("t-Test (auch: t-Test für gleiche Varianzen): Dieser t-Test testet, ob sich die Mittelwerte in beiden Gruppen signifikant unterscheiden. 
                             Er beruht auf der Annahme von gleichen Varianzen in den beiden Gruppen. "),
                             tags$li("Welch-Test (auch: t-Test für ungleiche Varianzen): Er testet ebenfalls, ob sich die Mittelwerte in beiden Gruppen signifikant unterscheiden.
                                     Im Gegensatz zum klassichen t-Test beruht er nicht auf der Annahme gleicher Varianzen in den beiden Gruppen.")
                         ),
                     
                     h4("Effektstärkemaß"),
                        tags$ul(
                            tags$li("Das Effektstärkemaß Cohen's d relativiert den Mittelwertsunterschied zwischen den beiden Stichproben 
                                  an den Standardabweichungen. Im Gegensatz zu den inferenzstatistischen Tests ist die Stichprobengröße 
                                 lediglich für die Gewichtung der Standardabweichungen relevant.")
                     ),
                     
                     p('Die Ausgabe der Tests orientiert sich an der Ausgabe von Datenanalyse-Software, wie z.B. SPSS, und ist recht reduziert. 
                       So führen z.B. die t-Tests zweiseitige Testungen für ungerichtete Hypothesen aus. In R selbst sind weitere Informationen und Optionen verfügbar. '),
                    
                     br(),
                     p("Mit dem Aktualisieren-Button des Browsers können Sie die Angaben auf die ursprünglichen Angaben der App zurücksetzen.")
            ),

            tabPanel("Arbeitsaufträge",
                     
                     h3("Arbeitsaufträge mit der App"),
                     
                     p("Folgende Fragen und Aufgabenstellungen können mit dieser App bearbeitet werden:"),
                     
                     h4("Deskriptive Kennwerte und Histogramme"),                     
                     
                     p("Vergleichen Sie die Angaben für die Stichproben mit der Tabelle und den Histogrammen:"), 
                            tags$ol(
                              tags$li("Verändern Sie die Eingaben (Stichprobengrößen, Mittelwerte, Standardabweichungen):
                                 Wie verändern sich die Zahlen und die Grafiken?"),
                              tags$li("Stellen Sie auch einen Bezug zwischen der Tabelle und der Grafik her: Welche Werte können Sie direkt ablesen?
                                      Welche Werte können Sie aus dem Histogramm abschätzen oder berechnen? Inwiefern hilft Ihnen dabei ein Vergleich der 
                                      beiden Stichproben oder eine Veränderung der Stichproben-Eigenschaften im linken Bereich der App?")
                            ),
            
                    h4("Inferenzstatistische Tests"), 
                    p("Hier sollten Sie die Möglichkeit verwenden, im linken Bereich die Ergebnisse verschiedener inferenzstatistischer Tests anzufordern."),
                            tags$ol(
                                 tags$li("Warum sollte überhaupt getestet werden? (D.h. was ist der Sinn dieser Tests?)"),
                                 tags$li("Welche Tests sind sinnvoll? In welcher Reihenfolge und warum?"),
                                 tags$li("Interpretieren Sie die Zahlen der Tests!"),
                                 tags$li("Stellen Sie einen Unterschied in den Stichproben-Mittelwerten ein.
                                         Erhöhen und verringern Sie nun die Stichprobengrößen bei. Was können Sie bei den p-Werten beobachten?"),
                                tags$li("Welche weiteren Angaben haben Einfluss auf die p-Werte des t-Tests? 
                                        Verändern Sie die anderen Angaben zu den Stichproben und erklären Sie Ihre Beobachtungen!")
                            ),
                    
                    h4("Effektstärkemaß"),
                        p("Betrachten Sie das Effektstärkemaß Cohen's d:"),
                              tags$ol(
                                     tags$li("Interpretieren Sie das Effektgrößemaß! Wozu dient es?", br(),  
                                             "Die beiden folgenden Aufgaben können bei der Beantwortung dieser Frage helfen:"),
                                     tags$li("Stellen Sie einen Unterschied in den Stichproben-Mittelwerten ein.
                                         Erhöhen und verringern Sie nun die Stichprobengrößen bei (s. Aufgabe zu den inferenzstatistischen Tests).", br(),
                                         "Was können Sie beim Effektstärkemaß beobachten?"),
                                     tags$li("Welche weiteren Angaben haben Einfluss auf das Effektstärkemaß? 
                                             Verändern Sie die anderen Angaben zu den Stichproben und erklären Sie Ihre Beobachtungen!"),
                                     tags$li("Welche Werte kann Cohen's d annehmen?", br(), 
                                             "Welche Werte sind in Ihrem Fachgebiet üblich (z.B. in Studien oder Bezeichnungen wie mittlerer Effekt)?")
                                 ),
                    
                    h4("Aufgaben für den Transfer und zum Weiterdenken:"),
                    
                        p("Diese Aufgaben erfordern zusätzlichen Aufwand (z.B. Statistiksoftware bzw. eine Ausgabe davon, einen Artikel) und/oder Hintergrundwissen."),
                                 
                            tags$ol(
                                     tags$li("Vergleichen Sie die Ausgaben der App mit der Ausgabe Ihres Statistik-Programmes (z.B. SPSS, R, Excel...):", br(),
                                        "Welche Statistiken geben beide Programme aus, wo gibt es unterschiedliche Informationen?"),
                                     tags$li("Betrachten Sie Publikationen aus Ihrem Fachgebiet: Welche Statistiken werden typischerweise berichtet?", br(),
                                             "Auf welche Weise werden diese dargestellt?"),
                                     tags$li("Für eine gerichtete Hypothese müsste einseitig getestet werden, was diese App nicht direkt ermöglicht (aber z.B. SPSS auch nicht).
                                             Überlegen Sie, z.B. anhand eines geeigneten Forschungs-Szenarios, wie bei einer gerichteten Hypothese vorzugehen wäre.", br(),
                                             "Hinweis: Hier kann z.B. als Hintergrund auf die t-Verteilung zurückgegriffen werden.")
                                 )
                     
                     
            ),

            tabPanel("About...",

                     h3("Hintergrund und Programmiertechnisches"),
                     
                     br(),
                     
                     p("Diese App wurde mit R und ", a("Shiny", href="http://www.rstudio.com/shiny/", target="_blank"), " entwickelt und beruht
                       auf einer ausführlicheren ", a("App von Atsushi Mizumoto", href="http://langtest.jp/shiny/tut/", target="_blank"), "."),
                     br(),
                     
                     p("Der Code für die App kann bei ",  a('GitHub', href='https://github.com/SonjaHahn/ttest', target="_blank"), 
                       "eingesehen und heruntergeladen werden."),
                     br(),
                     
                     p("Die App verwendet folgende R-Pakete:"),
                     code('library(shiny)'),br(),
                     code('library(ggplot2)'),br(),
                     code('library(plyr)'),br(),
                     code('library(car)'),br(),
                     code('library(effsize)'),br(),br(),
                     
                     p("Die App kann mit den folgenden Befehlen lokal auf einem Rechner in R ausgeführt werden:"),
  
                       code('library(shiny)'),br(),
                       code('runGitHub("ttest","SonjaHahn")'),
                                                
                      
            br(),      br(),              
                      strong('Autor'),
                     p("Sonja Hahn", br(),
                       a("Pädagogische Hochschule Karlsruhe", href="www.ph-karlsruhe.de")),
                     br(),
                     
                     a(img(src="http://i.creativecommons.org/p/mark/1.0/80x15.png"), target="_blank", href="http://creativecommons.org/publicdomain/mark/1.0/")
            )
        )
    )
))

