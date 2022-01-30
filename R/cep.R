#' CEP
#'
#' @param x CEP buscado
#'
#' @return Endereco do CEP como texto
#'
#' @importFrom magrittr %>%
#'
cep <- function(x) {
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
