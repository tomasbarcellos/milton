##' get_addr
#'
#' Returns the corresponding geocoordinates (latitude, longitude) of a given an address .
#' Uses Open Street Maps JSON API (requires jsonlite). By D.Kisler
#'
#' @param address Character value containing street adress
#' @export
#'

get_addr <- function(address = NULL){
  if (is.numeric(address)) {
    return(get_addr(cep(address)))
  }

  vazio <- sf::st_sfc(sf::st_point(), crs = 4326)

  if(suppressWarnings(is.null(address))) {
    return(vazio)
  }


  address <- gsub("\\s+", "\\%20", address)
  tryCatch(
    d <- jsonlite::fromJSON(
      glue::glue("http://nominatim.openstreetmap.org/search/",
                 "{address}?format=json&addressdetails=0&limit=1")
    ), error = function(c) return(vazio)
  )

  if(length(d) == 0) return(vazio)

  sf::st_sfc(
    sf::st_point(c(as.numeric(d$lon), as.numeric(d$lat))),
    crs = 4326
  )

}
