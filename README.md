
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
#>         lon       lat
#> 1 -38.53066 -3.803069
```

A função `geopart` permite identificar o polígono ao qual uma coordenada
(ou ponto) pertence.

``` r
# exemplo geopart
```

Criando dados para usar nos exemplos a seguir.

``` r
set.seed(2600)

# Three centers

schoolA <- c(-46.642902,-23.610586)
## Escola Municipal de Ensino Fundamental Parque das Flores
schoolB <- c(-46.636747,-23.608101)
## Escola Municipal Jean Mermoz
schoolC <- c(-46.633597,-23.605939)
## EMEI PAULO ALVES, TTE.

## Sample lat and lon

sim_df2 <- data.frame(group = c(rep('A',40),rep('B',40),rep('C',40)))

sim_df2$lat[1:40] <- rnorm(n=40,mean=schoolA[2],sd=.003)
sim_df2$lon[1:40] <- rnorm(n=40,mean=schoolA[1],sd=.003)

sim_df2$lat[41:80] <- rnorm(n=40,mean=schoolB[2],sd=.003)
sim_df2$lon[41:80] <- rnorm(n=40,mean=schoolB[1],sd=.003)

sim_df2$lat[81:120] <- rnorm(n=40,mean=schoolC[2],sd=.003)
sim_df2$lon[81:120] <- rnorm(n=40,mean=schoolC[1],sd=.003)

school_mat <- rbind(schoolA,schoolB,schoolC) %>% 
  transform(group = c("SchoolA", "SchoolB", "SchoolC"))

colnames(school_mat)[1:2] <- c("lat","lon")
```

Com `nearplace` é possível identificar o local (dado uma lista) mais
próximo de um ponto.

``` r
nearplace(coords = sim_df2[,c("lon","lat")],
          targets = school_mat,
          target_label = "group")
#>         1         2         3         4         5         6         7         8 
#> "SchoolB" "SchoolB" "SchoolA" "SchoolA" "SchoolC" "SchoolB" "SchoolA" "SchoolA" 
#>         9        10        11        12        13        14        15        16 
#> "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" 
#>        17        18        19        20        21        22        23        24 
#> "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" 
#>        25        26        27        28        29        30        31        32 
#> "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" 
#>        33        34        35        36        37        38        39        40 
#> "SchoolB" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" "SchoolA" 
#>        41        42        43        44        45        46        47        48 
#> "SchoolC" "SchoolA" "SchoolC" "SchoolB" "SchoolC" "SchoolC" "SchoolB" "SchoolC" 
#>        49        50        51        52        53        54        55        56 
#> "SchoolC" "SchoolB" "SchoolA" "SchoolA" "SchoolC" "SchoolB" "SchoolB" "SchoolC" 
#>        57        58        59        60        61        62        63        64 
#> "SchoolB" "SchoolB" "SchoolA" "SchoolC" "SchoolA" "SchoolB" "SchoolB" "SchoolB" 
#>        65        66        67        68        69        70        71        72 
#> "SchoolB" "SchoolB" "SchoolC" "SchoolA" "SchoolC" "SchoolB" "SchoolC" "SchoolB" 
#>        73        74        75        76        77        78        79        80 
#> "SchoolB" "SchoolB" "SchoolB" "SchoolB" "SchoolC" "SchoolC" "SchoolA" "SchoolB" 
#>        81        82        83        84        85        86        87        88 
#> "SchoolC" "SchoolC" "SchoolC" "SchoolC" "SchoolC" "SchoolC" "SchoolC" "SchoolC" 
#>        89        90        91        92        93        94        95        96 
#> "SchoolC" "SchoolC" "SchoolC" "SchoolC" "SchoolB" "SchoolC" "SchoolC" "SchoolC" 
#>        97        98        99       100       101       102       103       104 
#> "SchoolC" "SchoolB" "SchoolC" "SchoolC" "SchoolB" "SchoolB" "SchoolC" "SchoolC" 
#>       105       106       107       108       109       110       111       112 
#> "SchoolC" "SchoolC" "SchoolB" "SchoolC" "SchoolC" "SchoolC" "SchoolC" "SchoolB" 
#>       113       114       115       116       117       118       119       120 
#> "SchoolB" "SchoolC" "SchoolB" "SchoolC" "SchoolC" "SchoolC" "SchoolC" "SchoolC"
```

`min_dist` retorna a menor distância entre um ponto e um conjunto de
localidades.

``` r
# Min. Distance
min_dists <- min_dist(coords = sim_df2[,c("lon","lat")],
         targets = school_mat)
```
