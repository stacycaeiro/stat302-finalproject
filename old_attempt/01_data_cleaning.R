## STAT 302 Final Project - Data Cleaning ##

# load packages 
library(tidyverse)
library(here)
library(stringr)

# load data 

world_data <- read_csv(here("data/world-data-2023.csv")) |> 
  janitor::clean_names() |> 
  mutate(
    agricultural_land_percent = str_remove(agricultural_land_percent, "%") 
      |> as.numeric(),
    cpi_change_percent = str_remove(cpi_change_percent, "%") 
      |> as.numeric(),
    forested_area_percent = str_remove(forested_area_percent, "%") 
      |> as.numeric(),
    gross_primary_education_enrollment_percent = str_remove(gross_primary_education_enrollment_percent, "%") 
      |> as.numeric(),
    gross_tertiary_education_enrollment_percent = str_remove(gross_tertiary_education_enrollment_percent, "%") 
      |> as.numeric(),
    out_of_pocket_health_expenditure = str_remove(out_of_pocket_health_expenditure, "%") 
    |> as.numeric(),
    population_labor_force_participation_percent = str_remove(population_labor_force_participation_percent, "%") 
    |> as.numeric(),
    tax_revenue_percent = str_remove(tax_revenue_percent, "%") 
    |> as.numeric(),
    total_tax_rate = str_remove(total_tax_rate, "%") 
    |> as.numeric(),
    unemployment_rate = str_remove(unemployment_rate, "%") 
    |> as.numeric(),
    gdp = str_remove_all(gdp, "[$,]") |> as.numeric(),
    minimum_wage = str_remove_all(minimum_wage, "[$]") |> as.numeric()
  )

world_data |> 
  skimr::skim_without_charts()

naniar::gg_miss_var(world_data) 

write_rds(world_data, file = "data/world_data.rds")
