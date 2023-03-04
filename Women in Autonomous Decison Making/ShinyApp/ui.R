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
                   fluidRow(
                     column(11, infoBoxOutput("dev_rel1", width = 12)),
                     column(1)
                   ),
                   fluidRow(
                     column(1),
                     column(11, infoBoxOutput("con_meth1", width = 12)),
                   ),
                   infoBoxOutput("lim_exc1", width=12)
                   
          ),
          tabPanel(title="Visualization", icon=icon("globe"), value="map_1",
                   fluidRow(column(10, withSpinner(plotOutput("wbl_map", height=520, width=1000))),
                            column(2, textInput("region_code", label="Region Code", placeholder="DZ"),
                                   textOutput("region_name1"))
                   )
                   
          ),
          tabPanel(title="Limitations and Exceptions", icon=icon("exclamation-circle"),
                   fluidRow(
                     box(
                       width = 12, title="Limitations and Exceptions", collapsible=TRUE, collapsed = TRUE,
                       HTML("<p>The Women, Business and the Law methodology has limitations that should be considered when interpreting the data.</p>
                   <ul> 
                   <li>All eight indicators are based on standardized assumptions to ensure comparability across economies. Comparability is one of the strengths of the data, but the assumptions can also be limitations as they may not capture all restrictions or represent all particularities in a country.</li>
                   <li>It is assumed that the woman resides in the economy's main business city of the economy. In federal economies, laws affecting women can vary by state or province. Even in nonfederal economies, women in rural areas and small towns could face more restrictive local legislation. Such restrictions are not captured by Women, Business and the Law unless they are also found in the main business city.</li> 
                   <li>The woman has reached the legal age of majority and is capable of making decisions as an adult, is in good health and has no criminal record.</li>
                   <ul>
                   <li>She is a lawful citizen of the economy being examined, and she works as a cashier in the food retail sector in a supermarket or grocery store that has 60 employees.</li> 
                   <li>She is a cisgender, heterosexual woman in a monogamous first marriage registered with the appropriate authorities (de facto marriages and customary unions are not measured).</li>
                   <li>She is of the same religion as her husband, and is in a marriage under the rules of the default marital property regime, or the most common regime for that jurisdiction, which will not change during the course of the marriage.</li> 
                   <li>She is not a member of a union, unless membership is mandatory.Membership is considered mandatory when collective bargaining agreements cover more than 50 percent of the workforce in the food retail sector and when they apply to individuals who were not party to the original collective bargaining agreement.</li>
                   </ul>
                   <li>Where personal law prescribes different rights and obligations for different groups of women, the data focus on the most populous group, which may mean that restrictions that apply only to minority populations are missed.</li>
                   <li>Women, Business and the Law focuses solely on the ways in which the formal legal and regulatory environment determines whether women can work or open their own businesses.</li>
                   <li>The data set is constructed using laws and regulations that are codified (de jure) and currently in force, therefore implementation of laws (de facto) is not measured.</li>
                   <li>The data looks only at laws that apply to the private sector. These assumptions can limit the representativeness of the data for the entire population in each country.</li> 
                   <li>Finally, Women, Business and the Law recognizes that the laws it measures do not apply to all women in the same way. Women face intersectional forms of discrimination based on gender, sex, sexuality, race, gender identity, religion, family status, ethnicity, nationality, disability, and a myriad of other grounds.</li>
                   </ul>
                  <p>Women, Business and the Law therefore encourages readers to interpret the data in conjunction with other available research.</p>")
                     )
                   ),
                   fluidRow(
                     box(title="Source", collapsible=TRUE, collapsed=TRUE, 
                         HTML("<p>World Bank: Women, Business and the Law.</p> <a href=https://wbl.worldbank.org/>")
                       
                     )
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