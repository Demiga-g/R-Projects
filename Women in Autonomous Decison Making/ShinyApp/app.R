library(shiny)

ui <- fluidPage(
  titlePanel(
    "Women in Autonomous Decision Making"
  ), 
  navlistPanel(
    tabPanel(title="Women, Business, and Law"),
    tabPanel(title="Gender Equality Response"),
    tabPane
  ),
  mainPanel(
    
  ),
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)