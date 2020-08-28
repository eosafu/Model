library(BayesX)
library(tmap)
library(RColorBrewer)
library(sf)
library(tidyverse)
library(ggplot2)
library(ggspatial)
theme_set(theme_bw())
afr <- read.bnd("C:/Users/ezras/Documents/EG/COVID19/SpatialAfrica/m1/afr47_reord.bnd")
afri <- st_read("C:/Users/ezras/Documents/EG/COVID19/SpatialAfrica/Shapefile_Africa_47_Countries/Africa47covid.shp")

setwd("C:/Users/ezras/Documents/EG/COVID19/SpatialAfrica/new_results/m2")
countrypi <- read.table("b1_MAIN_pi_REGRESSION_covid_spatial_MRF_effect_of_country.res",header=T)
countrypiran <- read.table("b1_MAIN_pi_REGRESSION_covid_random_effect_of_country.res",header=T)
countrylam <- read.table("b1_MAIN_lambda_REGRESSION_covid_spatial_MRF_effect_of_country.res",header=T)
countrylamran <- read.table("b1_MAIN_lambda_REGRESSION_covid_random_effect_of_country.res",header=T)
cwk1lam <- read.table("b1_MAIN_lambda_REGRESSION_covid_spatial_MRF_effect_of_wk1_country.res",header=T)
cwk2lam <- read.table("b1_MAIN_lambda_REGRESSION_covid_spatial_MRF_effect_of_wk2_country.res",header=T)
cwk3lam <- read.table("b1_MAIN_lambda_REGRESSION_covid_spatial_MRF_effect_of_wk3_country.res",header=T)
cwk4lam <- read.table("b1_MAIN_lambda_REGRESSION_covid_spatial_MRF_effect_of_wk4_country.res",header=T)
cwk5lam <- read.table("b1_MAIN_lambda_REGRESSION_covid_spatial_MRF_effect_of_wk5_country.res",header=T)
cwk6lam <- read.table("b1_MAIN_lambda_REGRESSION_covid_spatial_MRF_effect_of_wk6_country.res",header=T)


cwk1lam$week <- "Week 1 (14 Feb - 13 Mar)"
cwk2lam$week <- "Week 2 (14 - 20 Mar)"
cwk3lam$week <- "Week 3 (21 - 27 Mar)"
cwk4lam$week <- "Week 4 (28 Mar - 3 Apr)"
cwk5lam$week <- "Week 5 (4 - 10 Apr)"
cwk6lam$week <- "Week 6 (11 - 15 Apr)"

countrylam$type <- "Structured"
countrylamran$type <- "Unstructured"
countrylam <- select(countrylam, country,pmean,type)
countrylamran <- select(countrylamran,country,pmean_tot,type)
countrylamran <- rename(countrylamran,pmean=pmean_tot)

#pi
countrypi$type <- "Structured"
countrypiran$type <- "Unstructured"
countrypi <- select(countrypi, country,pmean,type)
countrypiran <- select(countrypiran,country,pmean_tot,type)
countrypiran <- rename(countrypiran,pmean=pmean_tot)


map_countrylam <- inner_join(afri,countrylam)
map_countrylamran <- inner_join(afri,countrylamran)

map_countrypi <- inner_join(afri,countrypi)
map_countrypiran <- inner_join(afri,countrypiran)


weekdata <- rbind(cwk1lam,cwk2lam,cwk3lam,cwk4lam,cwk5lam,cwk6lam)
map_week <- inner_join(afri,weekdata)

counlambda <- rbind(countrylam,countrylamran)
map_countrylambda <- inner_join(afri,counlambda)
drawmap(cwk5lam,afr,"country","pmean",col="hsv")

map_counrty <- inner_join(afri,Countrylamran)

windows()


##### Plot of weeeks
ggplot(data = map_week) +
  geom_sf(aes(fill = pmean))+
  facet_wrap(~week)+
  scale_fill_continuous(high = "#800000", low = "#EEE8AA")+
  annotation_scale(location = "bl", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering) 
