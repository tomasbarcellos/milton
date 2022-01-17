library(ggplot2)
library(sp)

<<<<<<< HEAD
# To do :
# Debugar local mais próximo

# Three centers 
=======
set.seed(2600)
>>>>>>> 7fce4ffcfb03fe6bdae6c93ffbf9606bd5909c0a

# Three centers

schoolA = c(-46.642902,-23.610586)
## Escola Municipal de Ensino Fundamental Parque das Flores
schoolB = c(-46.636747,-23.608101)
## Escola Municipal Jean Mermoz
schoolC = c(-46.633597,-23.605939)
## EMEI PAULO ALVES, TTE.

## Sample lat and lon

<<<<<<< HEAD
sim_df2 <- data.frame(group = c(rep('A',40),rep('B',40),rep('C',40)))

sim_df2$lat[1:40] <- rnorm(n=40,mean=schoolA[2],sd=.003)
sim_df2$lon[1:40] <- rnorm(n=40,mean=schoolA[1],sd=.003)

sim_df2$lat[41:80] <- rnorm(n=40,mean=schoolB[2],sd=.003)
sim_df2$lon[41:80] <- rnorm(n=40,mean=schoolB[1],sd=.003)

sim_df2$lat[81:120] <- rnorm(n=40,mean=schoolC[2],sd=.003)
sim_df2$lon[81:120] <- rnorm(n=40,mean=schoolC[1],sd=.003)

## Sample executive functioning

sim_df2$dist[1:40] = spDistsN1(pts=cbind(sim_df2$lon[1:40],sim_df2$lat[1:40]),
                         pt = schoolA,longlat=T) 
sim_df2$dist[41:80] = spDistsN1(pts=cbind(sim_df2$lon[41:80],sim_df2$lat[41:80]),
                              pt = schoolB,longlat=T) 
sim_df2$dist[81:120] = spDistsN1(pts=cbind(sim_df2$lon[81:120],sim_df2$lat[81:120]),
                               pt = schoolB,longlat=T) 

sim_df2$exc_func[1:40] <- sim_df2$dist[1:40]*.5 + 1 + rnorm(40,0,.1)
sim_df2$exc_func[41:80] <- sim_df2$dist[41:80]*.5 + 2 + rnorm(40,0,.1)
sim_df2$exc_func[81:120] <- sim_df2$dist[81:120]*.5 + 3 + rnorm(40,0,.1)

ggplot(sim_df2,aes(x=lat,y=lon,color=group)) + geom_point()

school_mat <- rbind(schoolA,schoolB,schoolC)

colnames(school_mat) <- c("lat","lon")
  

# Min. Distance
min_dists <- min_dist(coords = sim_df2[,c("lon","lat")],
         targets = school_mat)

cor.test(min_dists,sim_df2$exc_func)

# Nearest place 

nearplace(coords = sim_df2[,c("lon","lat")],
          targets = school_mat,
          target_label = "group")
=======
sim_df2 <- data.frame(group = c(rep('A',100),rep('B',100),rep('C',100)))

sim_df2$lat[1:100] <- rnorm(n=100,mean=schoolA[2],sd=.005)
sim_df2$lon[1:100] <- rnorm(n=100,mean=schoolA[1],sd=.005)

sim_df2$lat[101:200] <- rnorm(n=100,mean=schoolB[2],sd=.005)
sim_df2$lon[101:200] <- rnorm(n=100,mean=schoolB[1],sd=.005)

sim_df2$lat[201:300] <- rnorm(n=100,mean=schoolC[2],sd=.005)
sim_df2$lon[201:300] <- rnorm(n=100,mean=schoolC[1],sd=.005)

## Sample executive functioning

sim_df2$dist[1:100] = spDistsN1(pts=cbind(sim_df2$lon[1:100],sim_df2$lat[1:100]),
                         pt = schoolA,longlat=T)
sim_df2$dist[101:200] = spDistsN1(pts=cbind(sim_df2$lon[101:200],sim_df2$lat[101:200]),
                              pt = schoolB,longlat=T)
sim_df2$dist[201:300] = spDistsN1(pts=cbind(sim_df2$lon[201:300],sim_df2$lat[201:300]),
                               pt = schoolB,longlat=T)

sim_df2$exc_func[1:100] <- sim_df2$dist[1:100]*.5 + 1 + rnorm(1:100,0,.1)
sim_df2$exc_func[101:200] <- sim_df2$dist[101:200]*.5 + 2 + rnorm(100,0,.1)
sim_df2$exc_func[201:300] <- sim_df2$dist[201:300]*.5 + 3 + rnorm(100,0,.1)

ggplot(sim_df2,aes(x=lat,y=lon,color=group)) + geom_point()

cor.test(sim_df2$dist,sim_df2$exc_func)
>>>>>>> 7fce4ffcfb03fe6bdae6c93ffbf9606bd5909c0a
