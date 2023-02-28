library(shiny)
library(shinydashboard)
library(shinycssloaders)

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
      conditionalPanel("input.sidebar == 'WBL' && input.tab_1 == 'map_1'", selectInput("indicators", label="Indicator", choices=wbl_inds)),
      conditionalPanel("input.sidebar == 'WBL' && input.tab_1 == 'map_1'", selectInput("wbl_years", label="Year", choices=wbl_yrs)),
      menuItem(text="Gender Equality", tabName="GE", icon=icon("balance-scale")),
      conditionalPanel("input.sidebar == 'GE' && input.tab_2 == 'map_2'", selectInput("opinions", label="Opinion", choices=ge_ops)),
      conditionalPanel("input.sidebar == 'GE' && input.tab_2 == 'map_2'", selectInput("ge_years", label="Year", choices=ge_yrs))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(
        tabName="WBL", 
        tabBox(
          id="tab_1", width=12,
          tabPanel(title="About", icon=icon("info-circle"), 
                   h4("Placeholder tab1"), 
                   p("eionewqroen")),
          tabPanel(title="Visualization", icon=icon("globe"), value="map_1",
                   fluidRow(column(10, withSpinner(plotOutput("wbl_map", height=520, width=1000))),
                            column(2, textInput("region_code", label="Region Code", placeholder="DZ"),
                                   textOutput("region_name1"))
                   )
                   
          )
        )
      ),
      
      tabItem(
        tabName="GE", 
        tabBox(
          id="tab_2", width=12,
          tabPanel(title="About", icon=icon("info-circle"), h4("Placeholder tab1")),
          tabPanel(title="Visualization", icon=icon("globe"), value="map_2",
                   fluidRow(column(10, withSpinner(plotOutput("ge_map", height=520, width=1000))),
                            column(2, textInput("region_code", label="Region Code", placeholder="DZ"),
                                   textOutput("region_name2"))
                  )
          )
        )
      )
    )
  )
)