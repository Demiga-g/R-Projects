library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(shinythemes)


dashboardPage(
  dashboardHeader(
    title = "Gender Statistics", 
    titleWidth=250,
    tags$li(class="dropdown", tags$a(href="https://github.com/Demiga-g/R-Projects/tree/main/Women%20in%20Autonomous%20Decison%20Making", icon("github"), "Source Code", target="_blank")),
    tags$li(class="dropdown", tags$a(href="https://www.linkedin.com/in/george-midega-44b3741ab/", icon("linkedin"), "My Profile", target="_blank"))
  ),

  dashboardSidebar(disable=TRUE,
    sidebarMenu(
      id = "sidebar",
      menuItem(text="Women, Business, and Law", tabName="WBL", icon=icon("female"))
    )
  ),
  
  dashboardBody(
    tags$script(HTML("$('body').addClass('fixed');")),
    tabItems(
      tabItem(
        tabName="WBL", 
        tabBox(
          id="tab_1", width=12,
          tabPanel(title="About", icon=icon("info-circle"),
                   br(),
                   
                   fluidRow(
                     column(6, style="background-color:lightblue;border-radius:10px",
                            h4(p(icon("line-chart",lib = "font-awesome"), strong(" Relevance of Analysis"),style="text-align:center")), 
                            p("Women, Business and the Law tracks progress toward legal equality between men and women in the 54 African economies. The knowledge and analysis provided by this data make a strong economic case for laws that empower women.")),
                     
                     column(5, style="background-color:lightgreen;border-radius:10px", offset=1,
                            h4(p(icon("thumbs-up", lib = "glyphicon"), strong(" Performance Outcome"),style="text-align:center")), 
                            p("Better performance in the areas measured by the Women, Business and the Law index is associated with more women in the labor force and with higher income and improved development outcomes."),
                     )
                   ),
                   br(),
                   fluidRow(
                     column(6, style="background-color:orange;border-radius:10px",
                            h4(p(icon("venus-mars", lib = "font-awesome"), strong(" Importance of Equality"),style="text-align:center")), 
                            p("Equality before the law and of economic opportunity are not only wise social policy but also good economic policy. The equal participation of women and men will give every economy a chance to achieve its potential.")
                     ),
                     column(5, style="background-color:#50f2e9;border-radius:10px", offset=1,
                            h4(p(icon("bullseye", lib = "font-awesome"), strong(" Ultimate Goal"),style="text-align:center")), 
                            p("Given the economic significance of women's empowerment, the ultimate goal of Women, Business and the Law is to encourage governments to reform laws that hold women back from working and doing business.")
                    ),
                   )
                   
          ),
          
          tabPanel(title="Visualization", icon=icon("globe"), value="map_1", 
                   tabsetPanel(header = tags$style(
                     HTML(".tabbable > .nav > li[class=active]    > a {background-color: #BFF7BB; color:black}")
                   ),
                     tabPanel(title="Women, Business, and the Law",
                       sidebarLayout(
                         sidebarPanel(
                           selectInput("indicators", label="Select an Indicator", choices=wbl_inds),
                           selectInput("wbl_years", label="Select a Year", choices=wbl_yrs),
                           textInput("region_code", label="Region Code", placeholder="DZ"),
                           textOutput("region_name1"),
                           br(),
                           fluidRow(
                             strong("Summary Info"),
                             column(12, textOutput("wbl_explainer"), style="background-color:#fde725;border-radius: 10px;height:100px;overflow-y: scroll;")
                           )
                         ),
                         mainPanel(withSpinner(plotOutput("wbl_map", height=550, width=800)), style="height:350px;overflow-y: scroll;")
                       )
                     ),
                     
                     tabPanel(title="Gender Equality",
                              sidebarLayout(
                                sidebarPanel(
                                  selectInput("opinions", label="Opinion", choices=ge_ops),
                                  selectInput("ge_years", label="Year", choices=ge_yrs),
                                  textInput("region_code", label="Region Code", placeholder="DZ"),
                                  textOutput("region_name2"),
                                  br(),
                                  fluidRow(
                                    strong("Summary Info"),
                                    column(12, textOutput("ge_explainer"), style="background-color:#fde725;border-radius: 10px;height:100px;overflow-y: scroll;")
                                  )
                                ),
                                mainPanel(withSpinner(plotOutput("ge_map", height=550, width=820)), style="height:490px;overflow-y: scroll;")
                              )
                     )
                   )
          ),
          
          tabPanel(
            title="Statistical Concept and Methodology", icon=icon("lightbulb"),
            fluidRow(
              br(),
              column(3),
              column(9, infoBoxOutput("con_meth1", width=12)),
            ),
            fluidRow(
              column(2),
              column(10, infoBoxOutput("con_meth2", width=12)),
            ),
            fluidRow(
              column(1),
              column(11, infoBoxOutput("con_meth3", width=12))
            ),
            fluidRow(
              column(12, infoBoxOutput("con_meth4", width=12))
            )
            
          ),
          tabPanel(title="Limitations and Exceptions", icon=icon("exclamation-circle"),
                   fluidRow(
                     column(12, p("The Women, Business and the Law methodology has limitations that should be considered when interpreting the data. All eight indicators are based on standardized assumptions to ensure comparability across economies. Comparability is one of the strengths of the data, but the assumptions can also be limitations as they may not capture all restrictions or represent all particularities in a country.",
                                  style="background-color:papayawhip;border-left:8px solid coral;border-top:1px solid black;border-bottom:1px solid black;border-right: 1px solid black"))
                   ),
                   
                   tabsetPanel(
                     tabPanel(title="Assumptions Regarding Females",
                              fluidRow(
                                column(12, infoBoxOutput("lim_exp1", width=12))
                              ),
                     ),
                     tabPanel(title="Assumptions Regarding the Law",
                              fluidRow(
                                column(12, infoBoxOutput("lim_exp2",  width=12))
                              ),
                     ),
                     tabPanel(title="Verdict", 
                              fluidRow(
                                column(12, infoBoxOutput("lim_exp3", width=12))
                              )
                     )
                   )
          )
        )
      )
    )
  )
)