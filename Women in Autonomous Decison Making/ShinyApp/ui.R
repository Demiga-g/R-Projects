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
          tabPanel(title="About", icon=icon("info-circle"), 
                   h4("Placeholder tab1"), 
                   p("eionewqroen")),
          tabPanel(title="Visualization", icon=icon("globe"), 
                   fluidRow(
                     column(8, selectInput("indicators", label="Indicator", choices=wbl_inds)),
                     column(4, selectInput("wbl_years", label="Year", choices=wbl_yrs))
                   ),
                   hr(),
                   fluidRow(column(12, plotOutput("wbl_map", height=700, width=1000))
                   )
          )
        )
      ),
      
      tabItem(
        tabName="GE", 
        tabBox(
          id="t1", width=12,
          tabPanel(title="About", icon=icon("info-circle"), h4("Placeholder tab1")),
          tabPanel(title="Visualization", icon=icon("globe"), 
                   fluidRow(
                     column(8, selectInput("opinions", label="Opinion", choices=ge_ops)),
                     column(4, selectInput("ge_years", label="Year", choices=ge_yrs))
                   ),
                   fluidRow(column(12, plotOutput("ge_map"))
                  )
          )
        )
      )
    )
  )
)