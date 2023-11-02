Mapping Study area

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
  theme_bw()
map


#extract Luzon from Philppines
Luzon<-Philippines %>%
  filter(subregion =='Luzon')
head(Luzon)
tail(Luzon)

#Adding locations of sites
labs<- tibble(
  long = c(121.384721, 121.040000, 121.475800, 122.092600, 122.040400),
  lat =  c(16.645834, 18.085700, 17.540300, 16.594200, 16.472900),
  Sites = c("Lower Magat Ecotourism Park", "Calanasan River", "Pared River",
            "Cluster 1: Catallangan River, Dunoy Lake, Dadugen Lake",
            "Cluster 2: Dinang Creek, Ilaguen River"))

#extracted individual sites in separate data frames.
Eco<-labs[1,]
Clu_1<-labs[4,]
Clu_2<-labs[5,]
rest<-labs[c(2,3),]

#mapping Luzon
map_luzon<-ggplot()+
  geom_polygon(data=Luzon, aes(x= long, y= lat, group=group), colour='black', fill='light grey')+ #plot
  xlab('Longitude')+
  ylab('Latitude')+
  
#added points to show locations
  geom_point(data = labs, aes(x= long, y=lat), shape=21, color='red', fill='red', size=2) +
  
#Nudge_x and Nudge_y are used to move the labels so they don't overlap
  geom_text(data = rest, aes(x = long, y = lat, label = Sites), hjust=0, nudge_x = 0.15)+
  geom_text(data = Eco, aes(x = long, y = lat, label = Sites), hjust=0, nudge_y = 0.23)+
  geom_text(data = Clu_1, aes(x = long, y = lat, label = Sites), hjust=0, nudge_y = 0, nudge_x=0.15)+
  geom_text(data = Clu_2, aes(x = long, y = lat, label = Sites), hjust=0, nudge_y = -0.2, nudge_x=0.15)+
  coord_quickmap()+
  theme_bw() #for white background

map_luzon