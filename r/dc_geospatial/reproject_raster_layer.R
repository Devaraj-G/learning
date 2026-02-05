# Reproject raster layer

# load libraries
library(terra)
library(ggplot2)
library(dplyr)

# load data
dsm_harv <- rast('./data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif')

dsm_hill_harv <- rast('./data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_DTMhill_WGS84.tif')

# for using ggplot, convert to data frame
dtm_harv_df <- as.data.frame(dsm_harv, xy = TRUE)
dtm_hill_harv_df <- as.data.frame(dsm_hill_harv, xy = TRUE)

# plot both raster layers on one plot
ggplot() +
  geom_raster(data = dtm_harv_df, aes(x = x, y = y, fill = HARV_dtmCrop)) +
  geom_raster(data = dtm_hill_harv_df, aes(x = x, y = y, alpha = HARV_DTMhill_WGS84)) +
  scale_fill_gradientn(name = 'Elevation', colors = terrain.colors(10)) +
  coord_quickmap()

ggplot() +
  geom_raster(data = dtm_harv_df, aes(x = x, y = y, fill = HARV_dtmCrop)) +
  scale_fill_gradientn(name = 'Elevation', colors = terrain.colors(10)) +
  coord_quickmap()

ggplot() +
  geom_raster(data = dtm_hill_harv_df, aes(x = x, y = y, alpha = HARV_DTMhill_WGS84)) +
  coord_quickmap()

crs(dsm_harv, parse = TRUE)
crs(dsm_hill_harv, parse = TRUE)

# project one raster to another crs
dtm_hill_utm_harv <- project(dsm_hill_harv, crs(dsm_harv))
crs(dtm_hill_utm_harv, parse = TRUE)

# check extent and resolution
ext(dsm_hill_harv)
ext(dtm_hill_utm_harv)
ext(dsm_harv)

res(dsm_hill_harv)
res(dtm_hill_utm_harv)
res(dsm_harv)

# to make the resolutions also same along with the crs
dtm_hill_utm_harv <- project(dsm_hill_harv, crs(dsm_harv), res = res(dsm_harv))
ext(dtm_hill_utm_harv)
res(dtm_hill_utm_harv)

# convert to data frame use use with ggplot
dtm_hill_utm_harv_df <- as.data.frame(dtm_hill_utm_harv, xy = TRUE)

ggplot() +
  geom_raster(data = dtm_harv_df, aes(x = x, y = y, fill = HARV_dtmCrop)) +
  geom_raster(data = dtm_hill_utm_harv_df, aes(x = x, y = y, alpha = HARV_DTMhill_WGS84)) +
  scale_fill_gradientn(name = 'Elevation', colors = terrain.colors(10)) +
  coord_quickmap()







