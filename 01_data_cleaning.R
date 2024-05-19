## STAT 302 Final Project - Data Cleaning ##

# load packages 
library(tidyverse)
library(here)
library(stringr)

health_raw <- read_csv(here("data/chicago_health_atlas_may.csv")) |> 
  janitor::clean_names()
  
census_raw <- read_csv(here("data/cook_county_census.csv")) |> 
  janitor::clean_names() 

census_clean <- census_raw |> 
  select(name, dp1_0078p, dp1_0079p, dp1_0080p, dp1_0081p, dp1_0082p, dp1_0083p,
         dp1_0084p) |> 
  rename(census_tract = name,
         pct_white = dp1_0078p, 
         pct_black = dp1_0079p,
         pct_ai_an = dp1_0080p, 
         pct_asian = dp1_0081p,
         pct_nh_pi = dp1_0082p,
         pct_other = dp1_0083p,
         pct_multiracial = dp1_0084p
         ) |> 
  mutate(census_tract = paste("Tract", 
                              str_extract(census_tract,"\\d+\\.\\d*|\\d+")))

census <- census_clean[-c(0:2), ]

health_clean <- health_raw |> 
  select(-c(layer, geoid)) |> 
  rename(census_tract = name,
         rent_burden = rbs_2018_2022,
         chi_eji = chaixyp_2023,
         food_insec = fai_2020,
         low_food = lfa_2019,
         hs_grad = edb_2018_2022,
         col_grad = ede_2018_2022)

# join data 
map_data <- left_join(census, health_clean, by = "census_tract")
 
