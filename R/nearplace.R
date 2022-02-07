##' nearplace
#' @rdname nearplace
#' @export
#'
which_nearplace <- function(coords, targets){
  dists <- distancia(coords, targets)

  apply(dists, 1, which.min) %>%
    purrr::map_dbl(~ifelse(length(.x) == 0, NA_real_, .x))
}

##' nearplace
#'
#' Returns the nearest pleace given a set of targets and a dataframe with coordinates.
#' Uses sp spDistsN1 with Great Circle distance as default.
#'
#' @param coords A nx2 matrix or data frame containing geocoordinates for n subjects.
#' @param targets A mx2 matrix containing a set of geocoordinates for m target locations.
#' @export
#'
nearplace <- function(coords, targets){
  targets[which_nearplace(coords, targets)]
}
