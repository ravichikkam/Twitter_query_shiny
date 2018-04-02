#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


# Define UI for application that draws a histogram
shinyUI(
  
  
  navbarPage(title = "Query Twitter", fluid = TRUE, theme = shinytheme("cosmo"),
             tags$head(
               tags$div(
                 tags$footer(tags$p("Author: Ravi Teja Chikkam"),
                             tags$a(href = "https://www.linkedin.com/in/ravitejachikkam/", "Linedin Profile"),
                             tags$p("Email: raviteja.chikkam@asu.edu", style = "color: white"),
                             tags$p("Contact: +14804019201"),
                             style = "
                             position:fixed;
                             left:0;
                             bottom:0;
                             width:100%;
                             height:50px; /* Height of the footer */
                             color: white;
                             background-color: black;
                             text-align: left;"
                             
                 )
               )
             ),
             tabPanel("Instructions",
                      tags$body(
                        
                        h1("What can this app do?", style = "padding:1px"),
                        br(),
                        p("This is a trivial app which can be used to perform some fun twitter analysis. This app has two functionalites one being to understand the twitter trends based on location and the other being understanding sentiment associated with a word in twitter.",
                          style = "font-size:16px"),
                        h1("How to use this app?", style = "padding:1px"),
                        h2("Trends tab:"),
                        p("Enter the location you want to knwo the current twitter trends. You can also look for the location in the map associated and then enter the location. As per twitter API's the results would be the twitter trends available in the closest trend location."),
                        br(),
                        h2("Word Sentiment"),
                        p("In this tab you can provide the word of your choice and obtain the top words associated with tweets containing the word of your choice. With the help of multiple visualizations the sentiment associated with your word in twitter can be obtained."),
                        br(),
                        h1("Caveats:"),
                        p("This app uses API's from twitter and google maps. It was noted that google maps api could sometimes be unavailable and thus returning 404 error. Also, pleease keep in mind the input you give to Max number of tweets field. As this number could slow the app significantly.")
                      )
                      
             ),
             tabPanel("Trends",
                      fluidPage(
                        sidebarLayout(
                          sidebarPanel(
                            textInput(inputId = "tinput0", 
                                      label = "Enter Location", 
                                      value = "San Fransisco"),
                            DT::dataTableOutput(outputId = "toutput",
                                                width = "80%"),
                            actionButton("action1", "submit_trend")
                          ),
                          mainPanel(
                            leafletOutput(outputId = "map", height = 600)
                          )
                        )
                      )
             ),
             tabPanel("Word Sentiment",
                      # Sidebar with a slider input for number of bins 
                      sidebarLayout(
                        sidebarPanel(
                          textInput(inputId = "tinput", label = "Enter the word", 
                                    value = "USA"),
                          textInput(inputId = "tinput2", label = "Since", 
                                    value = "2017-01-01"),
                          numericInput(inputId = "tinput3", 
                                    label = "Max Number of Tweets", 
                                    value = 1000),
                          textInput(inputId = "tinput4", 
                                    label = "language", value = "en"),
                          actionButton("action2", "submit")
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          # wordcloud2Output("distPlot"),
                          # plotOutput("plot")
                          tabsetPanel(
                            tabPanel("Word Cloud", {
                              wordcloud2Output("distPlot")
                            }),
                            tabPanel("Bar Plot", {
                              plotOutput("plot")
                            })
                          )
                        )
                      ))
             
             # HTML("<footer>
             #        <p>Author: Ravi Teja Chikkam</p>
             #        <p>LinkedIn page: https://www.linkedin.com/in/ravitejachikkam/</p>
             #        <p>Email: raviteja.chikkam@asu.edu</p>
             #        <p>Contact: +14804019201</p>
             #      </footer>")
  )
  
)








