library(shiny)
library(rCharts)
library(data.table)


shinyUI(
  
  navbarPage("Wage data explorer and predictor",tabPanel("Plot",                                             
              sidebarPanel(sliderInput("range", "Age:", min = 18, max = 80, 
              value = c(18, 80),format="####"), 
               radioButtons("HealthInsurance", "Health Insurance", 
                                  c("1. Yes" = 1, "2. No" = 2)
                                )),
                                                
 mainPanel(tabsetPanel(tabPanel('By Education/Race',column(3,wellPanel(radioButtons("JobClass","Job Class:",c("Both" = "both", "Information" = "Information", "Industrial" = "Industrial")))),
                                h4('Wage by education', align = "center"),showOutput("WageAgebyeducation", "nvd3"),
                                h4('Wage by race', align = "center"),showOutput("WageAgebyrace", "nvd3"))))),
          #             tabPanel('By Education',h4('Wage By Age', align = "center"),showOutput("WageAgebyeducation", "polycharts")))))),
                       
              #         tabPanel("About",mainPanel(includeMarkdown("README.md"))),
 tabPanel("Prediction",sidebarPanel(
 selectInput('sex', label = h3("Select sex"), 
             choices = list("1. Male" = '1. Male', "2. Female" = '2. Female'), 
             selected = 1),
 sliderInput('age', label = h3("choose your age"), min = 18, 
             max = 80, value = 37),
 selectInput('maritl', label = h3("marital situation"), 
             choices = list("1. Never Married" = '1. Never Married', "2. Married" = '2. Married', "3. Widowed" = '3. Widowed',
                            "4. Divorced" = '4. Divorced', "5. Separated" = '5. Separated'), selected = 1),
 selectInput('race', label = h3("race"), 
             choices = list("1. White" = '1. White', "2. Black" = '2. Black', "3. Asian" = '3. Asian',
                            "4. Other" = '4. Other'), selected = 1),
 selectInput('education', label = h3("education"), 
             choices = list("1. < HS Grad" = '1. < HS Grad', "2. HS Grad" = '2. HS Grad', "3. Some College" = '3. Some College',
                            "4. College Grad" = '4. College Grad', "5. Advanced Degree" = '5. Advanced Degree')
             , selected = 1),
 selectInput('jobclass', label = h3("jobclass"), 
             choices = list("1. Industrial" = '1. Industrial', "2. Information" = '2. Information')
             , selected = 1),
 selectInput('health_ins', label = h3("health insurance"), 
             choices = list("1. Yes" = '1. Yes', "2. No" = '2. No')
             , selected = 1)
 #submitButton('Submit')
 ),
 mainPanel(
   h3('Results of prediction'),
   verbatimTextOutput("valueinput")
 )),
 tabPanel("About",mainPanel(includeMarkdown("README.md")))
))