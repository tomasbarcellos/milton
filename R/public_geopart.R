#' geopart
#' 
#' Partitions a dataset according to the location area each observation belongs to.
#' 
#' @param shape_file A SpatialPolygonsDataFrame object created using sp package
#' @param dataset A data.frame or matrix object containing lon/lat coordinates
#' @param coord_names List of characters contaning variable names for lon/lat collumns. Defaults to c("lon","lat")
#' @export
#' 

geopart <- function(shape_file, dataset,
                    coord_names=c("lon","lat"),
                    proj_specs="+proj=longlat +zone=23 +south +ellps=aust_SA +units=m +no_defs"){
  require(mapsapi)
  require(rgdal)

  sample_coords <- dataset[,coord_names]
  dataset[,coord_names] <- list(NULL) 
  
  setor_sens_init <- spTransform(shape_file,
                                 CRS(proj_specs))
  
  sample_coords_spdf <- SpatialPointsDataFrame(coords = sample_coords,
                                               data=dataset,
                                               proj4string = CRS(proj_specs))

  sample_over <- over(sample_coords_spdf,setor_sens_init)
  return(cbind(dataset,sample_coords,sample_over))
  }