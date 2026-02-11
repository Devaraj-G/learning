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
