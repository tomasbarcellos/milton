test_that("Retorna formato esperado", {
  resp1 <- get_addr("Avenida pequeno príncipe")
  expect_s3_class(resp1, "sfc")

  resp2 <- get_addr("Rua Vergueiro")
  expect_length(resp2, 1)
})

test_that("Retorna lat long de endereco", {
  resp1 <- get_addr("Avenida pequeno príncipe")
  esperado <- sf::st_point(c(-48.4922023, -27.6820247))
  expect_true(sf::st_distance(resp1[[1]], esperado) < 0.01)

  resp2 <- get_addr("Rua Vergueiro")
  esperado2 <- sf::st_point(c(-46.6354222, -23.5857686))
  expect_true(sf::st_distance(resp2[[1]], esperado2) < 0.01)
})

test_that("Erros sao suaves", {
  # endereço = NULL
  resp1 <- get_addr()
  expect_s3_class(resp1, "sfc")

  # endereco inexistente/erro digitacao - com M e no lugar de N
  resp2 <- get_addr("Avemida pequeno principe")
  expect_length(resp2, 1)
  expect_equal(resp2, sf::st_sfc(sf::st_point(), crs = 4674))
  expect_true(sf::st_is_empty(resp2))

})

test_that("Retorna lat long de CEP", {
  expect_equal(get_addr(88063000), get_addr("Avenida pequeno principe"))

  expect_equal(milton:::cep(70050000), "Esplanada Dos Ministérios")
  expect_equal(milton:::cep(68915970), "Avenida Costa e Silva")

})
