x <- get_addr("Brasília, DF")
y <- get_addr("Fortaleza")
z <- get_addr("Goiania")
w <- get_addr("Porto Alegre")

test_that("Calcula distancia ponto-ponto", {
  d <- distancia(x, y)

  # Dependendo de onde pega o ponto pode ser um pouco mais ou menos
  # Mas eh aproximadamente 1690
  expect_true(d > 1680 & d < 1700)
})

test_that("Calcula distancia ponto-vetor", {
  Y <- rbind(y, z, w)

  d <- distancia(x, Y)
  # Dependendo de onde pega o ponto pode ser um pouco mais ou menos
  # Mas eh aproximadamente 1690, 175, 1620
  expect_true(d[[1]] > 1680 & d[[1]] < 1700)
  expect_true(d[[2]] > 165 & d[[2]] < 185)
  expect_true(d[[3]] > 1610 & d[[3]] < 1630)
})


test_that("Calcula distancia vetor-ponto", {
  X <- rbind(x, z, w)

  d <- distancia(X, y)
  # Dependendo de onde pega o ponto pode ser um pouco mais ou menos
  # Mas eh aproximadamente 1690, 1860, 3210
  expect_true(d[[1]] > 1680 & d[[1]] < 1700)
  expect_true(d[[2]] > 1850 & d[[2]] < 1870)
  expect_true(d[[3]] > 3200 & d[[3]] < 3220)
})


test_that("Calcula distancia vetor-vetor", {
  X <- rbind(x, z)
  Y <- rbind(y, w)

  d <- distancia(X, Y)
  # Dependendo de onde pega o ponto pode ser um pouco mais ou menos
  # Mas eh aproximadamente 1690, 1620, 1850, 1500
  expect_true(d[1, 1] > 1680 & d[1, 1] < 1700)
  expect_true(d[1, 2] > 1610 & d[1, 2] < 1630)
  expect_true(d[2, 1] > 1840 & d[2, 1] < 1860)
  expect_true(d[2, 2] > 1490 & d[2, 2] < 1510)
})


test_that("Retorna menor distancia entre X e Y", {
  X <- rbind(x, y, z, w)
  Y <- rbind(x, y, z, w)

  d <- min_dist(X, Y)

  # menor distancia entre capitais eh brasilia <-> goiania: +- 175
  expect_true(min(d) > 165 & min(d) < 185)

  expect_true(d[1] > 165 & d[1] < 185) # bsb - goiania
  expect_true(d[2] > 1680 & d[2] < 1700) # bsb - fortaleza
  expect_true(d[3] > 165 & d[3] < 185) # goiania - bsb
  expect_true(d[4] > 1490 & d[4] < 1510) # goiania - porto alegre
})

test_that("Local mais proximo", {
  X <- rbind(x, y, z, w)
  Y <- rbind(x, y, z, w)

  resp <- tibble::tibble(
    lon = c(-49.2532691, -47.8823172, -47.8823172, -49.2532691),
    lat = c(-16.680882, -15.7934036, -15.7934036, -16.680882)
  )

  # primeiro caso
  expect_equal(nearplace(x, Y), resp[1, ])
  expect_equal(nearplace(X, Y), resp)


})


