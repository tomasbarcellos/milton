#' CEP
#'
#' @param x CEP buscado
#'
#' @return Endereco do CEP como texto
#'
#' @importFrom magrittr %>%
#' @export
#'
cep <- function(x) {
  if (length(x) > 1) {
    return(purrr::map_chr(x, cep))
  }

  texto <- httr::POST("https://www.achecep.com.br/",
                     body = list(q = x),
                     encode = "form") %>%
    httr::content() %>%
    rvest::html_node(".verbeteEndereco") %>%
    rvest::html_children() %>%
    rvest::html_text()

  if (length(texto) == 0) return(NA)

  texto[[1]]
}
