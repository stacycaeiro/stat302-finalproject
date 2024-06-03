## STAT 302 Final Project 
## Shiny App

# load packages ----
library(shiny)
library(tidyverse)
library(bslib)
library(here)

# read data ----
hh_data <- read_rds(here("shiny-app/shiny-data/holc_health_combined_data_final.rds"))

# Define UI for application that draws a histogram
ui <- page_sidebar(
  # Application title
  title = tags$h1(tags$b("Legacy of Neighborhood Redlining Associated with Negative
                         Socioeconomic Outcomes")),
  
  # Sidebar with a slider input for number of bins
  sidebar = sidebar(
    # move to right
    position = "right",
    width = "3in",
    
    # select fill var
    radioButtons(
      inputId = "y_var",
      label = "Select Socioeconomic Indicator:",
      choices = c(
        "% Severe Rent Burden",
        "Chicago Environmental Justice Index",
        "College Graduation Rate"
      ),
      selected = "College Graduation Rate"
    ),
  ),
  
  # two plots
  layout_column_wrap(
    width = 1/2,
    height = 300,
    card(
      full_screen = TRUE,
      plotOutput(outputId = "boxPlot")
    ),
    card(
      full_screen = TRUE,
      plotOutput(outputId = "scatterPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$boxPlot <- renderPlot({
    y_variable <- case_when(
      input$y_var == "% Severe Rent Burden" ~ "rbs_2017_2021",
      input$y_var == "Chicago Environmental Justice Index" ~ "chaixyp_2023",
      input$y_var == "College Graduation Rate" ~ "ede_2017_2021"
    )

    # draw boxplot
    ggplot(data = hh_data,
           mapping = aes(x = class,
                         y = !!sym(y_variable))) +
      geom_boxplot() +
      theme_minimal() +
      labs(
        title = NULL,
        x = "Class",
        y = input$y_var
      ) +
      theme(
        plot.title = element_text(face = "bold", size = 30),
        legend.position = "inside",
        legend.position.inside = c(0.5, 0.75),
        plot.background = element_rect(fill = "lightgray"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(color = "darkgray")
      )
  })
  
  output$scatterPlot <- renderPlot({
    y_variable <- case_when(
      input$y_var == "% Severe Rent Burden" ~ "rbs_2017_2021",
      input$y_var == "Chicago Environmental Justice Index" ~ "chaixyp_2023",
      input$y_var == "College Graduation Rate" ~ "ede_2017_2021"
    )
    
    # draw boxplot
    ggplot(data = hh_data,
           mapping = aes(x = pct_w_2017_2021,
                         y = !!sym(y_variable))) +
      geom_point() +
      theme_minimal() +
      labs(
        title = NULL,
        x = "Non-Hispanic White Residents (%)",
        y = input$y_var
      ) +
      theme(
        plot.title = element_text(face = "bold", size = 30),
        legend.position = "inside",
        legend.position.inside = c(0.5, 0.75),
        plot.background = element_rect(fill = "lightgray"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(color = "darkgray")
      )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
