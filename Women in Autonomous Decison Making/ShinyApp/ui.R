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

  dashboardSidebar(width=260,
    sidebarMenu(
      id = "sidebar",
      menuItem(text="About", tabName="about", icon=icon("lightbulb")),
      menuItem(text="Visualization", tabName="viz", icon=icon("earth-africa")),
      menuItem(text="Statistical Concept and Methodology", tabName="scm", icon=icon("magnifying-glass-chart")),
      menuItem(text="Limitations and Exceptions", tabName="lim_excep", icon=icon("handshake-slash")),
      br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(),
      
      HTML(paste0(
        "<script>",
        "var today = new Date();",
        "var yyyy = today.getFullYear();",
        "</script>",
        "<p style = 'text-align: center;'><small>&copy; - <a href='https://github.com/Demiga-g/R-Projects/tree/main/Women%20in%20Autonomous%20Decison%20Making' target='_blank'>midegageorge</a> - <script>document.write(yyyy);</script></small></p>")
      )
      
    )
  ),
  
  dashboardBody(
    style = "position:relative; overflow:invisible; overflow-y:scroll",
    tags$script(HTML("$('body').addClass('fixed');")),
    tabItems(
      tabItem(
        tabName="about",
        fluidRow(
          column(1),
          column(10, HTML("<h2 style='font-family:Charcoal, sans-serif; font-size: 3em; text-align: center; margin-bottom: 10px;'>Welcome!</h2><p>  
                         This interactive website details the African countries' perspective on gender equality in terms of business and the law.</p>
                         <p>Here, a detailed outlook on the progress of African countries regarding gender equality when it comes to doing business and the law is examined. 
                         Considering that here are a lot of outcomes that could measure these countries' intervention, for this website priority is given to outcomes that touch on the norms and decision-making, employment and time use, entrepreneurship, and locus of control. </p>")),
          column(1)
        ),
        fluidRow(
          column(12, h2(style='font-family:Charcoal, sans-serif; font-size: 2.5em; text-align: center; margin-bottom: 10px;', "Development Relevance"))
        ),
        fluidRow(
          br(),
          column(5, style="background-color:lightblue;border-radius:10px", offset=1,
                 h4(p(icon("line-chart",lib = "font-awesome"), strong(" Relevance of Analysis"),style="text-align:center")), 
                 p("Women, Business and the Law tracks progress toward legal equality between men and women in the 54 African economies. The knowledge and analysis provided by this data make a strong economic case for laws that empower women.")),
          column(5, style="background-color:lightgreen;border-radius:10px", offset=1,
                 h4(p(icon("thumbs-up", lib = "glyphicon"), strong(" Performance Outcome"),style="text-align:center")), 
                 p("Better performance in the areas measured by the Women, Business and the Law index is associated with more women in the labor force and with higher income and improved development outcomes."),
          )
        ),
        br(),
        fluidRow(
          br(),
          column(5, style="background-color:orange;border-radius:10px", offset=1,
                 h4(p(icon("venus-mars", lib = "font-awesome"), strong(" Importance of Equality"),style="text-align:center")), 
                 p("Equality before the law and of economic opportunity are not only wise social policy but also good economic policy. The equal participation of women and men will give every economy a chance to achieve its potential.")
          ),
          column(5, style="background-color:#50f2e9;border-radius:10px", offset=1,
                 h4(p(icon("bullseye", lib = "font-awesome"), strong(" Ultimate Goal"),style="text-align:center")), 
                 p("Given the economic significance of women's empowerment, the ultimate goal of Women, Business and the Law is to encourage governments to reform laws that hold women back from working and doing business.")
          )
        ),
        br(),
        fluidRow(
          h2(style='font-family:Charcoal, sans-serif; font-size: 2.5em; text-align: center; margin-bottom: 10px;', "Datasets"),
          column(1),
          column(10, HTML("The data used to generate the visualizations was obtained from the Gender Statistic database hosted in the <a href='https://wbl.worldbank.org/' target='_blank'>World Bank databank</a>. 
                         The data from the <strong>Women, Business, and Law</strong> section uses eight indicators to track progress toward legal equality between men and women. 
                         The data from the <strong>Gender Equality</strong> section provides information about the perception of each African country on some fourteen indicators. 
                         Both datasets have data collected from 1960 to 2021. 
                         I hope you enjoy your interaction.")),
          column(1)
        )
        
      ),
      tabItem(
        tabName="viz",
        tabsetPanel(header = tags$style(HTML(".tabbable > .nav > li[class=active]    > a {background-color: #BFF7BB; color:black}")),
        tabPanel(title="Women, Business, and the Law",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput("indicators", label="Select an Indicator", choices=wbl_inds),
                     selectInput("wbl_years", label="Select a Year", choices=wbl_yrs),
                     textInput("region_code1", label="Check the region", placeholder="Insert region code (e.g., DZ)"),
                     textOutput("region_name1"),
                     br(),
                     fluidRow(
                       strong("Summary Info"),
                       column(12, textOutput("wbl_explainer"), style="background-color:lightgreen;border-radius: 10px;height:100px;overflow-y: scroll;")
                     )
                   ),
                   mainPanel(withSpinner(plotOutput("wbl_map", height=550, width=800)), style="width:600px;overflow-x: scroll;")
                 )
        ),
        
        tabPanel(title="Gender Equality",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput("opinions", label="Opinion", choices=ge_ops),
                     selectInput("ge_years", label="Year", choices=ge_yrs),
                     textInput("region_code2", label="Check the region", placeholder="Insert region code (e.g., DZ)"),
                     textOutput("region_name2"),
                     br(),
                     fluidRow(
                       strong("Summary Info"),
                       column(12, textOutput("ge_explainer"), style="background-color:#c9f0ff;border-radius: 10px;height:100px;overflow-y: scroll;")
                     )
                   ),
                   mainPanel(withSpinner(plotOutput("ge_map", height=550, width=800)), style="width:600px;overflow-x: scroll;")
                 )
        )
        )
      ),
      tabItem(
        tabName="scm",
        fluidRow(
          br(),
          column(3),
          column(9, style="background-color:lightblue;border-radius:10px",
                 h4(p(icon("database",lib = "font-awesome"), strong(" Data Collection"),style="text-align:left")),
                 p("Data are collected with standardized questionnaires to ensure comparability across economies. Respondents provide responses to the questionnaires and references to relevant laws and regulations.")),
        ),
        br(),
        fluidRow(
          column(2),
          column(10, style="background-color:#a3ffa9;border-radius:10px",
                 h4(p(icon("book-open-reader",lib = "font-awesome"), strong(" Respondents"),style="text-align:left")),
                 p("Questionnaires are administered to over 2,000 respondents with expertise in family, labor, and criminal law, including lawyers, judges, academics, and members of civil society organizations working on gender issues.")),
        ),
        br(),
        fluidRow(
          column(1),
          column(11, style="background-color:orange;border-radius:10px",
                 h4(p(icon("filter",lib = "font-awesome"), strong(" Data Validation"),style="text-align:left")),
                 p("The Women, Business and the Law team collects the texts of these codified sources of national law - constitutions, codes, laws, statutes, rules, regulations, and procedures - and checks questionnaire responses for accuracy."))
        ),
        br(),
        fluidRow(
          column(12, style="background-color:#50f2e9;border-radius:10px",
                 h4(p(icon("scale-unbalanced",lib = "font-awesome"), strong(" Metric"),style="text-align:left")),
                 HTML("<ul><li>Thirty-five data points are scored across eight indicators of four or five binary questions, with each indicator representing a different phase of a woman’s career.</li>
                            <li>Indicator-level scores are obtained by calculating the unweighted average of the questions within that indicator and scaling the result to 100.</li>
                            <li>Overall scores are then calculated by taking the average of each indicator, with 100 representing the highest possible score.</li></ul>"))
        )
      ),
      tabItem(
        tabName="lim_excep",
        br(),
        fluidRow(
          column(11, p("The Women, Business and the Law methodology has limitations that should be considered when interpreting the data. All eight indicators are based on standardized assumptions to ensure comparability across economies. Comparability is one of the strengths of the data, but the assumptions can also be limitations as they may not capture all restrictions or represent all particularities in a country.",
                       style="background-color:#98bfb4;border-left:8px solid #bff7bb;border-radius:8px"))
        ),
        br(),
        tabsetPanel(
          tabPanel(title="Assumptions Regarding Females",
                   fluidRow(
                     column(11, style="background-color:#bff7bb;border-radius:10px",
                            h4(p(icon("venus",lib = "font-awesome"), strong(" Assumptions Regarding Females"),style="text-align:center")),
                            HTML("<ul><li>It is assumed that the woman resides in the economy's main business city of the economy. In federal economies, laws affecting women can vary by state or province. Even in nonfederal economies, women in rural areas and small towns could face more restrictive local legislation. Such restrictions are not captured by Women, Business and the Law unless they are also found in the main business city.</li> 
                                       <li>The woman has reached the legal age of majority and is capable of making decisions as an adult, is in good health and has no criminal record.</li>
                                       <li>She is a lawful citizen of the economy being examined, and she works as a cashier in the food retail sector in a supermarket or grocery store that has 60 employees.</li> 
                                       <li>She is a cisgender, heterosexual woman in a monogamous first marriage registered with the appropriate authorities (de facto marriages and customary unions are not measured).</li>
                                       <li>She is of the same religion as her husband, and is in a marriage under the rules of the default marital property regime, or the most common regime for that jurisdiction, which will not change during the course of the marriage.</li> 
                                       <li>She is not a member of a union, unless membership is mandatory.Membership is considered mandatory when collective bargaining agreements cover more than 50 percent of the workforce in the food retail sector and when they apply to individuals who were not party to the original collective bargaining agreement.</li>
                                        </ul>"))
                   ),
          ),
          tabPanel(title="Assumptions Regarding the Law",
                   fluidRow(
                     column(11, style="background-color:#bff7bb;border-radius:10px; text-color:white",
                            h4(p(icon("scale-balanced",lib = "font-awesome"), strong(" Assumptions Regarding the Law"),style="text-align:center")), HTML("<ul>
                                       <li>Where personal law prescribes different rights and obligations for different groups of women, the data focus on the most populous group, which may mean that restrictions that apply only to minority populations are missed.</li>
                                       <li>Women, Business and the Law focuses solely on the ways in which the formal legal and regulatory environment determines whether women can work or open their own businesses.</li>
                                       <li>The data set is constructed using laws and regulations that are codified (de jure) and currently in force, therefore implementation of laws (de facto) is not measured.</li>
                                       <li>The data looks only at laws that apply to the private sector. These assumptions can limit the representativeness of the data for the entire population in each country.</li> 
                                       <li>Finally, Women, Business and the Law recognizes that the laws it measures do not apply to all women in the same way. Women face intersectional forms of discrimination based on gender, sex, sexuality, race, gender identity, religion, family status, ethnicity, nationality, disability, and a myriad of other grounds.</li>
                                        </ul>"))
                   ),
          ),
          tabPanel(title="Verdict", 
                   fluidRow(
                     column(11, infoBoxOutput("lim_exp3", width=12))
                   )
          )
        )
      )
    )
  )
)