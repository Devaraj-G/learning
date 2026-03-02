# Work with multi-band raster

# load libraries
library(terra)
library(ggplot2)
library(dplyr)

# layer/band 1
rgb_b_1_harv <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif", lyr = 1)

rgb_b_1_harv_df <- as.data.frame(rgb_b_1_harv, xy = TRUE)

ggplot() +
  geom_raster(data = rgb_b_1_harv_df, aes(x = x, y = y, alpha = HARV_RGB_Ortho_1)) +
  coord_quickmap()

# find layers
temp <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")
nlyr(temp)

# layer/band 2
rgb_b_2_harv <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif", lyr = 2)

rgb_b_2_harv_df <- as.data.frame(rgb_b_2_harv, xy = TRUE)

ggplot() +
  geom_raster(data = rgb_b_2_harv_df, aes(x = x, y = y, alpha = HARV_RGB_Ortho_2)) +
  coord_quickmap()

# Image raster data values
# RGB (red, green, blue)
# combine to plot full-color or 3-band composite

rgb_stack_harv <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

# get band 2
rgb_stack_harv[[2]]
# rgb_stack_harv[:]

rgb_stack_harv_df <- as.data.frame(rgb_stack_harv, xy = TRUE)
str(rgb_stack_harv_df)

# histogram of values
ggplot() +
  geom_histogram(data = rgb_stack_harv_df, aes(HARV_RGB_Ortho_1))

ggplot() +
  geom_raster(data = rgb_stack_harv_df, aes(x = x, y = y, alpha = HARV_RGB_Ortho_2)) +
  coord_quickmap()

# to create 3-band image use
# plotRGB()

plotRGB(rgb_stack_harv,
  r = 1, g = 2, b = 3
)
plotRGB(rgb_stack_harv,
  r = 1, g = 2, b = 3,
  stretch = "lin"
)
plotRGB(rgb_stack_harv,
  r = 1, g = 2, b = 3,
  stretch = "hist"
)

# spatrasterdataset
rgb_sds_harv <- sds(rgb_stack_harv)
rgb_sds_harv <- sds(list(rgb_stack_harv, rgb_stack_harv))

rgb_sds_harv[[1]]
rgb_sds_harv[[2]]

rgb_sds_harv[[1]][[3]]
