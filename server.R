#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#




# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   observeEvent(input$action2, {
     freq_df1 <- reactive({
       #setup_twitter_oauth(key, secret, token, accesstoken)
       tweets <- searchTwitter(input$tinput, since = input$tinput2, 
                               lang = input$tinput4, 
                               n = input$tinput3)
       tweets_vector <- sapply(tweets, function(x) x$getText())
       tweets_vector <- str_replace_all(tweets_vector,"[^[:graph:]]", " ")
       tweets_source <- VectorSource(tweets_vector)
       tweets_corpus <- VCorpus(tweets_source)
       preprocess <- function(x) {
         x <- tm_map(x, stripWhitespace)
         x <- tm_map(x, removePunctuation)
         x <- tm_map(x, content_transformer(tolower))
         x <- tm_map(x, removeWords, c(stopwords("en"), tolower(input$tinput), 
                                       "will"))
         x <- tm_map(x, content_transformer(removeNumbers))
         x
       }
       tweets_corpus <- preprocess(tweets_corpus)
       tweets_tdm <- TermDocumentMatrix(tweets_corpus)
       tweets_tdm_m <- as.matrix(tweets_tdm)
       freq <- rowSums(tweets_tdm_m)
       freq_df <- tibble(words = names(freq), value = freq)
       freq_df <- freq_df %>% arrange(desc(value))
       freq_df
     })
     output$distPlot <- renderWordcloud2({
       
       freq_df2 <- freq_df1()
       wordcloud2(data = freq_df2[1:100, ])
       
     })
     
     output$plot <- renderPlot({
       (freq_df1() %>% arrange(desc(value)))[1:20, ] %>% 
         ggplot(mapping = aes(x = words, y = value)) + 
         geom_bar(stat = "identity", fill = "steelblue") + theme_bw()
       
     })
   })
  
  
  observeEvent(input$action1, {
    output$map <- renderLeaflet({
      place <- geocode(input$tinput0)
      leaflet(place) %>% 
        addTiles() %>% setView(lng = place$lon, lat = place$lat, zoom = 12) %>% 
        addProviderTiles(providers$OpenStreetMap) %>% 
        addMarkers(lng = place$lon, lat = place$lat)
    })
    output$toutput <- DT::renderDataTable({
      place_trend <- geocode(input$tinput0)
      trend_location <- closestTrendLocations(place_trend$lat, place_trend$lon)
      getTrends(trend_location$woeid)[, 1:2]
    })
  })
  
  
  #observeEvent(input$)

})
