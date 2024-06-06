## STAT 302 Final Project 
## EDA 

# load libraries ----
library(tidyverse)
library(here)

## load data 
hh_data <- read_rds("data/holc_health_combined_data_final.rds")

ggplot(hh_data, aes(x = class, y = lng_2021)) +
  geom_boxplot()

ggplot(hh_data, aes(x = pct_w_2017_2021, y = lng_2021)) +
  geom_point()

#uns 
# median income 
# poverty rate
# food insecurity
#lng 

