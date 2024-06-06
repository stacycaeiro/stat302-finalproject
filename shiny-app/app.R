## STAT 302 Final Project
## Shiny App

# load packages ----
library(shiny)
library(tidyverse)
library(bslib)
library(here)

# read data ----
hh_data <-
  read_rds(here("shiny-app/shiny-data/holc_health_combined_data_final.rds")) |>
  mutate(class = factor(
    class,
    levels = c("A", "B", "C", "D", "NA"),
    labels = c(
      "Best",
      "Still Desirable",
      "Definitely Declining",
      "Hazardous",
      "NA"
    )
  ))

caption_data <- read_csv(here("shiny-app/shiny-data/chicago_health_atlas_codebook.csv"))

# Define UI for application that draws a histogram
ui <- page_sidebar(
  # Application title
  title = tags$h1(
    tags$b(
      "Legacy of Neighborhood Redlining Associated with Negative Socioeconomic 
      Outcomes"
    )
  ),
  
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
        "Severe Rent Burden Rate",
        "College Graduation Rate",
        "Poverty Rate",
        "Food Insecurity Rate",
        "Chronic Obstructive Pulmonary Disease Rate"
      ),
      selected = "College Graduation Rate"
    ),
  ),
  
  # two plots
  layout_column_wrap(
    width = 1 / 2,
    height = 300,
    card(full_screen = TRUE,
         plotOutput(outputId = "boxPlot")),
    card(full_screen = TRUE,
         plotOutput(outputId = "scatterPlot"))
  ),
  # explanation of variable & source
  card(full_screen = TRUE,
       textOutput(outputId = "varCaption")) #,
       #textOutput(outputId = "sourceCaption"))

)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$boxPlot <- renderPlot({
    y_variable <- case_when(
      input$y_var == "Severe Rent Burden Rate" ~ "rbs_2017_2021",
      input$y_var == "College Graduation Rate" ~ "ede_2017_2021",
      input$y_var == "Poverty Rate" ~ "pov_2017_2021",
      input$y_var == "Food Insecurity Rate" ~ "fai_2020",
      input$y_var == "Chronic Obstructive Pulmonary Disease Rate" ~ "lng_2021"
    )
    
    data_boxplot <- hh_data |>
      filter(class %in% c(
        "Best",
        "Still Desirable",
        "Definitely Declining",
        "Hazardous"
      ))
    
    ggplot(data = data_boxplot,
           mapping = aes(x = class,
                         y = !!sym(y_variable))) +
      geom_boxplot() +
      theme_minimal() +
      labs(title = NULL,
           x = "Neighborhood Loan Risk Rating",
           y = input$y_var) +
      theme(
        plot.title = element_text(face = "bold", size = 30),
        legend.position = "inside",
        legend.position.inside = c(0.5, 0.75),
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1)
      )
  })
  
  output$scatterPlot <- renderPlot({
    y_variable <- case_when(
      input$y_var == "Severe Rent Burden Rate" ~ "rbs_2017_2021",
      input$y_var == "College Graduation Rate" ~ "ede_2017_2021",
      input$y_var == "Poverty Rate" ~ "pov_2017_2021",
      input$y_var == "Food Insecurity Rate" ~ "fai_2020",
      input$y_var == "Chronic Obstructive Pulmonary Disease Rate" ~ "lng_2021"
    )
    
    ggplot(data = hh_data,
           mapping = aes(x = pct_w_2017_2021,
                         y = !!sym(y_variable))) +
      geom_point() +
      theme_minimal() +
      labs(title = NULL,
           x = "% White Residents in Neighborhood",
           y = input$y_var) +
      theme(
        plot.title = element_text(face = "bold", size = 30),
        legend.position = "inside",
        legend.position.inside = c(0.5, 0.75),
        panel.grid.minor = element_blank()
      )
  })
  
  output$varCaption <- renderText({
    caption_text <- case_when(
      input$y_var == "Severe Rent Burden Rate" ~ caption_data$rbs_2017_2021[2],
      input$y_var == "College Graduation Rate" ~ caption_data$ede_2017_2021[2],
      input$y_var == "Poverty Rate" ~ caption_data$pov_2017_2021[2],
      input$y_var == "Food Insecurity Rate" ~ caption_data$fai_2020[2],
      input$y_var == "Chronic Obstructive Pulmonary Disease Rate" ~ caption_data$lng_2021[2]
    )
    source_text <- case_when(
      input$y_var == "Severe Rent Burden Rate" ~ caption_data$rbs_2017_2021[3],
      input$y_var == "College Graduation Rate" ~ caption_data$ede_2017_2021[3],
      input$y_var == "Poverty Rate" ~ caption_data$pov_2017_2021[3],
      input$y_var == "Food Insecurity Rate" ~ caption_data$fai_2020[3],
      input$y_var == "Chronic Obstructive Pulmonary Disease Rate" ~ caption_data$lng_2021[3]
    )
    
    HTML(paste(input$y_var, 
               ": ", 
               caption_text,
               " [Source: ",
               source_text,
               "]",
               sep = ""))
  })
  
    #output$sourceCaption <- renderText({
     # source_text <- case_when(
     #   input$y_var == "Severe Rent Burden Rate" ~ caption_data$rbs_2017_2021[3],
     #   input$y_var == "College Graduation Rate" ~ caption_data$ede_2017_2021[3],
     #   input$y_var == "Poverty Rate" ~ caption_data$pov_2017_2021[3],
     #   input$y_var == "Food Insecurity Rate" ~ caption_data$fai_2020[3],
     #   input$y_var == "Chronic Obstructive Pulmonary Disease Rate" ~ caption_data$lng_2021[3]
     # )
      
      #HTML(paste("Source: ", 
      #           source_text,
       #          sep = ""))

}


# Run the application
shinyApp(ui = ui, server = server)
