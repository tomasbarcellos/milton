##' nearplace
#'
#' Returns the nearest pleace given a set of targets and a dataframe with coordinates.
#' Uses sp spDistsN1 with Great Circle distance as default.
#'
#' @param coords A nx2 matrix or data frame containing geocoordinates for n subjects.
#' @param points A mx2 matrix containing a set of geocoordinates for m target locations.
#' @export
#'

nearplace <- function(coords, targets, coord_names = c("lon","lat"),
                      great_circ = TRUE, target_label="names"){

  coord_list <- split(coords, seq(nrow(coords)))

  f_targets <- targets[,colnames(targets) %in% coord_names] %>% as.matrix()
  # f: Finds minimum distance to targets

  nearestplace <- purrr::map(.f = function(x) sp::spDistsN1(pt=x %>% unlist(), # Dist: coord vs. targets
                                                   pts = f_targets,
                                                   longlat = great_circ) %>%
                               which.min() %>% # min value
                             targets[.,target_label], # Corresponding label
                        .x=coord_list) %>% unlist()  # subjects
  return(nearestplace)
}
