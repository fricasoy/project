# The user-interface definition of the Shiny web app.
library(shiny)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(
    navbarPage("English Premier League Set Visualizer", 
    # multi-page user-interface that includes a navigation bar.
        tabPanel("Explore the Data",
             sidebarPanel(
                sliderInput("timeline", 
                            "Year:", 
                            min = 1993,
                            max = 2015,
                            value = c(2014, 2015)),
                sliderInput("points", 
                            "Points:",
                            min = 0,
                            max = 114,
                            value = c(0, 114) 
                ),
                            #format = "####"),
                uiOutput("themesControl"), # the id
                actionButton(inputId = "clearAll", 
                             label = "Clear selection", 
                             icon = icon("square-o")),
                actionButton(inputId = "selectAll", 
                             label = "Select all", 
                             icon = icon("check-square-o"))
        
             ),
             mainPanel(
                 tabsetPanel(
                   # Data 
                   tabPanel(p(icon("table"), "Dataset"),
                            dataTableOutput(outputId="dTable")
                   ), # end of "Dataset" tab panel
                   tabPanel(p(icon("line-chart"), "Visualize the Data"), 
                            h4('Teams by Year', align = "center"),
                            showOutput("themesByYear", "nvd3"),
                            h4('Number of Points by Year', align = "center"),
                            h5('Please hover over each point to see the Name and Points.', 
                               align ="center"),
                            showOutput("piecesByYear", "nvd3"),
                            h4('Average Points by Year', align = "center"),
                            showOutput("piecesByYearAvg", "nvd3"),
                            h4('Average Points by Team', align = "center"),
                            showOutput("piecesByThemeAvg", "nvd3")
                   ) # end of "Visualize the Data" tab panel

                 )
                   
            )     
        ), # end of "Explore Dataset" tab panel
    
        
        tabPanel("About",
                 mainPanel(
                   includeMarkdown("about.md")
                 )
        ) # end of "About" tab panel
    )
  
)
