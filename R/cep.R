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

  logradouro <- texto[[1]]
  cidade <- texto[[4]]

  paste(logradouro, cidade, sep = ", ")
}

#' Verifica CEP
#'
#' @param x Valor para testar (texto ou numero)
#'
#' @return TRUE/FALSE
is_cep <- function(x) {
  x %>%
    stringr::str_remove_all("[[:punct:]]") %>%
    stringr::str_pad(8, pad = "0") %>%
    stringr::str_detect("\\d{8}") %>%
    magrittr::and(!is.na(x))
}
