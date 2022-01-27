test_that("Retorna formato esperado", {
  resp1 <- get_addr("Avenida pequeno príncipe")
  expect_s3_class(resp1, "sfg")

  resp2 <- get_addr("Rua Vergueiro")
  expect_length(resp2, 2)
})

test_that("Retorna lat long de endereco", {
  resp1 <- get_addr("Avenida pequeno príncipe")
  expect_true(abs(resp1[[1]] - -48.4922023) < 0.01)
  expect_true(abs(resp1[[2]] - -27.6820247) < 0.01)

  resp2 <- get_addr("Rua Vergueiro")

  expect_true(abs(resp2[[1]] - -46.6354222) < 0.01)
  expect_true(abs(resp2[[2]] - -23.5857686) < 0.01)

})

test_that("Erros sao suaves", {
  # endereço = NULL
  resp1 <- get_addr()
  expect_s3_class(resp1, "sfg")

  # endereco inexistente/erro digitacao - com M e no lugar de N
  resp2 <- get_addr("Avemida pequeno principe")
  expect_length(resp2, 2)
  expect_equal(resp2, sf::st_point())
  expect_true(all(is.na(resp2)))

})

test_that("Retorna lat long de CEP", {
  expect_equal(get_addr(88063000), get_addr("Avenida pequeno principe"))

  expect_equal(milton:::cep(70050000), "Esplanada Dos Ministérios")
  expect_equal(milton:::cep(68915970), "Avenida Costa e Silva")

})
