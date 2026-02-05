# Plot raster data

# load libraries
library(terra)
library(ggplot2)
library(dplyr)

dsm_harv <- rast('./data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif')

dsm_harv_df <- as.data.frame(dsm_harv,xy = TRUE)

dsm_harv_df <- dsm_harv_df %>%
  mutate(fct_elevation = cut(HARV_dsmCrop, breaks = 3))

ggplot() +
  geom_bar(data = dsm_harv_df, aes(fct_elevation))
# is not same as 
ggplot() +
  geom_histogram(data = dsm_harv_df, aes(HARV_dsmCrop), bins = 3)

custom_bins <- c(300,350,400,450)
dsm_harv_df <- dsm_harv_df %>%
  mutate(fct_elevation2 = cut(HARV_dsmCrop, breaks = custom_bins))

ggplot() +
  geom_bar(data = dsm_harv_df, aes(fct_elevation2))

ggplot() +
  geom_raster(data = dsm_harv_df, aes(x=x, y=y, fill = fct_elevation2)) +
  coord_quickmap()

# choose colours
terrain.colors(3)

ggplot() +
  geom_raster(data = dsm_harv_df, aes(x=x, y=y, fill = fct_elevation2)) +
  scale_fill_manual(values = terrain.colors(3), na.value = "grey50") +
  coord_quickmap()
# what color names in R available?

ggplot() +
  geom_raster(data = dsm_harv_df, aes(x=x, y=y, fill = fct_elevation2)) +
  scale_fill_manual(values = terrain.colors(3), na.value = "grey50", name = 'elevation') +
  #theme(axis.title = element_blank()) +
  ggtitle('classified elevation map') +
  xlab('utm easting coordinate (m)') +
  ylab('utm northing coordinate (m)') +
  coord_quickmap()

# Layering rasters
dsm_hill_harv <- rast('./data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif')

