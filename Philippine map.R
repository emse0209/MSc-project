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

#mapping Philippines data
map<-map_data('Philippines')
ggplot()+
  geom_polygon(data = Philippines, aes(x= long, y= lat, group=group))+
  coord_quickmap()
map_data(Philippines)
