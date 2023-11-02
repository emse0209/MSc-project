library(tidyverse)
library(mapdata) #contains high-resolution outlines
library(maps) #contains outlines of continents, countries, states etc.
library(stringr)
library(viridis)
library(ggplot2)
library(dplyr)

#help(package='mapdata') #if you need help

w2hr<-map_data('world2Hires')
dim(w2hr)
head(w2hr)
tail(w2hr)

#extract Philippines data
Philippines<-w2hr %>%
  filter(region =='Philippines')
head(Philippines)
tail(Philippines)

#map Philippines data
map<-ggplot()+
  geom_polygon(data = Philippines, aes(x= long, y= lat, group=group), colour='black', fill='light grey')+
  xlab('Longitude')+
  ylab('Latitude')+
  coord_quickmap()+ #makes sure aspect ratios remains unchanged i.e. size of map will not change when exporting
  theme_bw
map


#extract Luzon from Philppines
Luzon<-Philippines %>%
  filter(subregion =='Luzon')
head(Luzon)
tail(Luzon)

#Adding locations of sites
labs<- tibble(
  long = c(121.384721, 121.060000),
  lat =  c(16.645834, 18.240000),
  names = c("Lower Magat Ecotourism Park", "Calanasan River"))

#mapping Luzon
map_luzon<-ggplot()+
  geom_polygon(data=Luzon, aes(x= long, y= lat, group=group), colour='black', fill='light grey')+
  xlab('Longitude')+
  ylab('Latitude')+
  geom_point(data = labs, aes(x= long, y=lat), shape=21, color='blue', fill='blue', size=5) +
  geom_text(data = labs, aes(x = long, y = lat, label = names), hjust=0, nudge_x = 1)+
  coord_quickmap()+
  theme_bw()

map_luzon

