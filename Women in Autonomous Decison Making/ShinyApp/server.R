
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
      theme(legend.position='bottom')+
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