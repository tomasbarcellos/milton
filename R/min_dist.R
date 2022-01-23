#' Distancia entre coordenadas
#'
#' @param x Local de partida
#' @param y Local de chegada
#'
#' @return Distancia entre x e y
#' @export
distancia <- function(x, y) {
  sp::spDists(as.matrix(x), as.matrix(y), TRUE) %>%
    remove_zero()
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

#' Remove distancias a si mesmo das matrizes
#'
#' @param X Matriz
#'
#' @return Matriz sem zeros
remove_zero <- function(X) {
  X[X == 0] <- NA
  X
}
