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

  if(suppressWarnings(is.null(address))) {
    return(sf::st_point())
  }


  address <- gsub("\\s+", "\\%20", address)
  tryCatch(
    d <- jsonlite::fromJSON(
      glue::glue("http://nominatim.openstreetmap.org/search/",
                 "{address}?format=json&addressdetails=0&limit=1")
    ), error = function(c) return(sf::st_point())
  )

  if(length(d) == 0) return(sf::st_point())

  sf::st_point(c(as.numeric(d$lon), as.numeric(d$lat)))
}
