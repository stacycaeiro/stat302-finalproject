## load libraries 
library(tidyverse)
library(janitor)

## load datasets 
holc_raw <- read_csv("data/raw/HOLC_2020_census_tracts.csv")
health_raw <- read_csv("data/raw/chicago_health_atlas_final.csv")

## create codebook 
#the first three rows of the health data provide a definition, indicator name, and 
#citation. So I am creating a new csv of just the first three rows to use as a codebook. 

health_codebook <- health_raw[0:3,] |>
  clean_names()

write_csv(health_codebook, "data/chicago_health_atlas_codebook_final.csv")

## clean 
health_clean <- health_raw |>
  #filter out first 4 rows because its text defintions
  slice(-c(0:4)) |>
  #convert all numeric values from char to numeric variables
  mutate_at(vars(-Layer, -Name), as.numeric) |>
  #clean names so they can be used in code
  clean_names() |>
  #deselect variables because irrelevant to analysis
  select(-c(layer, name))

holc_clean <- holc_raw |>
  rename(geoid = geoid20, 
         class = class1) |>
  select(geoid, class) |>
  mutate(geoid = as.numeric(geoid))
  
## join 
holc_health_data <- left_join(health_clean, holc_clean, by = "geoid")

## write data to rds file
write_rds(holc_health_data, "data/holc_health_combined_data_final.rds")


