# Explore and plot by vector layer attributes

# Import vector data
library(sf) # simple features
# library(terra)

# import data
# polygon geometry (region)
aoi_boundary_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
# lines geometry (roads)
lines_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
# point geometry (tower)
point_harv <- st_read("../data/2009586/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

class(lines_harv)
class(point_harv)

# how many attributes
ncol(point_harv)
names(point_harv)
head(point_harv)
point_harv$Ownership
point_harv["Ownership"]
point_harv[12]

ncol(lines_harv)
names(lines_harv)
head(lines_harv)

ncol(aoi_boundary_harv)
names(aoi_boundary_harv)

# explore values within a specific attribute
names(lines_harv)
lines_harv$TYPE
lines_harv["TYPE"]
lines_harv[3]

unique(lines_harv$TYPE)

## use dplyr pipe to filter rows with footpath
footpath_harv <- lines_harv %>%
  filter(TYPE == 'footpath')
nrow(footpath_harv)

# plot the footpaths
ggplot() +
  geom_sf(data = footpath_harv) +
  ggtitle('NEON Harvard Forest Field Site', subtitle = 'Footpaths') +
  coord_sf()

## use dplyr pipe to filter rows with stonewall
stonewall_harv <- lines_harv %>%
  filter(TYPE == 'stone wall')
# number of footpaths or features/number of rows
nrow(stonewall_harv)

# plot the stone walls
ggplot() +
  geom_sf(data = stonewall_harv) +
  ggtitle('NEON Harvard Forest Field Site', subtitle = 'Stone walls') +
  coord_sf()

# plot the footpaths + stone walls
ggplot() +
  geom_sf(data = stonewall_harv) +
  geom_sf(data = footpath_harv) +
  ggtitle('NEON Harvard Forest Field Site', subtitle = 'Footpaths + Stone walls') +
  coord_sf()

# plot different footpaths/rows using different colours (automatic)
# factor() makes the colours discrete
ggplot() +
  geom_sf(data = footpath_harv, aes(color = factor(OBJECTID)), linewidth = 1.5) +
  labs(color = 'Footpath ID')
  ggtitle('NEON Harvarad Forest Field Site', subtitle = 'Footpaths by colour') +
  coord_sf()

# no use of factor() makes the colours continuous
ggplot() +
  geom_sf(data = footpath_harv, aes(color = OBJECTID), linewidth = 1.5) +
  labs(color = 'Footpath ID')
  ggtitle('NEON Harvarad Forest Field Site', subtitle = 'Footpaths by colour') +
  coord_sf()

# plot the footpaths + stone walls
ggplot() +
  geom_sf(data = stonewall_harv, aes(color = factor(OBJECTID)), linewidth = 1.5) +
  geom_sf(data = footpath_harv, aes(color = factor(OBJECTID)), linewidth = 1.5) + 
  labs(color = 'Footpath ID')
  ggtitle('NEON Harvard Forest Field Site', subtitle = 'Footpaths + Stone walls by colour') +
  coord_sf()
 
# customize plots
unique(lines_harv$TYPE)
road_colors <- c('green','grey','black','brown')

ggplot() +
  geom_sf(data = lines_harv, aes(color = factor(TYPE))) +
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails") +
  coord_sf()
  
ggplot() +
  geom_sf(data = lines_harv, aes(color = TYPE)) +
  scale_color_manual(values = road_colors) + 
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails") +
  coord_sf()

ggplot() +
  geom_sf(data = lines_harv, aes(color = factor(OBJECTID))) + 
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails") +
  coord_sf()

# adjust line widths
line_widths <- c(1,2,3,4)
ggplot() +
  geom_sf(data = lines_harv, aes(color = TYPE, linewidth = TYPE)) +
  scale_color_manual(values = road_colors) +
  scale_linewidth_manual(values = line_widths) +
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails - line width varies") +
  coord_sf()

ggplot() +
  geom_sf(data = lines_harv, aes(color = factor(OBJECTID), linewidth = TYPE)) +
  #scale_color_manual(values = road_colors) +
  scale_linewidth_manual(values = line_widths) +
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails - line width varies") +
  coord_sf()

ggplot() +
  geom_sf(data = lines_harv, aes(color = factor(OBJECTID), linewidth = 1)) +
  #scale_color_manual(values = road_colors) +
  #scale_linewidth_manual(values = line_widths) +
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails - line width varies") +
  coord_sf()

# to get legend showing both color and linewidths
ggplot() +
  geom_sf(data = lines_harv, aes(color = TYPE, linewidth = TYPE)) +
  scale_color_manual(name= 'Road Type', values = road_colors) +
  labs(color = 'Road Type') +
  scale_linewidth_manual(name = 'Road Type', values = line_widths) +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads & Trails - Line width varies") +
  coord_sf()

# change the appearance of the legend
ggplot() +
  geom_sf(data = lines_harv, aes(color = TYPE, linewidth = TYPE)) +
  scale_color_manual(name= 'Road Type', values = road_colors) +
  labs(color = 'Road Type') +
  scale_linewidth_manual(name = 'Road Type', values = line_widths) +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads & Trails - Line width varies") +
  theme(legend.text = element_text(size = 20), legend.box.background = element_rect(linewidth = 1))
  coord_sf()
  
# Challenge: bike horse
# exploring the entries of the column BicyclesHo
lines_harv %>%
  pull(BicyclesHo) %>%
  unique()
  
roads_bike_horse <- lines_harv %>%
  filter(BicyclesHo == 'Bicycles and Horses Allowed')
nrow(roads_bike_horse)

ggplot() +
  geom_sf(data = lines_harv) + 
  geom_sf(data = roads_bike_horse, aes(color = BicyclesHo), linewidth = 2) +
  scale_color_manual(values = "magenta") +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads Where Bikes and Horses Are Allowed") +
  coord_sf()

# inter-relate aes and data colors
ggplot() +
  geom_sf(data = lines_harv, color = 'red') + 
  geom_sf(data = roads_bike_horse, aes(color = BicyclesHo), linewidth = 2) +
  scale_color_manual(values = "magenta") +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads Where Bikes and Horses Are Allowed") +
  coord_sf()  

# Challenge for US boundary














