##' get_addr
#'
#' Returns the corresponding geocoordinates (latitude, longitude) of a given an address .
#' Uses Open Street Maps JSON API (requires jsonlite). By D.Kisler
#'
#' @param address Character value containing street adress
#' @export
#'

get_addr <- function(address = NULL){
  vazio <- tibble::tibble(lon = numeric(), lat = numeric())

  if(suppressWarnings(is.null(address)))
    return(vazio)

  tryCatch(
    d <- jsonlite::fromJSON(
      gsub('\\@addr\\@', gsub('\\s+', '\\%20', address),
           'http://nominatim.openstreetmap.org/search/@addr@?format=json&addressdetails=0&limit=1')
    ), error = function(c) return(vazio())
  )
  if(length(d) == 0) return(vazio)

  return(tibble::tibble(lon = as.numeric(d$lon), lat = as.numeric(d$lat)))
}
