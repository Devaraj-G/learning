# Handling spatial projection & CRS

# import libraries
library(sf)
library(terra)

# load data
# polygon geometry (region)
aoi_boundary_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
# lines geometry (roads)
lines_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
# point geometry (tower)
point_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

state_boundary_us <- st_read('../data/2009586/NEON-DS-Site-Layout-Files/US-Boundary-Layers/US-State-Boundaries-Census-2014.shp')
state_boundary_us <- st_zm(state_boundary_us)

ggplot() +
  geom_sf(data = state_boundary_us) +
  ggtitle('Map of Contiguous US State Boundaries') +
  coord_sf()

us_outline <- st_read('../data/2009586/NEON-DS-Site-Layout-Files/US-Boundary-Layers/US-Boundary-Dissolved-States.shp')
us_outline <- st_zm(us_outline)

ggplot() +
  geom_sf(data = state_boundary_us, color = 'gray60') +
  geom_sf(data = us_outline, color = 'black', alpha = 0.25, size = 2) +
  ggtitle('Map of US State Boundaries') +
  coord_sf()

# order changed
ggplot() +
  geom_sf(data = us_outline, color = 'black', size = 2) +
  geom_sf(data = state_boundary_us, color = 'gray60') +
  ggtitle('Map of US State Boundaries') +
  coord_sf()

# CRS
st_crs(point_harv)
st_crs(point_harv)$proj4string
st_crs(us_outline)$proj4string
st_crs(state_boundary_us)$proj4string

st_bbox(point_harv)
st_bbox(state_boundary_us)

# no need to convert, unless crs is unknown
ggplot() +
  geom_sf(data = state_boundary_us, color = 'gray60') +
  geom_sf(data = us_outline, color = 'black', alpha = 0.25, size = 2) +
  geom_sf(data = point_harv, shape = 19, color = 'purple') +
  ggtitle('Map of US State Boundaries') +
  coord_sf()


