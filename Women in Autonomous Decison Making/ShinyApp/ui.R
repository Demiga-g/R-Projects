library(shiny)
library(shinydashboard)


dashboardPage(
  dashboardHeader(
    title = "Gender Statistics", 
    titleWidth=700,
    tags$li(class="dropdown", tags$a(href="https://github.com/Demiga-g/R-Projects/tree/main/Women%20in%20Autonomous%20Decison%20Making", icon("github"), "Source Code", target="_blank")),
    tags$li(class="dropdown", tags$a(href="https://www.linkedin.com/in/george-midega-44b3741ab/", icon("linkedin"), "My Profile", target="_blank"))
  ),
  
  dashboardSidebar(
    
    sidebarMenu(
      id = "sidebar",
      menuItem(text="Women, Business, and Law", tabName="WBL", icon=icon("female")),
      menuItem(text="Gender Equality", tabName="GE", icon=icon("balance-scale"))
    )
  ),
  
  dashboardBody(
    
    tabItems(
      
      tabItem(
        tabName="WBL", 
        tabBox(
          id="t1", width=12,
          tabPanel(title="About", icon=icon("info-circle"), h4("Placeholder tab1")),
          tabPanel(title="Visualization", icon=icon("globe"),h4("Placeholder tab2"))
        )
      ),
      
      tabItem(
        tabName="GE", 
        tabBox(
          id="t1", width=12,
          tabPanel(title="About", icon=icon("info-circle"), h4("Placeholder tab1")),
          tabPanel(title="Visualization", icon=icon("globe"), h4("Placeholder tab2"))
        )
      )
    
    
  )
)