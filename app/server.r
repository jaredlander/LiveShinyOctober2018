library(shiny)
library(ggplot2)
library(magrittr)
library(leaflet)

pizza <- jsonlite::fromJSON('FavoriteSpots.json') %>% 
    tidyr::unnest()

shinyServer(function(input, output, session){
    
    output$CarHistogram <- renderPlot(
        ggplot(mtcars, aes_string(x=input$ColumnName)) +
            geom_histogram(bins=input$NumBins)
    )
    
    output$PizzaTable <- DT::renderDataTable(
        pizza, rownames=FALSE
    )
    
    output$PizzaMap <- renderLeaflet({
        leaflet() %>% 
            addTiles() %>%
            # addProviderTiles('Staman.Watercolor') %>% 
            addMarkers(
                lng = ~ longitude, lat = ~ latitude,
                popup = ~ Name,
                data=pizza %>% 
                    dplyr::slice(as.integer(input$PizzaTable_rows_selected))
            )
    })
})