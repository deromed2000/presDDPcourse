library(shiny)
library(ggplot2)
library(data.table)
library(maps)
library(rCharts)
library(reshape2)
library(markdown)
library(mapproj)
library(ISLR);library(randomForest); library(caret); data(Wage)
Wage1 <- subset(Wage,select=-c(logwage, region, sex, health))
WageP <- subset(Wage,select=-c(logwage, region, health))
predVar <- c("age","sex","maritl","race","education","jobclass","health_ins")
model.RF <- randomForest(x = WageP[ ,predVar],
                         y = WageP$wage,
                         ntree = 15)

years <- as.list(sort(unique(Wage$year)))
health <<- as.character(sort(unique(Wage$health_ins)))

shinyServer(function(input, output){
  
  dt <- reactive({
    tmp <- Wage1
    tmp[is.na(tmp)] <- 0
    tmp
  })
  

output$healthinsur <- renderUI({
 # if(1) {
    checkboxGroupInput('health', 'health insurance', health, selected=health)
#  }
})

output$WageAgebyeducation <- renderChart({
  dt1 <- dt()
  
  if(input$HealthInsurance[1] == "1. Yes" & is.null(input$HealthInsurance[2])){
    dt1 <- dt1[dt1$health_ins == "1. Yes",]
  }
  if(input$HealthInsurance[2] == "2. No" & is.null(input$HealthInsurance[1])){
    dt1 <- dt1[dt1$health_ins == "2. No",]
  }
#   if(input$HealthInsurance[2] == "2. No" & input$HealthInsurance[1] == "1. Yes"){
#     dt1 <- dt1
#   }
    if(input$JobClass == "Industrial") {
    data <- dt1[dt1$jobclass == "1. Industrial" & dt1$age >= input$range[1] & dt1$age <= input$range[2],]
    data <- aggregate(data.frame(wage=data$wage), by = list(year=data$year, education=data$education), mean)
  } else if(input$JobClass == "Information") {
    data <- dt1[dt1$jobclass == "2. Information" & dt1$age >= input$range[1] & dt1$age <= input$range[2],]
    data <- aggregate(data.frame(wage=data$wage), by = list(year=data$year, education=data$education), mean)
  } else {
    data  <- dt1[dt1$age >= input$range[1] & dt1$age <= input$range[2],]
    data <- aggregate(data.frame(wage=data$wage), by = list(year=data$year, education=data$education), mean)
  }
  
  
  p6 <- nPlot(wage ~ year, group = 'education', data = data, color = 'education',
                              type = 'multiBarChart', dom = 'WageAgebyeducation', width = 600)

  p6$chart(margin = list(left = 100), reduceXTicks = FALSE)
  p6$yAxis( axisLabel = "Wage", width = 80)
  p6$xAxis( axisLabel = "Year", width = 70, staggerLabels = TRUE)
  
  return(p6)
})

output$WageAgebyrace <- renderChart({
  dt1 <- dt()
  if(input$HealthInsurance[1] == "1. Yes" & is.null(input$HealthInsurance[2])){
    data <- dt1[dt1$health_ins == "1. Yes",]
  }
  if(input$HealthInsurance[2] == "2. No" & is.null(input$HealthInsurance[1])){
    data <- dt1[dt1$health_ins == "2. No",]
  }
  if(input$JobClass == "Industrial") {
    data <- dt1[dt1$jobclass == "1. Industrial" & dt1$age >= input$range[1] & dt1$age <= input$range[2],]
    data <- aggregate(data.frame(wage=data$wage), by = list(year=data$year, race = data$race), mean)
  } else if(input$JobClass == "Information") {
    data <- dt1[dt1$jobclass == "2. Information" & dt1$age >= input$range[1] & dt1$age <= input$range[2],]
    data <- aggregate(data.frame(wage=data$wage), by = list(year=data$year, race = data$race), mean)
  } else {
    data <- dt1[dt1$age >= input$range[1] & dt1$age <= input$range[2],]
    data <- aggregate(data.frame(wage=data$wage), by = list(year=data$year,race = data$race), mean)
  }
  
  p7 <- nPlot(wage ~ year, group = 'race', data = data, color = 'race',
              type = 'multiBarChart', dom = 'WageAgebyrace', width = 600, height = 600)
  p7$chart(margin = list(left = 100), reduceXTicks = FALSE)
  p7$yAxis( axisLabel = "Wage", width = 80)
  p7$xAxis( axisLabel = "Year", width = 70, staggerLabels = TRUE)
  
  return(p7)
})
                                                                                        
WagePrediction <<- function(df) predict(model.RF, newdata = df)

    dtr = reactive({tempd <- data.frame(age = input$age,
                                           sex = input$sex,
                                           maritl = input$maritl,
                                           race = input$race,
                                           education = input$education,
                                           jobclass = input$jobclass,
                                           health_ins = input$health_ins)
                    levels(tempd$sex) = levels(WageP$sex)
                    levels(tempd$maritl) = levels(WageP$maritl)
                    levels(tempd$race) = levels(WageP$race)
                    levels(tempd$education) = levels(WageP$education)
                    levels(tempd$jobclass) = levels(WageP$jobclass)
                    levels(tempd$health_ins) = levels(WageP$health_ins)
                    tempd
                       })
      
    output$valueinput <- renderPrint({ WagePrediction(dtr()) })
 
})