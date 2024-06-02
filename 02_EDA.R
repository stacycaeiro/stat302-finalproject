## STAT 302 Final Project - Exploratory Data Analysis ##

# load packages 
library(tidyverse)
library(here)

# load clean data 
read_rds(here("data/world_data.rds"))

# data overview 
world_data |> 
  skimr::skim_without_charts()

naniar::gg_miss_var(world_data) 


