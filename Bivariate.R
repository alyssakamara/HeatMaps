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
  dplyr::filter(statefp10 == "06") %>%
  dplyr::filter(countyfp10 == "013") %>%
  dplyr::select(geoid10,gisjoin)

class(census_tracts)


#Vulnerability data
vunerability_data <-read.csv("C:\\Users\\AlyssaKamara\\Desktop\\full_indicators_pctl_domain_scores_climate.csv") %>%
  dplyr::select(gisjoin, state_name,county,tract,pop_2015_2019_ces,fips,state,county_name,extrm_heat_2030_2050,pctl_avg_energy_burden_percent_income,pm2_5_ces)%>%
  gisjoin = as.character(gisjoin)

  colnames(vunerability_data)
  class(vunerability_data)
  
#join datasets
crs_wgs84 <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

vunerability_sp <- right_join(vunerability_data, census_tracts) 
  st_as_sf() %>%
    st_transform(crs_wgs84)

  class(vunerability_sp)

  common_column <- "common_column_name"
  print(common_column %in% colnames(vunerability_data))
  print(common_column %in% colnames(census_tracts))
  
  
#interactive map
  # create a continuous pallette function 
  pal <- colorNumeric(
    palette = "Blues",
    domain = vunerability_sp$trans_dist_meters,
    na.color = "orange")
  
  # leaflet map
  
  leaflet(data = vunerability_sp) %>%
    addTiles() %>%
    setView(lng = -118, lat = 37, zoom = 6) %>%
    addPolygons(color = "#444444", # lines color #add markers when I do it again for air monitors
                weight = 1, # lines thickness
                smoothFactor = 0.5, #lines smoothness
                opacity = 1.0, 
                fillOpacity = 0.7,
                #fillColor = ~colorQuantile("YlOrRd", pop_density)(pop_density),
                #fillColor = ~mypalette(pop_density))
                fillColor = ~pal(trans_dist_meters)) %>%
    addLegend(pal = pal,
              values = ~trans_dist_meters,
              # opacity = 0.9, 
              # title = "Distance", 
              position = "bottomleft")
  
  #do both maps in this script to avoid having to clean data
  # next map: PM 2.5 and monitors
  
  #load monitor maps data
  