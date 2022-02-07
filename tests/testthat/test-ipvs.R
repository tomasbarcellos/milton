test_that("Baixa e le IPVS", {
  expect_silent(resp <- ler_ipvs())
  nomes <- c("codigo_do_ibge", "codigo_do_setor_censitario",
             "codigo_do_distrito")

  expect_length(resp, 51)
  expect_s3_class(resp, c("tbl_df"))
  expect_true(all(nomes %in% names(resp)))

})
