#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
# Define UI for application that draws a histogram
shinyUI(pageWithSidebar(

        # Application title
        titlePanel("Case of covid until the date 02/05/2021"),
        sidebarPanel(
            uiOutput("country"),
            uiOutput("type")),
        mainPanel(
            leafletOutput('plot1'))
))
