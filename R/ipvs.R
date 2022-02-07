#' Ler dados do Indice Paulista de Vulnerabilidade Social (IPVS)
#'
#' @return Uma tibble
#' @export
ler_ipvs <- function() {
  td <- tempdir()
  tf <- tempfile(tmpdir = td)
  httr::GET("http://www.ipvs.seade.gov.br/view/zip/ipvs/BaseIPVS2010_csv.zip",
            httr::write_disk(tf))
  utils::unzip(tf, exdir = td)

  dicionario <- suppressMessages(
    readr::read_tsv(file.path(td, "IPVS_Dicionario.txt"),
                    locale = readr::locale(encoding = "UCS-2LE"))
  ) %>%
    janitor::clean_names() %>%
    utils::head(51) %>%
    dplyr::mutate(
      descricao = descricao %>%
        stringr::str_remove("\\(.+\\)") %>%
        stringr::str_squish()
    ) %>%
    unique()

  ipvs <- suppressMessages(
    readr::read_csv2(file.path(td, "BaseIPVS2010.csv"))
    ) %>%
    purrr::set_names(dicionario$descricao) %>%
    janitor::clean_names()

  ipvs %>%
    dplyr::mutate(codigo_do_setor_censitario = as.character(codigo_do_setor_censitario ))
}
