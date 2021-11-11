library(tidyverse)
library(echarts4r)
library(echarts4r.assets)

sf_podf_ports <- 
  rnaturalearth::ne_download(
    category = "cultural", type = "ports", scale = "large", returnclass = "sf"
  ) %>% 
  mutate(long = sf::st_coordinates(.)[,1], lat = sf::st_coordinates(.)[,2]) %>% 
  sf::st_drop_geometry()

globe <- 
  df_ports %>% 
  e_charts(long) %>% 
  e_globe(
    environment = ea_asset("starfield"),
    base_texture = ea_asset("world_topo"),
    height_texture = ea_asset("world topo"),
    displacementScale = .016, 
    globeOuterRadius = 101
  ) %>% 
  e_scatter_3d(
    lat, scalerank, bind = name, 
    coord_system = "globe", 
    blendMode = "lighter", 
    size = 2.5,
    geo.label = list(show = FALSE)
  ) %>% 
  e_color(color = "#28A87D") %>% 
  e_tooltip(formatter = htmlwidgets::JS("
      function(params){
        return(params.name)
      }
    "))

htmlwidgets::saveWidget(globe, file = "globe.html")
