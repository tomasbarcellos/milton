#' geopart
#'
#' Partitions a dataset according to the location area each observation belongs to.
#'
#' @param shape_file A SpatialPolygonsDataFrame object created using sp package
#' @param dataset A data.frame or matrix object containing lon/lat coordinates
#' @export
#'
geopart <- function(dataset, shape_file){
  d <- lapply(seq_len(nrow(dataset)), function (i) sf::st_point(as.matrix(dataset[i, ])))

  idx <- lapply(d, sf::st_within, y = shape_file$geometry) %>%
    unlist()
  shape_file[idx, ]
}
