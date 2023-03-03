
function(input, output, session) {
  
  output$dev_rel1 <- renderInfoBox({
    infoBox(title="Development Relevance", 
            subtitle = "The knowledge and analysis provided by Women, Business and the Law make a strong economic case for laws that empower women. Better performance in the areas measured by the Women, Business and the Law index is associated with more women in the labor force and with higher income and improved development outcomes. Equality before the law and of economic opportunity are not only wise social policy but also good economic policy. The equal participation of women and men will give every economy a chance to achieve its potential. Given the economic significance of women's empowerment, the ultimate goal of Women, Business and the Law is to encourage governments to reform laws that hold women back from working and doing business.",
            fill=FALSE)
  })
  
  output$con_meth1 <- renderInfoBox({
    infoBox(title="Statistical Concept and Methodology",
            subtitle = "Women, Business and the Law tracks progress toward legal equality between men and women in 190 economies. Data are collected with standardized questionnaires to ensure comparability across economies. Questionnaires are administered to over 2,000 respondents with expertise in family, labor, and criminal law, including lawyers, judges, academics, and members of civil society organizations working on gender issues. Respondents provide responses to the questionnaires and references to relevant laws and regulations. The Women, Business and the Law team collects the texts of these codified sources of national law - constitutions, codes, laws, statutes, rules, regulations, and procedures - and checks questionnaire responses for accuracy. Thirty-five data points are scored across eight indicators of four or five binary questions, with each indicator representing a different phase of a woman’s career. Indicator-level scores are obtained by calculating the unweighted average of the questions within that indicator and scaling the result to 100. Overall scores are then calculated by taking the average of each indicator, with 100 representing the highest possible score.", 
            fill=FALSE)
  })
  
  output$lim_exc1 <- renderInfoBox({
    infoBox(title="Limitations and Exceptions",
            subtitle=tags$p("The Women, Business and the Law methodology has limitations that should be considered when interpreting the data. 

All eight indicators are based on standardized assumptions to ensure comparability across economies. Comparability is one of the strengths of the data, but the assumptions can also be limitations as they may not capture all restrictions or represent all particularities in a country. 

It is assumed that the woman resides in the economy's main business city of the economy. In federal economies, laws affecting women can vary by state or province. Even in nonfederal economies, women in rural areas and small towns could face more restrictive local legislation. Such restrictions are not captured by Women, Business and the Law unless they are also found in the main business city. The woman has reached the legal age of majority and is capable of making decisions as an adult, is in good health and has no criminal record. She is a lawful citizen of the economy being examined, and she works as a cashier in the food retail sector in a supermarket or grocery store that has 60 employees. She is a cisgender, heterosexual woman in a monogamous first marriage registered with the appropriate authorities (de facto marriages and customary unions are not measured), she is of the same religion as her husband, and is in a marriage under the rules of the default marital property regime, or the most common regime for that jurisdiction, which will not change during the course of the marriage. She is not a member of a union, unless membership is mandatory. 

Membership is considered mandatory when collective bargaining agreements cover more than 50 percent of the workforce in the food retail sector and when they apply to individuals who were not party to the original collective bargaining agreement. Where personal law prescribes different rights and obligations for different groups of women, the data focus on the most populous group, which may mean that restrictions that apply only to minority populations are missed. 

Women, Business and the Law focuses solely on the ways in which the formal legal and regulatory environment determines whether women can work or open their own businesses. The data set is constructed using laws and regulations that are codified (de jure) and currently in force, therefore implementation of laws (de facto) is not measured. The data looks only at laws that apply to the private sector. These assumptions can limit the representativeness of the data for the entire population in each country. 

Finally, Women, Business and the Law recognizes that the laws it measures do not apply to all women in the same way. Women face intersectional forms of discrimination based on gender, sex, sexuality, race, gender identity, religion, family status, ethnicity, nationality, disability, and a myriad of other grounds.

Women, Business and the Law therefore encourages readers to interpret the data in conjunction with other available research.
"))
  })
  
  # Women, Business, and Law Plot
  select_wbl <- reactive({
    biz_law %>% filter(year==input$wbl_years,
                       indicator == input$indicators)}) %>%
    bindCache(input$wbl_years, input$indicators)
  
  plot_wbl <- reactive({
    africa_map %>% left_join(select_wbl(), by=c("region"))}) 
  
  country_labs <- reactive({
    ggrepel::geom_label_repel(aes(label=country_code), data=country_labels,
                              size=2.5, max.overlaps = 35, label.size=0,
                              arrow=arrow(length=unit(0.006, 'cm')))})
  
  output$wbl_map <- renderPlot({
    ggplot(plot_wbl(), aes(x=long, y=lat, group=group))+
      coord_equal()+
      geom_polygon(aes(fill=score), color="#ffefdb")+
      scale_fill_continuous(name=paste0(unique(input$indicators), 
                                        " Indicator Score (%)"), 
                            type="viridis", guide=guide_colorbar(
                              direction = "horizontal", label.position = "bottom",
                              barheight = unit(2, units = "mm"), 
                              barwidth = unit(50, units = "mm"), 
                              draw.ulim = F, title.position = 'top',
                              title.hjust = 0.5, label.hjust = 0.5))+
      theme_void()+
      labs(
        title=paste0("Women, Business and the Law: ", 
                     {unique(input$indicators)}, 
                     " Indicator Score, ", {unique(input$wbl_years)}))+
      country_labs()
  }, res=94) %>% bindCache(plot_wbl())
    
  
  
  # Gender Equality Plot
  select_ge <- reactive({
    equality %>% filter(year==input$ge_years,
                        opinion==input$opinions)}) %>%
    bindCache(input$ge_years, input$opinions)
  
  plot_ge <- reactive({africa_map %>% left_join(select_ge(), by=c("region"))})
  output$ge_map <- renderPlot({
    ggplot(plot_ge(), aes(x=long, y=lat, group=group))+
      coord_equal()+
      geom_polygon(aes(fill=response), color="#ffefdb")+
      theme_void()+
      scale_fill_manual(values=c("#0b84a5", "#f17853", "#ffb600"), 
                        labels=(c("No", "Yes", "No Data")),
                        guide=guide_legend(title.position="top", 
                                           label.hjust=0.5, title.hjust=0.5,
                                           keywidth=unit(2, units="mm")),
                        name=unique(input$opinions)) +
      labs(title=paste0("A woman can ", {unique(input$opinions)}, 
                        " the same way as a man, ",
                        {unique(input$ge_years)}))+
      country_labs()
  }, res=94) %>% bindCache(plot_ge())
  
  region_name <- reactive({
    reg_name <- (country_labels %>%
       filter(country_code == input$region_code) %>%
       select(region))[[1]]
  })
  
  output$region_name1 <- renderText({
    region_name()
  })
  
  output$region_name2 <- renderText({
    region_name()
  })
}