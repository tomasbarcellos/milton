
<!-- README.md is generated from README.Rmd. Please edit that file -->

# milton

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of milton is to …

## Installation

You can install the development version of milton from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("fargolo/milton-geo")
```

## Example

o pacote oferece uma série de funções de utilidade para trabalhar com
dados georreferenciados.

É possível buscar por endereços e encontrar suas coordenadas geográficas
com a função `get_addr`.

``` r
library(milton)
get_addr("Avenida Heróis do Acre")
#> Carregando pacotes exigidos: jsonlite
#> Carregando pacotes exigidos: curl
#> Using libcurl 7.64.1 with Schannel
#>         lon       lat
#> 1 -38.53066 -3.803069
```

A função `geopart` permite identificar o polígono ao qual uma coordenada
(ou ponto) pertence.

``` r
# exemplo geopart
```

Com `nearplace` é possível identificar o local (dado uma lista) mais
próximo de um ponto.

``` r
# exemplo nearplace
```

`min_dist` retorna a menor distância entre um ponto e um conjunto de
localidades.

``` r
# exemplo min_dist
```
