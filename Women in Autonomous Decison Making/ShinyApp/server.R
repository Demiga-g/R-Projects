
function(input, output, session) {
  
  output$lim_exp3 <- renderInfoBox({
    infoBox(title=h4("Verdict"), icon=icon("gavel"), fill=TRUE, color="olive",
            subtitle=p("Women, Business and the Law therefore encourages readers to interpret the data in conjunction with other available research."))
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
  
  # Region code identification
  
  output$region_name1 <- renderText({
    (country_labels %>%
       filter(country_code == str_to_lower(input$region_code1) | 
                country_code == str_to_upper(input$region_code1) | 
                country_code == str_to_sentence(input$region_code1) | 
                country_code == str_to_title(input$region_code1)) %>%
       select(region))[[1]]
    })
  
  output$region_name2 <- renderText({
    (country_labels %>%
       filter(country_code == str_to_lower(input$region_code2) | 
                country_code == str_to_upper(input$region_code2) | 
                country_code == str_to_sentence(input$region_code2) | 
                country_code == str_to_title(input$region_code2)) %>%
       select(region))[[1]]
    })
  
  ind_details <- reactive({
    ind_means <- (meta_info %>%
       filter(Short.Name == input$indicators) %>%
       select(Long.definition))[[1]]
  })
  
  output$wbl_explainer <- renderText({
    ind_details()
  })
  
  op_details <- reactive({
    op_means <- (meta_info %>%
       filter(Short.Name == input$opinions) %>%
       select(Long.definition))[[1]]
  })
  
  output$ge_explainer <- renderText({
    op_details()
  })
}