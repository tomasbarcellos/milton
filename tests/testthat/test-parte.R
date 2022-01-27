x <- get_addr("Brasília, DF")
y <- get_addr("Fortaleza")
z <- get_addr("Goiania")
w <- get_addr("Porto Alegre")

X <- c(x, y, z, w)

# regioes <- geobr::read_region(year = 2018, simplified = TRUE)
# mun <- geobr::read_municipality(year = 2018) %>%
#   dplyr::filter(code_state %in% c(42, 35))
# cens <- geobr::read_census_tract(3550308)

regioes <- readRDS("regioes.rds")
mun <- readRDS("mun.rds")
cens <- readRDS("regioes.rds")

test_that("Identificar ponto em poligono", {
  # Cidades estao nas regioes corretas
  resp <- geopart(X, regioes$geom)
  expect_equal(resp, c(5, 2, 5, 4))
  # Ambos sao centro-oeste
  expect_equal(resp[1], resp[3])

  coord <- get_addr("Avenida pequeno príncipe")
  res2 <- geopart(coord, mun$geom)

  expect_equal(mun$name_muni[res2], "Florianópolis")

  res3 <- geopart(coord, cens$geom)
  # Fora de SP
  expect_true(is.na(res3))

  coord2 <- get_addr("Rua vergueiro")
  res4 <- geopart(coord2, mun$geom)
  expect_equal(mun$name_muni[res4], "São Paulo")

  res5 <- geopart(coord2, cens$geom)
  expect_equal(cens$code_tract[res5], "355030890000019")

  # Mesma resposta usando o CEP
  coord3 <- get_addr(milton:::cep("01504-000"))
  res5_cep <- geopart(coord3, cens$geom)

  expect_identical(res5, res5_cep)
})

