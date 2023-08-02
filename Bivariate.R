#Download/use needed packages
"C:\Users\AlyssaKamara\Documents\GitHub\HeatMaps\Bivariate.R"
install.packages("ggplot2")
install.packages("sf")
install.packages("dplyr") 
install.packages("stringr")
install.packages("janitor")
library(ggplot2)
library(sf)
library(dplyr)
library(stringr)
library(janitor)

#Census tract
census_tracts <- st_read("C:\\Users\\AlyssaKamara\\Desktop\\nhgis0004_shape\\nhgis0004_shape\\nhgis0004_shapefile_tl2010_us_tract_2010\\US_tract_2010.shp") %>%
  clean_names() %>%
  dplyr::filter(statefp10 == 06) %>%
  dplyr::filter(countyfp10 == 013) %>%
  dplyr::select(geoid10,gisjoin)
colnames(census_tracts)

#Vulnerability data
vunerability_data <-read.csv("C:\\Users\\AlyssaKamara\\Desktop\\full_indicators_pctl_domain_scores_climate.csv")
  mutate(gisjoin = str_pad(gisjoin, 12, side = "left", pad = "0"))
  