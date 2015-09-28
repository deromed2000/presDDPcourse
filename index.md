---
title       : Wage Database explorer and predictor
subtitle    : Developping Data products Project
author      : Mohammed Derouich
job         : Data Scientist
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Wage Database Explorer

This presentation is being created as part of the peer assessment for the coursera developing data products class. The assignment has to be done with the following tools.

1. shiny to build data product application
2. R-Presentation or slidify to create data product related presentations

The application is made up of two parts :

1. The explorer panel 

2. The predictor panel 

---
 
## The Application

### The goal here is to show the difference in wage by year regarding :

1. The School grading
2. The race

The panel allows user to manipulate some parameters :

1. The nature of job among two categories : 

      a. Informational job
      
      b. Industrial job
      
2. The health insurance : this will show us the difference between those who contract a health insurance and those who do not.            

--- .class #id  

## Wage Database predictor


The predictor allows user to fill in different variables among choice lists and subsequently the algorithm behind the scene return a wage that corresponds.

The algorithm used here is the Random Forest tree.

The link to GitHub repo is https://github.com/deromed2000/presDDPcourse

---

## The data


This application is based on data collected in Mid-Atlantic region in US and consists on 3000 persons survey.


Here a sight inside the data


```r
summary(WageData)
```

```
##       year           age                     maritl           race     
##  Min.   :2003   Min.   :18.00   1. Never Married: 648   1. White:2480  
##  1st Qu.:2004   1st Qu.:33.75   2. Married      :2074   2. Black: 293  
##  Median :2006   Median :42.00   3. Widowed      :  19   3. Asian: 190  
##  Mean   :2006   Mean   :42.41   4. Divorced     : 204   4. Other:  37  
##  3rd Qu.:2008   3rd Qu.:51.00   5. Separated    :  55                  
##  Max.   :2009   Max.   :80.00                                          
##               education             jobclass     health_ins  
##  1. < HS Grad      :268   1. Industrial :1544   1. Yes:2083  
##  2. HS Grad        :971   2. Information:1456   2. No : 917  
##  3. Some College   :650                                      
##  4. College Grad   :685                                      
##  5. Advanced Degree:426                                      
##                                                              
##       wage       
##  Min.   : 20.09  
##  1st Qu.: 85.38  
##  Median :104.92  
##  Mean   :111.70  
##  3rd Qu.:128.68  
##  Max.   :318.34
```