## Str + unstr lambda
ggplot(data = map_countrylambda) +
  geom_sf(aes(fill = pmean))+
  facet_wrap(~type)+
  scale_fill_continuous(high = "#800000", low = "#EEE8AA")+
  annotation_scale(location = "bl", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering) 

## Str 
ggplot(data = map_countrylam) +
  geom_sf(aes(fill = pmean))+
  scale_fill_continuous(high = "#800000", low = "#EEE8AA")+
  annotation_scale(location = "bl", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering) 
## Unstr 
ggplot(data = map_countrylamran) +
  geom_sf(aes(fill = pmean_tot))+
  scale_fill_continuous(high = "#800000", low = "#EEE8AA")+
  annotation_scale(location = "bl", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering) 

## Str + unstr pi
ggplot(data = map_countrylambda) +
  geom_sf(aes(fill = pmean))+
  facet_wrap(~type)+
  scale_fill_continuous(high = "#800000", low = "#EEE8AA")+
  annotation_scale(location = "bl", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering) 

## Str pi
ggplot(data = map_countrypi) +
  geom_sf(aes(fill = pmean))+
  scale_fill_continuous(high = "#800000", low = "#EEE8AA")+
  annotation_scale(location = "bl", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering) 
## Unstr  pi 
ggplot(data = map_countrypiran) +
  geom_sf(aes(fill = pmean_tot))+
  scale_fill_continuous(high = "#800000", low = "#EEE8AA")+
  annotation_scale(location = "bl", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering) 

timlam <- read.table("b1_MAIN_lambda_REGRESSION_covid_nonlinear_pspline_effect_of_day.res",header=T)
timpi <- read.table("b1_MAIN_pi_REGRESSION_covid_nonlinear_pspline_effect_of_day.res",header=T)
timlam$type <- "Lambda"
timpi$type <- "Pi"
trend <- rbind(timlam,timpi)

#time lambda
ggplot(timlam)+
  geom_line(aes(day,pmean))+
  geom_line(aes(day,pqu2p5), col="blue")+
  geom_line(aes(day,pqu97p5),col="blue")+
  ylab("Estimate")+xlab("Days")+
  theme(axis.title.x = element_text(size=13),axis.title.y = element_text(size=13))+
  theme_bw()

#time pi
ggplot(timpi)+
  geom_line(aes(day,pmean))+
  geom_line(aes(day,pqu2p5), col="blue")+
  geom_line(aes(day,pqu97p5),col="blue")+
  ylab("Estimate")+xlab("Days")+
  theme(axis.title.x = element_text(size=13),axis.title.y = element_text(size=13))+
  theme_bw()

#time pi + Lambda
ggplot(trend)+
  geom_line(aes(time,pmean))+
  geom_line(aes(time,pqu2p5), col="blue")+
  geom_line(aes(time,pqu97p5),col="blue")+
  ylab("Estimate")+xlab("Days")+
  facet_wrap(~type)
  theme(axis.title.x = element_text(size=13),axis.title.y = element_text(size=13))+
  theme_bw()


ggplot(data = map_counrty) +
  geom_sf(aes(fill = pmean_tot))+
  scale_fill_continuous(high = "#B22222", low = "#FFF8DC")+
  annotation_scale(location = "bl", width_hint = 0.3) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.2, "in"), pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) 
 
# coord_sf(xlim = c(12, 9), ylim = c(5, 33.97))

   


   scale_fill_gradientn(colours=c("coral4", "white", "chocolate4"),values=c(4,-2))+
  scale_colour_gradient(low="coral4", high="chocolate4")

scale_fill_gradientn(colours=c("coral4", "white", "chocolate4"),values=c(-2,4))

  scale_fill_viridis_c(option = "plasma")
  scale_fill_brewer(palette="Dark2",values=c(-2,4))
  scale_fill_gradientn(colours ="YlOrBr")
  scale_fill_gradientn(colours=c("YlOrBr"),values=c(-2,4))
  scale_fill_viridis_c(option = "plasma")

ggplot(data = world) +
  geom_sf(aes(fill = pop_est),) +
  scale_fill_viridis_c(option = "plasma", trans = "sqrt")
