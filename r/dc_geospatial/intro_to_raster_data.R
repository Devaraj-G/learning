# introduction to raster data
# install libraries by install.packages('terra') etc.
# load libraries
library(terra)
library(ggplot2)
library(dplyr)

# metadata
describe('data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif')
harv_metadata <- capture.output(describe('./data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif'))

# some stats
dsm_harv <- rast('./data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif')
summary(dsm_harv)
summary(values(dsm_harv))

# plot
dsm_harv_df <- as.data.frame(dsm_harv,xy = TRUE)
str(dsm_harv_df)

ggplot() + 
  geom_raster(data = dsm_harv_df, aes(x=x,y=y,fill = HARV_dsmCrop)) +
  scale_fill_viridis_c() +
  coord_quickmap()

crs(dsm_harv, proj = TRUE)
minmax(dsm_harv)
min(dsm_harv)

# multi-band raster
nlyr(dsm_harv)

ggplot() + 
  geom_raster(data = dsm_harv_df, aes(x=x,y=y,fill = HARV_dsmCrop)) +
  scale_fill_viridis_c(na.value = 'deeppink') +
  coord_quickmap()

describe(sources(dsm_harv))

# plot histogram
ggplot() +
  geom_histogram(data = dsm_harv_df, aes(HARV_dsmCrop))
ggplot() +
  geom_histogram(data = dsm_harv_df, aes(HARV_dsmCrop), bins = 40)
