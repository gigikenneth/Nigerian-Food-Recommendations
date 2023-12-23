library(shiny)
library(shiny.fluent)

# Read the updated dataset (Make sure to replace the path with the location of your downloaded file)
data <- read.csv("/data/Dietary_Advice_Updated_Cycle_Day_Nigerian_Diet_Recommendations.csv")

# Define UI with custom CSS for styling
ui <- fluidPage(
  # Custom CSS for overall page styling and dataset presentation
  tags$head(
    tags$style(HTML("
            body {
                background-color: #ffe4e1; /* Soft pink background */
                color: #333; /* Darker text for readability */
            }
            .shiny-text-output {
                padding: 10px;
                margin-bottom: 10px;
                border-radius: 5px;
                background-color: #fff; /* White background for text output */
                border: 1px solid #ffccd5; /* Light pink border */
                box-shadow: 0 2px 4px rgba(0,0,0,0.1); /* Subtle shadow */
            }
            .js-irs-0 .irs-bar, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-slider {
                background: pink;
            }
            .js-irs-0 .irs-line, .js-irs-0 .irs-min, .js-irs-0 .irs-max {
                background: #ffd1dc;
            }
            .js-irs-0 .irs-from, .js-irs-0 .irs-to, .js-irs-0 .irs-single {
                background: white;
                border: solid 1px pink;
            }
        "))
  ),
  
  titlePanel("Nigerian 🇳🇬 Dietary Recommendations"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("day_slider", "Select Cycle Day:", 
                  min = 1, max = 28, value = 1)
    ),
    mainPanel(
      div(
        textOutput("cycle_phase"),
        textOutput("breakfast"),
        textOutput("breakfast_advice"),
        textOutput("lunch"),
        textOutput("lunch_advice"),
        textOutput("dinner"),
        textOutput("dinner_advice")
      )
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  output$cycle_phase <- renderText({ paste("Cycle Phase: ", data[data$Day == input$day_slider, "Cycle_Phase"]) })
  output$breakfast <- renderText({ paste("Breakfast: ", data[data$Day == input$day_slider, "Breakfast"]) })
  output$breakfast_advice <- renderText({ paste("Breakfast Advice: ", data[data$Day == input$day_slider, "Dietary_Advice_Breakfast"]) })
  output$lunch <- renderText({ paste("Lunch: ", data[data$Day == input$day_slider, "Lunch"]) })
  output$lunch_advice <- renderText({ paste("Lunch Advice: ", data[data$Day == input$day_slider, "Dietary_Advice_Lunch"]) })
  output$dinner <- renderText({ paste("Dinner: ", data[data$Day == input$day_slider, "Dinner"]) })
  output$dinner_advice <- renderText({ paste("Dinner Advice: ", data[data$Day == input$day_slider, "Dietary_Advice_Dinner"]) })
}

# Run the application 
shinyApp(ui = ui, server = server)
