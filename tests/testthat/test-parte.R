x <- get_addr("Brasília, DF")
y <- get_addr("Fortaleza")
z <- get_addr("Goiania")
w <- get_addr("Porto Alegre")

X <- rbind(x, y, z, w)

# regioes <- brazilmaps::get_brmap("Region")
# mun <- brazilmaps::get_brmap("City")
regioes <- readRDS("regioes.rds")
mun <- readRDS("mun.rds")


test_that("Identificar ponto em poligono", {
  # Cidades estao nas regioes corretas
  resp <- geopart(X, regioes)
  gabarito <- c("CENTRO-OESTE", "NORDESTE", "CENTRO-OESTE", "SUL")
  expect_equal(as.character(resp$desc_rg), gabarito)

  coord <- get_addr("Avenida pequeno príncipe")
  res2 <- geopart(coord, mun)
  expect_equal(as.character(res2$nome), "FLORIANÓPOLIS")

  coord2 <- get_addr("Rua vergueiro")
  res3 <- geopart(coord2, mun)
  expect_equal(as.character(res3$nome), "SÃO PAULO")
})
