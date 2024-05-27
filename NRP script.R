library(raster)
library(terra)
library(ggplot2)
library(leaflet)

setwd("C:/Users/s4624690/Documents/Natural regeneration patch R/NRP_DATA/PNR_30m")

#assign all the tif files in that folder to a new name
tif_file_name <- list.files(pattern = "\\.tif$", full.names = TRUE)

#read all the tif files
rasters <- lapply(tif_file_name, rast)

#check if all the file have the same projection
proj_target <- crs(rasters[[1]])
if (!all(sapply(rasters, crs) == proj_target)) {
  stop("Not all raster files have the same projection.")
}

#use sprc to create a spatRasterCollection, This is an object to hold a collection (list) of SpatRasters.
#They can be used to combine several SpatRasters to be used with merge or mosaic
rasters_collection <- sprc(rasters)



#use mosaic to combine all the tif files
tif_mosaic <- mosaic(rasters_collection, fun = "mean")

plot(tif_mosaic)

