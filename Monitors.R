install.packages("ggplot2")
install.packages("sf")
install.packages("dplyr")

library(ggplot2)
library(sf)
library(dplyr)

# Upload/read the monitor characteristics data
monitor_data <- read.csv("C:\\Users\\AlyssaKamara\\Desktop\\monitor_characterstics.csv")

# Upload/read the vulnerability data
vulnerability_data <- read.csv("C:\\Users\\AlyssaKamara\\Desktop\\full_indicators_pctl_domain_scores_climate.csv")

# Select the relevant columns from the vulnerability data
vulnerability_data_subset <- vulnerability_data %>%
  select("gisjoin", "extrm_heat_2030_2050")
merged_data <- merge(monitor_data, vulnerability_data_subset, by.x = "gisjoin")

# Read the shapefile for Contra Costa County (replace "path/to/your/shapefile.shp" with the actual file path)
contra_costa_county <- st_read("path/to/your/shapefile.shp")

# Create the base map
base_map <- ggplot() +
  geom_sf(data = contra_costa_county) +
  theme_minimal()

# Add the monitor locations to the base map
base_map <- base_map +
  geom_point(data = merged_data, aes(x = LONGITUDE, y = LATITUDE), color = "blue", size = 3)

# Add the vulnerability data as a layer using fill color
base_map <- base_map +
  geom_sf(data = merged_data, aes(fill = extrm_heat_2030_2050), color = NA) +
  scale_fill_viridis_c(name = "Extreme Heat Days (2030-2050)")

# Customize the plot labels, titles, and color scales as needed

# Display the map
print(base_map)
