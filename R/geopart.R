#' geopart
#'
#' Partitions a dataset according to the location area each observation belongs to.
#'
#' @param shape_file A SpatialPolygonsDataFrame object created using sp package
#' @param dataset A data.frame or matrix object containing lon/lat coordinates
#' @export
#'
geopart <- function(dataset, shape_file){
  sf::st_within(dataset, shape_file, sparse = TRUE) %>%
    purrr::map_int(~ifelse(length(.x) == 0, NA_integer_, .x))
}
