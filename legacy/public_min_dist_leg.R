#' min_dist
#'
#' @param coords A nx2 matrix containing geocoordinates for n subjects.
#' @param points A mx2 matrix containing a set of geocoordinates for m target locations.
#' @export
#' 

min_dist_i <- function(coords,points){
  d = 0
  distmin = rep(Inf,nrow(coords))
  
  for(i in 1:nrow(coords)){
    for(j in 1:nrow(points)) {
      d <- spDistsN1(pts=as.matrix(coords[i,]),
                     pt=points[j,],longlat = T)
      if(d < distmin[i]) distmin[i] <- d}}
  return(distmin)
  }