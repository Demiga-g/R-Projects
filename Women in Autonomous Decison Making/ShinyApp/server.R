
function(input, output, session) {
  
  # Women, Business, and Law Plot
  select_wbl <- reactive({biz_law %>% filter(year==input$wbl_years, indicator == input$indicators)})
  plot_wbl <- reactive({africa_map %>% left_join(select_wbl(), by=c("region"))})
  output$wbl_map <- renderPlot({
    plot_wbl() %>%
      ggplot(aes(x=long, y=lat, group=group))+
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
      theme_map()+
      theme(legend.position = "bottom")+
      labs(
        title=paste0("Women, Business and the Law: ", 
                     {unique(input$indicators)}, 
                     " Indicator Score, ", {unique(input$wbl_years)}),
        caption=paste0("Data Source: World Bank\n",
                     "Last Update 2023/01/31\n", 
                     "Author: Midega George"))+
      ggrepel::geom_label_repel(aes(label= country_code), data=country_labels, 
                                size=2.5, max.overlaps = 25, label.size=0, 
                                arrow=arrow(length=unit(0.006, 'cm')))
  }, res=86)
  
  
}