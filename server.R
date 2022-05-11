server <- function(input, output){
  output$plot_sum_kota <- renderPlotly({
    covid_sum_kota <- covid %>% 
      filter( covid_clean$tanggal >= input$tanggal[1] & covid_clean$tanggal <= input$tanggal[2]) %>%
      group_by(nama_kota) %>% 
      summarise(sum_kasus = sum(jumlah)) %>% 
      arrange(desc(sum_kasus)) %>% 
      ungroup()
    
    covid_sum_kota_2 <- covid_sum_kota %>% 
      mutate(label = glue("Kota {nama_kota}
                      Jumlah kasus: {comma(sum_kasus)}"))
    
    plot1 <- ggplot(covid_sum_kota_2, aes(x = sum_kasus, y = reorder(nama_kota, sum_kasus), text = label)) +
      geom_col(aes(fill = sum_kasus)) +
      scale_fill_gradient(low = "red", high = "black") +
      labs(title = "Perbandingan Kasus COVID19 Tahun 2021 Per Kota",
           x = "Jumlah Kasus",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none") 
    ggplotly(plot1, tooltip = "text")
  })
  
  output$plot_sum_kec <- renderPlotly({
    covid_sum_kec <- covid %>% 
      filter(nama_kota == input$pilih_kota_kec) %>% 
      group_by(nama_kecamatan) %>% 
      summarise(sum_kasus = sum(jumlah)) %>% 
      arrange(desc(sum_kasus)) %>% 
      ungroup()
    
    covid_sum_kec_2 <- head(covid_sum_kec, input$topnkec) %>% 
      mutate(label = glue("Kecamatan {nama_kecamatan}
                      Jumlah kasus: {comma(sum_kasus)}"))
    
    plot2 <- ggplot(covid_sum_kec_2, aes(x = sum_kasus, y = reorder(nama_kecamatan, sum_kasus), text = label)) +
      geom_col(aes(fill = sum_kasus)) +
      scale_fill_gradient(low = "red", high = "black") +
      labs(title = paste("Top", input$topnkec, "COVID19 Tahun 2021 Per Kecamatan"),
           x = "Jumlah Kasus",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none") 
    ggplotly(plot2, tooltip = "text")
  })
  
  output$plot_sum_kel <- renderPlotly({
    covid_sum_kel <- covid %>% 
      filter(nama_kota == input$pilih_kota_kel) %>% 
      group_by(nama_kelurahan) %>% 
      summarise(sum_kasus = sum(jumlah)) %>% 
      arrange(desc(sum_kasus)) %>% 
      ungroup()
    
    covid_sum_kel_2 <- head(covid_sum_kel, input$topnkel) %>% 
      mutate(label = glue("Kelurahan {nama_kelurahan}
                      Jumlah kasus: {comma(sum_kasus)}"))
    
    plot3 <- ggplot(covid_sum_kel_2, aes(x = sum_kasus, y = reorder(nama_kelurahan, sum_kasus), text = label)) +
      geom_col(aes(fill = sum_kasus)) +
      scale_fill_gradient(low = "red", high = "black") +
      labs(title = paste("Top", input$topnkel, "COVID19 Tahun 2021 Per Kelurahan"),
           x = "Jumlah Kasus",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none") 
    ggplotly(plot3, tooltip = "text")
  })
  
  output$plot_trend <- renderPlotly({
    # covid_trend <- covid_clean %>%
    #   mutate(label = glue("Bulan {nama_bulan}
    #                   Jumlah kasus: {comma(sum_kasus)}"))

    plot4 <- ggplot(covid_clean, aes(x = nama_bulan, y = sum(jumlah))) +
      geom_col(aes(fill = sum(jumlah))) +
      labs(title = "Trend COVID19 Tahun 2021",
           x = "Bulan",
           y = "Jumlah Kasus") +
      theme_minimal() +
      theme(legend.position = "none")
    ggplotly(plot4, tooltip = "text")
  })
  
  output$table <- renderDT({
    datatable(covid_clean, option = list(scrollX = TRUE, scrollY = TRUE))
  })
}