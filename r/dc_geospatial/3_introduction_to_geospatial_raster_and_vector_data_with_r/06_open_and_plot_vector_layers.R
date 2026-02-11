# Open and plot vector layers

# Import vector data
library(sf) # simple features
library(terra)

# import vector layers: polygon, line and point

aoi_boundary_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")

st_geometry_type(aoi_boundary_harv) # geometry type
st_crs(aoi_boundary_harv) # crs
st_bbox(aoi_boundary_harv) # bounding box
aoi_boundary_harv

# plot
ggplot() +
  geom_sf(data = aoi_boundary_harv, size = 1, color = "black", fill = "cyan1") +
  ggtitle("AOI boundary Plot") +
  coord_sf() # or use datum=NULL for preserving
