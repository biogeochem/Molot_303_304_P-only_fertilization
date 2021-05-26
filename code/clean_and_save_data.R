# Title: clean_and_save_data.R
# Author: Jason Venkiteswaran
# Last updated: 2021-05-04
# 
# Description: This scripts cleans the chem data for Lakes 303 and 304 the 
# Molot et al. paper "Phosphorus-only fertilization rapidly initiates large 
# nitrogen-fixing cyanobacteria blooms in two oligotrophic lakes".
#
#


# Load libraries ----------------------------------------------------------

library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)


# Load chem data ----------------------------------------------------------

# A:N columns, 1:307 rows
dat_303 <- read_xls("data/raw_data/L303_304_chemdata 2017-2019.xls", 
                    sheet = "303_2017to2020",
                    range = "A1:N307") %>% 
  clean_names() %>% 
  mutate(date_collected = force_tz(date_collected, "Etc/GMT-6"),
         param_analysis_date = parse_datetime(param_analysis_date, 
                                              format = "%m/%d/%Y %H:%M", 
                                              locale = locale(tz = "Etc/GMT-6")))

# A:N columns, 1:815 rows
dat_304 <- read_xls("data/raw_data/L303_304_chemdata 2017-2019.xls", 
                    sheet = "304_2017to2020",
                    range = "A1:N815") %>% 
  clean_names() %>% 
  mutate(date_collected = force_tz(date_collected, "Etc/GMT-6"),
         param_analysis_date = parse_datetime(param_analysis_date, 
                                              format = "%m/%d/%Y %H:%M", 
                                              locale = locale(tz = "Etc/GMT-6")))

# A:I columns, 20:344 rows
dat_RBR <- read_xlsx("data/raw_data/RBR profiles L303 304 2018 2019.xlsx",
                     sheet = "alldata",
                     range = "A20:I344") %>% 
  clean_names() %>% 
  mutate(time_stamp = force_tz(time_stamp, "Etc/GMT-6"),
         o2_dis_rbr = as.numeric(o2_dis_rbr))


# Save chem data ----------------------------------------------------------

write_csv(dat_303, "data/clean_data/Lake_303_chemistry_2017-2020.csv")

write_csv(dat_304, "data/clean_data/Lake_304_chemistry_2017-2020.csv")

write_csv(dat_RBR, "data/clean_data/Lake_303_304_RBR_2018-2019.csv")
