## STAT 302 Final Project - Exploratory Data Analysis ##

# load packages 
library(tidyverse)
library(here)
library(ggcorrplot)

# load clean data 
world_data <- read_rds(here("data/world_data.rds"))

# data overview 
world_data |> 
  skimr::skim_without_charts()

naniar::gg_miss_var(world_data) 

world_cor <- world_data |> 
  select(
    maternal_mortality_ratio, infant_mortality, life_expectancy, gdp, 
    minimum_wage, out_of_pocket_health_expenditure, 
    ) |> 
  cor()

ggcorrplot(world_cor)

ggplot(world_data, aes(x = maternal_mortality_ratio, y = minimum_wage)) +
  geom_point() +
  theme_minimal()

world_cor_all <- world_data |> 
  select(where(is.numeric)) |> 
  cor()

ggcorrplot(world_cor_all)
