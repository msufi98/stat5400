# Load packages
library(shiny)
library(maps)
library(mapproj)
# Load data
counties <- readRDS("C:\\Moiyyad\\STAT5400 STAT Computing\\hw6\\counties.rds")
#counties <- readRDS(file.choose())

# Source helper functions
#source("helpers.R")
source("C:\\Moiyyad\\STAT5400 STAT Computing\\hw6\\helpers.R")
# User interface
ui <- fluidPage(
  titlePanel("censusVis"),
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with
information from the 2010 US Census."),
      selectInput("var",
                  label = "Choose a variable to display",
                  choices = list('Percent White' = 'white',
                                'Percent Black' = 'black',
                                'Percent Hispanic' = 'hispanic',
                                'Percent Asian' = 'asian'
                  ),
                  selected = "Percent White"),
      sliderInput("range",
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(0, 100))
    ),
    mainPanel(plotOutput('map'))
  )
)
# Server logic
server <- function(input, output) {
  output$map <- renderPlot({
    data <- switch(input$var, 
                   'white' = counties$white,
                   'black' = counties$black,
                   'hispanic' = counties$hispanic,
                   'asian' = counties$asian);
    color <- switch(input$var,
                    'white' = "blue",
                    'black' = "green",
                    'hispanic' = "red",
                    'asian' = "purple")
    legend <- switch(input$var,
                     'white' = "Percent White",
                     'black' = "Percent Black",
                     'hispanic' = "Percent Hispanic",
                     'asian' = "Percent Asian")
                    #, <...missing code...>)
    percent_map(data, color, legend, input$range[1], input$range[2])
  })
}
# Run app
shinyApp(ui, server)