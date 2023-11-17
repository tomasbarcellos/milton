test_that("Retorna lat long de CEP", {
  expect_equal(get_addr(88063000), get_addr("Avenida pequeno principe"))

  expect_equal(cep(88063000),
               "Avenida Pequeno Príncipe, Florianópolis")
  expect_equal(cep(70050000), "Esplanada Dos Ministérios, Brasília")
  expect_equal(cep(68915970), "Avenida Costa e Silva, Ferreira Gomes")
  expect_equal(cep(68430000), "Igarapé-Miri, Pará")

  # CEP inexistente
  expect_true(is.na(cep(123)))

})

test_that("Funciona com vetores maiores que 1", {
  expect_equal(cep(c(70050000, 68915970)),
               c("Esplanada Dos Ministérios, Brasília",
                 "Avenida Costa e Silva, Ferreira Gomes"))

})


test_that("Identifica corretamente se é CEP", {
  expect_true(is_cep(88063000))
  expect_true(is_cep("88.063-000"))

  # mal formatado
  expect_silent(is_cep("88063000"))
  expect_true(is_cep("88063-000"))

  # comecando com zero
  expect_true(is_cep("02.849170"))
  expect_true(is_cep(2849170))

  # casos que nao sao
  expect_false(is_cep("88.O63-000")) # com letra O
  expect_false(is_cep("a02"))
  expect_false(is_cep("Um CEP"))
  expect_false(is.na(is_cep(NA)))
})

