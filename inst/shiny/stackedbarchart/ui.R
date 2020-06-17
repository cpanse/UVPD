#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Ultra HRMS in combination with UVPD fragments"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            tagList(
                htmlOutput('selectRData'),
                htmlOutput('selectCompound'),
                selectInput("ppmerror", "ppm error cut-off",c(1, 5, 10, 15, 20, 50, 100), multiple = FALSE, selected = 10),
                htmlOutput('selectCluster')
            )),
        
        # Show a plot of the generated distribution
        mainPanel(tabsetPanel(
            tabPanel("stacked", list(
                column(width = 10,
                       plotOutput("stackedBarChart"),
                       plotOutput("top3"),
                       plotOutput("bwplot"),
                ))),
            tabPanel("stacked group", list(
                column(width = 10,
                       plotOutput("stackedBarChartGroup")
                       
                ))),
            tabPanel("error", list(
                column(width = 10,       
                       plotOutput("distPlot"),
                       tableOutput('table'),
                       
                ))),
            tabPanel("ms2", list(
                column(width = 10,             
                       plotOutput("xyplot")
                ))),
            # plotOutput("barchart")
            tabPanel("matchen in-silico cluster table", list(
                column(width = 10,   
                       tableOutput('ThermoUVPD'),
                )))
            
        ) 
        )
    )
))