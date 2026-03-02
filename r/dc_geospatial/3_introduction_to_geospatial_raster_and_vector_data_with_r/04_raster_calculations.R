# raster calculations

# load libraries
library(terra)
library(ggplot2)
library(dplyr)

# load data
dsm_harv <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
dtm_harv <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")

dsm_sjer <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmCrop.tif")
dtm_sjer <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/SJER/DTM/SJER_dtmCrop.tif")

# convert to data frame for use with ggplot
dsm_harv_df <- as.data.frame(dsm_harv, xy = TRUE)
dtm_harv_df <- as.data.frame(dtm_harv, xy = TRUE)

dsm_sjer_df <- as.data.frame(dsm_sjer, xy = TRUE)
dtm_sjer_df <- as.data.frame(dtm_sjer, xy = TRUE)

# We plan to calculate chm = dsm - dtf
# using raster maths + lapp()

# compare crs
describe(dsm_harv) # WGS 84 / UTM zone 18N
describe(dtm_harv) # WGS 84 / UTM zone 18N
describe(dsm_sjer) # WGS 84 / UTM zone 11N
describe(dtm_sjer) # WGS 84 / UTM zone 11N

# plot to see the data
ggplot() +
  geom_raster(data = dsm_harv_df, aes(x = x, y = y, fill = HARV_dsmCrop)) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_quickmap()
ggplot() +
  geom_raster(data = dtm_harv_df, aes(x = x, y = y, fill = HARV_dtmCrop)) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_quickmap()
ggplot() +
  geom_raster(data = dsm_sjer_df, aes(x = x, y = y, fill = SJER_dsmCrop)) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_quickmap()
ggplot() +
  geom_raster(data = dtm_sjer_df, aes(x = x, y = y, fill = SJER_dtmCrop)) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_quickmap()

# Method 1: raster calculation using raster maths
# chm = dsm - dtm

chm_harv <- dsm_harv - dtm_harv
chm_harv_df <- as.data.frame(chm_harv, xy = TRUE)

ggplot() +
  geom_raster(data = chm_harv_df, aes(x = x, y = y, fill = HARV_dsmCrop)) +
  scale_fill_gradientn(name = "canopy height", colors = terrain.colors(10)) +
  coord_quickmap()

summary(chm_harv_df)
minmax(chm_harv)

# see distribution of heights
ggplot() +
  geom_histogram(data = chm_harv_df, aes(HARV_dsmCrop))

# Efficient raster calculation using R lapp()
# outputRaster <- lapp(inputRaster, funToApply)

chm_ov_harv <- lapp(
  sds(dsm_harv, dtm_harv),
  fun = function(r1, r2) {
    return(r1 - r2)
  }
)

chm_ov_harv_df <- as.data.frame(chm_ov_harv, xy = TRUE)

ggplot() +
  geom_raster(data = chm_ov_harv_df, aes(x = x, y = y, fill = HARV_dsmCrop)) +
  scale_fill_gradientn(name = "canopy height", colors = terrain.colors(10)) +
  coord_quickmap()


temp <- chm_ov_harv - chm_harv

# write raster into a GeoTIFF file
writeRaster(chm_ov_harv, "../figures/chm_harv.tiff",
  filetype = "GTiff",
  overwrite = TRUE,
  NAflag = -9999
)
