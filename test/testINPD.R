library(haven)
library(ggthemes)
library(lme4)
library(magrittr)
library(rgdal)
library(OpenStreetMap)
library(ggplot2)
source("../R/public_get_addr.R") # line 14
source("../R/public_nearplace.R")
source("../R/public_geopart.R") # line 32
source("../R/public_min_dist.R") # line 39

# Ficticious School positions
-46.69468 -23.56535
school_points <- rbind(
  c(-46.643324,-23.598420),
  c(-46.653398,-23.598430),
  c(-46.663394,-23.598450), 
  rbind(get_addr("Avenida Brigadeiro Faria Lima, São Paulo") %>% as.numeric)) %>%
  data.frame(.,names=c("A","B","C","D"))

colnames(school_points) <- c("lon","lat","names")

# Data 
inpd_df<- read.csv2("../data/data-cross-lab.csv")
addr_df <- haven::read_spss("../data/geo_HRC.sav")
renda_df <- haven::read_spss("../data/Banco Renda - Merged alternativo-w0-w1 030518.sav")

addrw0_df <- addr_df[(addr_df$redcap_event_name=="wave0_arm_1"),]
w0_compl_df <- addrw0_df[complete.cases(addrw0_df[,c("lat","lon")]),]

inpd_df <- inpd_df[,c("subjectid","JAP_EF","ZJAP_EF")]

sample_coords <- w0_compl_df[,c("lon","lat")]

setor_sens <- readOGR("../data/setor censitario", # directory name
                      layer="DEINFO_SETOR_CENSITARIO_2010") #.shp filename

# Testing partitioning function
part_data <- geopart(shape_file=setor_sens,
                     dataset=w0_compl_df[-c(1:1253),]) # SP cases

test_data <- dplyr::left_join(inpd_df,part_data,by="subjectid") 
test_data <- test_data[complete.cases(test_data),] 

# Testing closest distance
test_data$min_school <- min_dist(coords=test_data[,c("lon","lat")],
                                 targets=school_points)

# Closest school group level
test_data$nearplace <- nearplace(coords=test_data[,c("lon","lat")],
                                 targets=school_points)

#
ipvs_df <- read.csv2("../data/IPVS/BaseIPVS2010.csv")
var_names <- read.table("../data/IPVS/IPVS_Dicionario.txt",
                        sep = "\t", fileEncoding="UCS-2LE",
                        header=T)
names(ipvs_df) <- var_names$Descrição

names(ipvs_df)[9] <- "CODSETOR" 
test_data$CODSETOR <- test_data$CODSETOR %>% as.character %>% as.numeric
ipvs_inpd_df <- dplyr::left_join(test_data,ipvs_df,
                 by="CODSETOR")

ipvs_inpd_df <- dplyr::left_join(ipvs_inpd_df,renda_df[,c("subjectid","renda_total")],
                                 by="subjectid")
ipvs_inpd_df$renda_diff <- ipvs_inpd_df$renda_total - ipvs_inpd_df$`Rendimento médio domiciliar dos domicílios particulares permanentes`

# Hipotese primaria
glm(JAP_EF ~ as.factor(`Grupo do IPVS`), data=ipvs_inpd_df) # linear model: EF vs. AREA
glm(JAP_EF ~ `Rendimento médio domiciliar dos domicílios particulares permanentes`, data=ipvs_inpd_df) # linear model: EF vs. AREA
glm(JAP_EF ~ renda_total, data=ipvs_inpd_df) # linear model: EF vs. AREA
glm(JAP_EF ~ renda_diff, data=ipvs_inpd_df) # linear model: EF vs. AREA
glm(JAP_EF ~ `Fator 1`, data=ipvs_inpd_df) # linear model: EF vs. AREA
glm(JAP_EF ~ `Fator 2`, data=ipvs_inpd_df) # linear model: EF vs. AREA


ggplot(ipvs_inpd_df,aes(x=as.factor(`Grupo do IPVS`),
                        y=JAP_EF,
                        color=as.factor(`Grupo do IPVS`)))+ 
  geom_point(size = 2,alpha=0.5)

ipvs_inpd_df$geo_exp <- log(ipvs_inpd_df$`Rendimento médio domiciliar dos domicílios particulares permanentes`)
ipvs_inpd_df$geo_inv <- 1/(ipvs_inpd_df$`Rendimento médio domiciliar dos domicílios particulares permanentes`)

# Significant p-value after transfortmation
# Probably due  to large sample size (df=894)
cor.test(ipvs_inpd_df$renda_total,ipvs_inpd_df$geo_inv)
ggplot(ipvs_inpd_df,aes(x=geo_inv,
                        y=renda_total,
                        color=geo_exp))+ 
  geom_point(size = 2,alpha=0.5)

