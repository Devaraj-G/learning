# Convert from .csv to a Vector Layer
# csv >> data frame >> spatial object

# import libraries
library(sf)
library(terra)

# load data
# locations in csv
plot_locations_harv <- read.csv("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HARV_PlotLocations.csv")

str(plot_locations_harv)
class(plot_locations_harv)
# check for some columns similar to x y
names(plot_locations_harv)

head(plot_locations_harv$easting)
head(plot_locations_harv$northing)

# what is the crs?
# columns "geodeticDa" "utmZone"
head(plot_locations_harv$geodeticDa)
unique(plot_locations_harv$geodeticDa)
head(plot_locations_harv$utmZone)
unique(plot_locations_harv$utmZone) # WGS84 UTM 18N

# create proj4 string
# https://spatialreference.org/ref/epsg/32618/
# +proj=utm +zone=18 +datum=WGS84 +units=m +no_defs +type=crs

# Let's use crs from point_harv
utm_18n_crs <- st_crs(point_harv)
utm_18n_crs$proj4string
class(utm_18n_crs) 

# .csv to sf object
# X and Y (easting and northing)
# crs (utm_18n_crs)
# use function st_as_sf()

plot_locations_harv_sp <- st_as_sf(plot_locations_harv,
                                   coords = c('easting', 'northing'),
                                   crs = utm_18n_crs)
st_crs(plot_locations_harv_sp)

# plot
ggplot() +
  geom_sf(data = plot_locations_harv_sp) +
  ggtitle('Map of plot locations')

# plot locations w.r.t the tower
ggplot() +
  geom_sf(data = plot_locations_harv_sp) +
  geom_sf(data = aoi_boundary_harv) +
  ggtitle('AOI Boundary Plot')

# export to a .shp file to share
st_write(plot_locations_harv_sp, 
         '../figures/PlotLocations_HARV.shp', driver = 'ESRI Shapefile')
















