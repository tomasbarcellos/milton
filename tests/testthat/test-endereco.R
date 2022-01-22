test_that("Retorna formato esperado", {
  resp1 <- get_addr("Avenida pequeno príncipe")
  expect_s3_class(resp1, "tbl")

  resp2 <- get_addr("Rua Vergueiro")
  expect_length(resp2, 2)
  expect_equal(nrow(resp2), 1L)
})

test_that("Retorna lat long de endereco", {
  resp1 <- get_addr("Avenida pequeno príncipe")
  expect_true(abs(resp1$lon - -48.4922023) < 0.01)
  expect_true(abs(resp1$lat - -27.6820247) < 0.01)

  resp2 <- get_addr("Rua Vergueiro")

  expect_true(abs(resp2$lon - -46.6354222) < 0.01)
  expect_true(abs(resp2$lat - -23.5857686) < 0.01)

})

test_that("Erros sao suaves", {
  # endereço = NULL
  resp1 <- get_addr()
  expect_s3_class(resp1, "tbl")
  expect_named(resp1, c("lon", "lat"))

  # endereco inexistente/erro digitacao - com M e no lugar de N
  resp2 <- get_addr("Avemida pequeno principe")
  expect_equal(nrow(resp2), 0L)
  expect_equal(ncol(resp2), 2L)

})

test_that("Retorna lat long de CEP", {
  expect_equal(get_addr(88063000), get_addr("Avenida pequeno principe"))

  expect_equal(milton:::cep(70050000), "Esplanada Dos Ministérios")
  expect_equal(milton:::cep(68915970), "Avenida Costa e Silva")

})