# Teste com outras variaveis
glm(JAP_EF ~ min_school, data=ipvs_inpd_df) # linear model: EF vs. AREA

# Teste com outras variaveis
glm(JAP_EF ~ min_school + `Grupo do IPVS`, data=ipvs_inpd_df) # linear model: EF vs. AREA

# Teste com outras variaveis
glm(JAP_EF ~ min_school + `Grupo do IPVS`, data=ipvs_inpd_df) # linear model: EF vs. AREA

# Random effects for school id (nearest school)
ipvs_inpd_df$renda_thous <- ipvs_inpd_df$renda_total/1000 

mix_mod <- lmerTest::lmer(JAP_EF ~ renda_thous + 
                            as.factor(`Grupo do IPVS`) + (1|nearplace), 
     data=ipvs_inpd_df)

# To do: 
## ( ) Plot map and mark target schools with alpha
## gradient by random effects (below)
ranef(mix_mod)$nearplace # Update!!!
school_points <- cbind(school_points,target_randeff=c(-2,0.5,0.8,2))
school_points <- cbind(school_points,
                       projectMercator(long = school_points$lon,
                                       lat=school_points$lat))
names(school_points)[length(school_points)-1] <- "lon_mer"
names(school_points)[length(school_points)] <- "lat_mer"

p_school <- autoplot(mp)+ 
  geom_point(aes(y=lat_mer,
                 x=lon_mer),
             alpha=0.1,
             color="light pink",
             data=ipvs_inpd_df,
             size=2)+
  geom_point(aes(y=lat_mer,
                 x=lon_mer,
                 colour=names, 
                 alpha=target_randeff),
             data=school_points,
             size=3)+
  scale_colour_brewer()+
  labs(colour=paste("School"))+
  scale_alpha("School random effect")+
  ylab("Lat. (º)") + xlab("Long. (º)")+
  theme_few()


# Graphics
mp <- openmap(upperLeft=c(-23.40047,-46.8056),
              lowerRight =c(-23.78056,-46.40492),
              type="osm")
ipvs_inpd_df <- cbind(ipvs_inpd_df,
                      projectMercator(long = ipvs_inpd_df$lon,lat=ipvs_inpd_df$lat))
names(ipvs_inpd_df)[length(ipvs_inpd_df)-1] <- "lon_mer"
names(ipvs_inpd_df)[length(ipvs_inpd_df)] <- "lat_mer"

# Untested
# Tableau
p_tab <- autoplot(mp)+ 
  geom_point(aes(y=lat_mer,
                 x=lon_mer,
                 colour=as.factor(`Grupo do IPVS`),
                 alpha=renda_total),
             data=ipvs_inpd_df,
             size=2)+
  scale_colour_tableau()+
  labs(colour=paste("Classe IPVS"))+
  ylab("Longitude (º)") + xlab("Latidade (º)")+
  theme_economist_white(gray_bg = F)

# Economist 
p_eco <- autoplot(mp)+ 
  geom_point(aes(y=lat_mer,
                 x=lon_mer,
                 colour=as.factor(`Grupo do IPVS`),
                 alpha=renda_total),
             data=ipvs_inpd_df,
             size=2)+
  scale_colour_economist()+
  labs(colour=paste("Classe IPVS"))+
  ylab("Longitude (º)") + xlab("Latidade (º)")+
  theme_economist_white(gray_bg = F)

# Theme
p_few <- autoplot(mp)+ 
  geom_point(aes(y=lat_mer,
                 x=lon_mer,
                 colour=as.factor(`Grupo do IPVS`),
                 alpha=renda_total),
             data=ipvs_inpd_df,
             size=2)+
  scale_colour_economist()+
  labs(colour=paste("IPVS class"))+
  scale_alpha("Total family income (R$)")+
  ylab("Long. (º)") + xlab("Lat. (º)")+
  theme_few()

# EF
p_ef <- autoplot(mp)+ 
  geom_point(aes(y=lat_mer,
                 x=lon_mer,
                 colour=as.factor(`Grupo do IPVS`),
                 alpha=JAP_EF),
             data=ipvs_inpd_df,
             size=2)+
  scale_colour_economist()+
  labs(colour=paste("IPVS Class"))+
  scale_alpha("Executive Functioning")+
  ylab("Lat. (º)") + xlab("Long. (º)")+
  theme_few()


#Backlog

ggsave(p_ef, width=20, height=20, units="cm",
        filename="outputs/p_ef.png",dpi = 300,
        type="cairo-png")
# 
# Centroids: rgeos::Centroid(sids,byid=TRUE)

