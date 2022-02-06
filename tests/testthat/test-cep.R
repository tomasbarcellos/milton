test_that("Retorna lat long de CEP", {
  expect_equal(get_addr(88063000), get_addr("Avenida pequeno principe"))

  expect_equal(milton:::cep(88063000),
               "Avenida Pequeno Principe, Florianópolis")
  expect_equal(milton:::cep(70050000), "Esplanada Dos Ministérios, Brasília")
  expect_equal(milton:::cep(68915970), "Avenida Costa e Silva, Ferreira Gomes")

})

test_that("Funciona com vetores maiores que 1", {
  expect_equal(milton:::cep(c(70050000, 68915970)),
               c("Esplanada Dos Ministérios, Brasília",
                 "Avenida Costa e Silva, Ferreira Gomes"))

})

