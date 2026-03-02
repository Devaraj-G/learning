# Plot multiple vector layers

# Import vector data
library(sf) # simple features
library(terra)

# import data
# polygon geometry (region)
aoi_boundary_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
# lines geometry (roads)
lines_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
# point geometry (tower)
point_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

# plot different data on 1 plot
ggplot() +
  geom_sf(data = aoi_boundary_harv, fill = 'grey', color = 'navy') +
  geom_sf(data = lines_harv, aes(color = TYPE), size = 1) +
  geom_sf(data = point_harv, color = 'red') +
  ggtitle('NEON Harvard Forest Field Site') +
  coord_sf()

# add legend
road_colors <- c('green','grey','black','brown')
ggplot() +
  geom_sf(data = aoi_boundary_harv, fill = 'grey', color = 'navy') +
  geom_sf(data = lines_harv, aes(color = TYPE), show.legend = 'line', size = 1) +
  geom_sf(data = point_harv, aes(fill = Sub_Type), color = 'red') +
  scale_color_manual(values = road_colors) +
  scale_fill_manual(values = 'black') +
  ggtitle('NEON Harvard Forest Field Site') +
  coord_sf()

ggplot() +
  geom_sf(data = aoi_boundary_harv, fill = 'grey', color = 'navy') +
  geom_sf(data = lines_harv, aes(color = TYPE), show.legend = 'line', size = 1) +
  geom_sf(data = point_harv, aes(fill = Sub_Type), color = 'red') +
  scale_color_manual(values = road_colors, name = 'Line Type') +
  scale_fill_manual(values = 'black', name = 'Tower') +
  ggtitle('NEON Harvard Forest Field Site') +
  coord_sf()

ggplot() +
  geom_sf(data = aoi_boundary_harv, fill = 'grey', color = 'navy') +
  geom_sf(data = lines_harv, aes(color = TYPE), show.legend = 'line', size = 1) +
  geom_sf(data = point_harv, aes(fill = Sub_Type), color = 'red') +
  scale_color_manual(values = road_colors) +
  scale_fill_manual(values = 'black') +
  labs(color = 'RoadType') +
  labs(fill = 'Tower1')
  ggtitle('NEON Harvard Forest Field Site') +
  coord_sf()

  ggplot() +
  geom_sf(data = aoi_boundary_harv, fill = 'grey', color = 'navy') +
  geom_sf(data = lines_harv, aes(color = TYPE), show.legend = 'line', size = 1) +
  geom_sf(data = point_harv, aes(fill = Sub_Type), color = 'red', shape = 23) +
  scale_color_manual(values = road_colors) +
  scale_fill_manual(values = 'black') + # only to pick out for legend/labels otherwise can give it in geom_sf itself
  labs(color = 'RoadType') +
  labs(fill = 'Tower1')
  ggtitle('NEON Harvard Forest Field Site') +
  coord_sf()

# plot raster and vector
# load raster data
dsm_harv <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
dtm_harv <- rast("../data/2009586/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
# calculate chm
chm_harv <- dsm_harv - dtm_harv
names(chm_harv) <-  "HARV_chmCrop"
chm_harv_df <- as.data.frame(chm_harv, xy = TRUE)

# plot vector on raster
ggplot() +
  geom_raster(data = chm_harv_df, aes(x = x, y = y, fill = HARV_chmCrop)) +
  geom_sf(data = lines_harv, color = 'black') +
  geom_sf(data = aoi_boundary_harv, color = 'grey20', size = 1) +
  geom_sf(data = point_harv, pch = 8) +
  ggtitle('NEON Harvard Forest Field Site with Caniopy Height') +
  coord_sf()
ggplot() +
  geom_raster(data = chm_harv_df, aes(x = x, y = y, fill = HARV_chmCrop)) +
  scale_fill_gradientn(name = 'Canopy Height', colors = terrain.colors(3)) +
  geom_sf(data = lines_harv, color = 'black') +
  geom_sf(data = aoi_boundary_harv, color = 'grey20', size = 1) +
  geom_sf(data = point_harv, pch = 8) +
  ggtitle('NEON Harvard Forest Field Site with Caniopy Height') +
  coord_sf()
  