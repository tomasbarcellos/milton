#' Distancia entre coordenadas
#'
#' @param x Local de partida
#' @param y Local de chegada
#'
#' @return Distancia entre x e y
#' @export
distancia <- function(x, y) {
  sf::st_distance(x, y) %>%
    units::set_units(km) %>%
    units::drop_units()
}

##' min_dist
#'
#' Returns the minimum distance to a set of targets given a dataframe with coordinates.
#' Uses sp spDistsN1 with Great Circle distance as default
#'
#' @param coords A nx2 matrix or data frame containing geocoordinates for n subjects.
#' @param targets A mx2 matrix containing a set of geocoordinates for m target locations.
#'
#' @export
min_dist <- function(coords, targets){
  distancia(coords, targets) %>%
    apply(1, min, na.rm = TRUE)
}

