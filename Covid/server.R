#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    download.file('https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/02-05-2021.csv','data.csv')
    inputs <- read.csv2('data.csv',sep = ',')
    inputs <- inputs[,c('Province_State','Country_Region','Lat','Long_','Deaths','Recovered','Active')]
    output$country <- renderUI({
        selectInput("country", "Choose a country:", as.list(unique(inputs$Country_Region))) })
    output$type <- renderUI({
        selectInput("type", "Choose Type:", c('Deaths','Recovered','Active')) })
    output$plot1<- renderLeaflet({
        country <- inputs[inputs$Country_Region == input$country,]
        names(country) <- c('Province_State','Country_Region','Lat','Lng','Deaths','Recovered','Active')
        color_point <- if (input$type == 'Deaths') 'Red' else if (input$type == 'Active') 'Orange' else 'Green'
        country$Lat <- as.numeric(country$Lat)
        country$Lng <- as.numeric(country$Lng)
        country %>%
        leaflet() %>%
        addTiles() %>%
        addCircles(weight = 2, radius = sqrt(country[,colnames(country) == input$type]) * 100 ,
                   popup = country$Province_State, label = country[,colnames(country) == input$type],
                   color = color_point)
        })
    })
