# library(ggplot2)
# library(tidyverse)
# library(sp)
# source("public_min_dist.R")
# source("public_nearplace.R")
#
# # To do :
# # Debugar local mais próximo
#
# # Three centers
# ## Escola Municipal de Ensino Fundamental Parque das Flores
# schoolA <- c(-46.642902,-23.610586)
# ## Escola Municipal Jean Mermoz
# schoolB <- c(-46.636747,-23.608101)
# ## EMEI PAULO ALVES, TTE.
# schoolC <- c(-46.633597,-23.605939)
#
#
# ## Sample lat and lon
# sim_df2 <- data.frame(group = c(rep('A',40),rep('B',40),rep('C',40)))
#
# sim_df2$lat[1:40] <- rnorm(n=40,mean=schoolA[2],sd=.003)
# sim_df2$lon[1:40] <- rnorm(n=40,mean=schoolA[1],sd=.003)
#
# sim_df2$lat[41:80] <- rnorm(n=40,mean=schoolB[2],sd=.003)
# sim_df2$lon[41:80] <- rnorm(n=40,mean=schoolB[1],sd=.003)
#
# sim_df2$lat[81:120] <- rnorm(n=40,mean=schoolC[2],sd=.003)
# sim_df2$lon[81:120] <- rnorm(n=40,mean=schoolC[1],sd=.003)
#
# ## Sample executive functioning
# sim_df2$dist[1:40] = spDistsN1(pts=cbind(sim_df2$lon[1:40],sim_df2$lat[1:40]),
#                          pt = schoolA,longlat=T)
# sim_df2$dist[41:80] = spDistsN1(pts=cbind(sim_df2$lon[41:80],sim_df2$lat[41:80]),
#                               pt = schoolB,longlat=T)
# sim_df2$dist[81:120] = spDistsN1(pts=cbind(sim_df2$lon[81:120],sim_df2$lat[81:120]),
#                                pt = schoolB,longlat=T)
#
# sim_df2$exc_func[1:40] <- sim_df2$dist[1:40]*.5 + 1 + rnorm(40,0,.1)
# sim_df2$exc_func[41:80] <- sim_df2$dist[41:80]*.5 + 2 + rnorm(40,0,.1)
# sim_df2$exc_func[81:120] <- sim_df2$dist[81:120]*.5 + 3 + rnorm(40,0,.1)
#
# ggplot(sim_df2,aes(x=lat,y=lon,color=group)) + geom_point()
#
# school_mat <- as.data.frame(rbind(schoolA,schoolB,schoolC))
#
# colnames(school_mat) <- c("lat","lon")
#
#
# # Min. Distance
# min_dists <- min_dist(coords = sim_df2[,c("lon","lat")],
#          targets = school_mat)
#
# cor.test(min_dists,sim_df2$exc_func)
#
# school_mat$names <- rownames(school_mat)
#
# # Nearest place
# nearplace(coords = sim_df2[,c("lon","lat")],
#           targets = school_mat,
#           target_label = "names")
