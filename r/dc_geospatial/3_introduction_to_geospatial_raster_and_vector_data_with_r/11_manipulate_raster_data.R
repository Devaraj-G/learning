# Manipulate raster data
# Crop raster data to vector data
# Extract summary of pixels

# Import libraries
library(sf)
library(terra)

# polygon geometry (region)
aoi_boundary_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
# lines geometry (roads)
lines_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
# point geometry (tower)
point_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

# load raster data
dsm_harv <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
dtm_harv <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
# calculate chm
chm_harv <- dsm_harv - dtm_harv
names(chm_harv) <-  "HARV_chmCrop"
chm_harv_df <- as.data.frame(chm_harv, xy = TRUE)

ggplot() +
  geom_raster(data = chm_harv_df, aes(x = x, y = y, fill = HARV_chmCrop)) +
  scale_fill_gradientn(name = 'Canopy Height', colors = terrain.colors(10)) +
  geom_sf(data = aoi_boundary_harv, color = 'blue', fill =NA) +
  coord_sf()

# crop raster to only within the tower
chm_crop_harv <- crop(x = chm_harv, y = aoi_boundary_harv)
chm_crop_harv_df <- as.data.frame(chm_crop_harv, xy = TRUE)

boundary_chm <- st_bbox(chm_harv)
boundary_chm <- st_as_sfc(boundary_chm)

ggplot() +
  geom_sf(data = boundary_chm, fill = 'green', color = 'red', alpha = 0.2) +
  geom_raster(data = chm_crop_harv_df,
              aes(x = x, y = y, fill = HARV_chmCrop)) +
  scale_fill_gradientn(name = 'Canopy Height', colors = terrain.colors(10)) +
  coord_sf()

ggplot() +
  geom_raster(data = chm_crop_harv_df,
              aes(x = x, y = y, fill = HARV_chmCrop)) +
  geom_sf(data = aoi_boundary_harv, color = 'blue', fill = 'NA') +
  scale_fill_gradientn(name = 'Canopy Height', colors = terrain.colors(10)) +
  coord_sf()

# bbox comparison
st_bbox(aoi_boundary_harv)
st_bbox(chm_crop_harv)

# Define an extent
new_extent <- ext(732161.2, 732238.7, 4713249, 4713333)
class(new_extent)

# crop to new extent
chm_crop_harv_custom <- crop(x = chm_harv, y = new_extent)
st_bbox(chm_crop_harv_custom)
chm_crop_harv_custom_df <- as.data.frame(chm_crop_harv_custom, xy = TRUE)

ggplot() +
  geom_sf(data = aoi_boundary_harv, color = 'blue', fill = 'NA') +
  geom_raster(data = chm_crop_harv_custom_df, 
              aes(x = x, y = y, fill = HARV_chmCrop)) +
  scale_fill_gradientn(name = 'Canopy Height', colors = terrain.colors(10)) +
  coord_sf()
  
# Extract raster pixels values using vector polygons
# extract() function needs,
# raster + vector + output data frame

tree_ht <- extract(x = chm_harv, y = aoi_boundary_harv, xy = TRUE, raw = FALSE)
str(tree_ht)

ggplot() +
  geom_histogram(data = tree_ht, aes(x = HARV_chmCrop)) +
  ggtitle("Histogram of CHM Height Values (m)") +
  xlab("Tree Height") +
  ylab("Frequency of Pixels")
  
summary(tree_ht$HARV_chmCrop)
  
summary(chm_crop_harv_df$HARV_chmCrop)

# crop is same as simple extract 
identical(tree_ht, chm_crop_harv_df) # FALSE, as ID field is extra 
identical(tree_ht$HARV_chmCrop, chm_crop_harv_df$HARV_chmCrop) # TRUE
  
# extract with buffer
mean_tree_ht_tower <- extract(x = chm_harv,
                              y = st_buffer(point_harv, dist = 20),
                              fun = mean)
mean_tree_ht_tower