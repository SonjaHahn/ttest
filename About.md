---
title: "ttest_About.md"
author: "SonjaHahn"
date: "1 9 2019"
output: html_document
---

## Über diese App

### Hintergrund und Verwendung der App

Mit dieser App können, ausgehend von den Kennwerten zweier Stichproben, Ergebnisse inferenzstatistischer Tests berechnet sowie der Einfluss von Stichproben-Eigenschaften, wie z.B. der Stichprobengrößen, betrachtet werden.

Im linken Bereich können entsprechende Angaben zur Stichprobe gemacht sowie verschiedene Ausgaben und Berechnungen angefordert werden.
                     
Im rechten Bereich erscheinen auf der Grundlage dieser Eingaben statistische Kennwerte und Grafiken.

#### Deskriptive Kennwerte und Histogramme

 * Deskriptive Kennwerte zu beiden Stichproben, die lediglich die Eingaben wiedergeben.  
   Hinweis: Mittelwerte und Standardabweichungen können im linken Bereich Zahlen auch über die Tastatur eingegeben werden können.
 * Eine Grafik, die durch zwei Histogramme diese Angaben visualisiert, wahlweise als überlagertes Histogramm oder zwei getrennte Histogramme.  
   Hinweis: Diese Histogramme stellen eine von mehren möglichen Stichproben da, die mit den entsprechenden Angaben zu den Stichproben-Größen, -Mittelwerten und Standardabweichungen gebildet werden können.
 * Zusätzlich können zwei Dichtekurven ausgegeben werden, die jedoch die Angaben zu den Stichproben direkt als theoretische Werte verwenden. 

#### Inferenzstatistische Tests

 * Levene-Test: Hier wird getestet, ob sich die Standardabweichungen bzw. Varianzen in den beiden Gruppen signifikant unterscheiden.
 * t-Test (auch: *t*-Test für gleiche Varianzen): Dieser *t*-Test testet, ob sich die Mittelwerte in beiden Gruppen signifikant unterscheiden. Er beruht auf der Annahme von gleichen Varianzen in den beiden Gruppen. 
 * Welch-Test (auch: *t*-Test für ungleiche Varianzen): Er testet ebenfalls, ob sich die Mittelwerte in beiden Gruppen signifikant unterscheiden. Im Gegensatz zum klassischen *t*-Test beruht er nicht auf der Annahme gleicher Varianzen in den beiden Gruppen.
  

#### Effektstärkemaß

 * Das Effektstärkemaß Cohen's *d* relativiert den Mittelwertsunterschied zwischen den beiden Stichproben an den Standardabweichungen. Im Gegensatz zu den inferenzstatistischen Tests ist die Stichprobengröße lediglich für die Gewichtung der Standardabweichungen relevant.

#### Abschließende Hinweise

Die Ausgabe der Tests orientiert sich an der Ausgabe von Datenanalyse-Software, wie z.B. SPSS, und ist recht reduziert. So führen z.B. die t-Tests zweiseitige Testungen für ungerichtete Hypothesen aus. In R selbst sind weitere Informationen und Optionen verfügbar.
                    
Mit dem Aktualisieren-Button des Browsers können Sie die Angaben auf die ursprünglichen Angaben der App zurücksetzen.


### Code

Diese App wurde mit R und [Shiny](http://www.rstudio.com/shiny/) entwickelt.

Der Code für die App kann unter [GitHub](https://github.com/SonjaHahn/ttest) eingesehen und heruntergeladen werden.
                     
Die App verwendet folgende R-Pakete:

 ```{libraries, eval = FALSE}
library(shiny)
library(ggplot2)
library(cowplot)
library(plyr)
library(car)
library(effsize)
``` 

                     
Die App kann mit den folgenden Befehlen lokal auf einem Rechner in R ausgeführt werden:

 ```{run app, eval = FALSE}
library(shiny)
runGitHub("ttest","SonjaHahn")
``` 
                                          
                      
### Autor

Sonja Hahn  
[Pädagogische Hochschule Karlsruhe](https://www.ph-karlsruhe.de)


#### Lizenz
Diese App kann unter folgender Lizenz verwendet und weiterentwickelt werden: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

