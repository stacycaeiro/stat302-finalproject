#Load libraries 
library(tidyverse)
library(skimr)

#Load data 
health_data_2 <- read_csv("data/chicago_health_atlas_data_census_tract.csv")
hmda_data <- read_csv("data/hmda_2017_il.csv")
cdi_data <- read_csv("data/us_cdi.csv")

#ones I'm using
holc_data <- read_csv("data/HOLC_2020_census_tracts.csv")
health_data <- read_csv("data/chicago_health_atlas_data_2.csv")

#summary stats
holc_summary <- holc_data |>
  skim_without_charts()

holc_summary

health_summary <- health_data |>
  skim_without_charts()

health_summary

#plots 
ggplot(holc_data, aes(x = class1)) +
  geom_bar() +
  labs(title = "Count of Census Tracts Per Neighborhood Redlining Index Class",
       x = "Class",
       y = "Count")

ggsave("data/class_bar.png")

health_smaller <- health_data |>
  mutate(SVI_2020 = as.numeric(SVI_2020),
         EKW_2022 = as.numeric(EKW_2022)) |>
  slice_head(n = 15)

ggplot(health_smaller, aes(x = SVI_2020, y = EKW_2022, color = GEOID)) +
  geom_point() +
  labs(title = "Relationship Between Social Vulnerability Index and Walkability Index",
       x = "Social Vulnerability Index",
       y = "Walkability Index")

ggsave("data/indexes_point.png")
  
