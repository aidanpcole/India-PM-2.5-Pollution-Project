# Aidan Cole India PM 2.5 Pollution Project 
# Calculating average PM 2.5 concentration by Indian district/state

# load libraries 
library(tidyverse)
library(tidycensus)
library(tigris)
library(tmap)
library(sf)
library(kableExtra)
library(tigris)
library(ggmap)
library(raster)
library(stargazer)
library(caTools)
library(caret)
library(spdep)
library(mapboxapi)
library(units)
library(rgdal)
library(ggplot2)


# ---- Load Styling options -----

mapTheme <- function(base_size = 12) {
  theme(
    text = element_text( color = "black"),
    plot.title = element_text(size = 16,colour = "black"),
    plot.subtitle=element_text(face="italic"),
    plot.caption=element_text(hjust=0),
    axis.ticks = element_blank(),
    panel.background = element_blank(),axis.title = element_blank(),
    axis.text = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(colour = "black", fill=NA, size=2),
    strip.text.x = element_text(size = 14))
}

plotTheme <- function(base_size = 12) {
  theme(
    text = element_text( color = "black"),
    plot.title = element_text(size = 16,colour = "black"),
    plot.subtitle = element_text(face="italic"),
    plot.caption = element_text(hjust=0),
    axis.ticks = element_blank(),
    panel.background = element_blank(),
    panel.grid.major = element_line("grey80", size = 0.1),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(colour = "black", fill=NA, size=2),
    strip.background = element_rect(fill = "grey80", color = "white"),
    strip.text = element_text(size=12),
    axis.title = element_text(size=12),
    axis.text = element_text(size=10),
    plot.background = element_blank(),
    legend.background = element_blank(),
    legend.title = element_text(colour = "black", face = "italic"),
    legend.text = element_text(colour = "black", face = "italic"),
    strip.text.x = element_text(size = 14)
  )
}

# Load Quantile break functions

qBr <- function(df,variable,rnd) {
  if (missing(rnd)) {
    as.character(quantile(round(df[[variable]],0),
                          c(.01,.2,.4,.6,.8), na.rm=T))
  } else if (rnd == FALSE | rnd == F) {
    as.character(formatC(quantile(df[[variable]],
                                  c(.01,.2,.4,.6,.8), na.rm=T), digits = 3))
  }
}

q5 <- function(variable) {as.factor(ntile(variable, 5))}

# Load hexadecimal color palette

palette5 <- c("#f0f9e8","#bae4bc","#7bccc4","#43a2ca","#0868ac")


# Pollution Data
# Read in the geojson data and store it in a variable 
pollution2010 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2010pollution.geojson") %>%
  st_transform('EPSG:24048')
pollution2011 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2011pollution.geojson") %>%
  st_transform('EPSG:24048')
pollution2012 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2012pollution.geojson") %>%
  st_transform('EPSG:24048')
pollution2013 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2013pollution.geojson") %>%
  st_transform('EPSG:24048')
pollution2014 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2014pollution.geojson") %>%
  st_transform('EPSG:24048')
pollution2015 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2015pollution.geojson") %>%
  st_transform('EPSG:24048')
pollution2016 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2016pollution.geojson") %>%
  st_transform('EPSG:24048')
pollution2017 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2017pollution.geojson") %>%
  st_transform('EPSG:24048')
pollution2018 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2018pollution.geojson") %>%
  st_transform('EPSG:24048')
pollution2019 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2019pollution.geojson") %>%
  st_transform('EPSG:24048')



# WAS 24048
pollutionstates2010 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2010pollutionstates.geojson") %>%
  st_transform('EPSG:23948')
pollutionstates2011 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2011pollutionstates.geojson") %>%
  st_transform('EPSG:23948')
pollutionstates2012 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2012pollutionstates.geojson") %>%
  st_transform('EPSG:23948')
pollutionstates2013 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2013pollutionstates.geojson") %>%
  st_transform('EPSG:23948')
pollutionstates2014 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2014pollutionstates.geojson") %>%
  st_transform('EPSG:23948')
pollutionstates2015 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2015pollutionstates.geojson") %>%
  st_transform('EPSG:23948')
pollutionstates2016 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2016pollutionstates.geojson") %>%
  st_transform('EPSG:23948')
pollutionstates2017 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2017pollutionstates.geojson") %>%
  st_transform('EPSG:23948')
pollutionstates2018 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2018pollutionstates.geojson") %>%
  st_transform('EPSG:23948')
pollutionstates2019 <- st_read("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/ReferenceData/2019pollutionstates.geojson") %>%
  st_transform('EPSG:23948')





# Example visualization to make sure it worked 
ggplot() +
  geom_sf(data=st_union(pollution2010)) +
  geom_sf(data=pollution2010,aes(fill=q5(grid_code))) +
  scale_fill_manual(values=palette5,
                    labels=qBr(pollution2010,"grid_code"),
                    name="PM 2.5 Concentration\n(Quintile Breaks)") +
  labs(title="PM 2.5 Concentration", 
       subtitle="India, 2010", 
       caption="Figure 1") +
  mapTheme()

# Example visualization to make sure it worked 
ggplot() +
  geom_sf(data=st_union(pollutionstates2010)) +
  geom_sf(data=pollutionstates2010,aes(fill=q5(grid_code))) +
  scale_fill_manual(values=palette5,
                    labels=qBr(pollutionstates2010,"grid_code"),
                    name="PM 2.5 Concentration\n(Quintile Breaks)") +
  labs(title="PM 2.5 Concentration", 
       subtitle="India, 2010", 
       caption="Figure 1") +
  mapTheme()






Complete2010 <- pollution2010 %>%
  mutate("State" = statename,
         "District" = distname,
         "Total Population" = totalpopul,
         "Average PM 2.5 Concentration" = round(grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollution2010$grid_code,5)) %>%
  dplyr::select("State","District","Total Population","Average PM 2.5 Concentration","PM 2.5 Concentration Quantile")

Complete2011 <- pollution2011 %>%
  mutate("State" = statename,
         "District" = distname,
         "Total Population" = totalpopul,
         "Average PM 2.5 Concentration" = round(grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollution2011$grid_code,5)) %>%
  dplyr::select("State","District","Total Population","Average PM 2.5 Concentration","PM 2.5 Concentration Quantile")

Complete2012 <- pollution2012 %>%
  mutate("State" = statename,
         "District" = distname,
         "Total Population" = totalpopul,
         "Average PM 2.5 Concentration" = round(grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollution2012$grid_code,5)) %>%
  dplyr::select("State","District","Total Population","Average PM 2.5 Concentration","PM 2.5 Concentration Quantile")

Complete2013 <- pollution2013 %>%
  mutate("State" = statename,
         "District" = distname,
         "Total Population" = totalpopul,
         "Average PM 2.5 Concentration" = round(grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollution2013$grid_code,5)) %>%
  dplyr::select("State","District","Total Population","Average PM 2.5 Concentration","PM 2.5 Concentration Quantile")

Complete2014 <- pollution2014 %>%
  mutate("State" = statename,
         "District" = distname,
         "Total Population" = totalpopul,
         "Average PM 2.5 Concentration" = round(grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollution2014$grid_code,5)) %>%
  dplyr::select("State","District","Total Population","Average PM 2.5 Concentration","PM 2.5 Concentration Quantile")

Complete2015 <- pollution2015 %>%
  mutate("State" = statename,
         "District" = distname,
         "Total Population" = totalpopul,
         "Average PM 2.5 Concentration" = round(grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollution2015$grid_code,5)) %>%
  dplyr::select("State","District","Total Population","Average PM 2.5 Concentration","PM 2.5 Concentration Quantile")

Complete2016 <- pollution2016 %>%
  mutate("State" = statename,
         "District" = distname,
         "Total Population" = totalpopul,
         "Average PM 2.5 Concentration" = round(grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollution2016$grid_code,5)) %>%
  dplyr::select("State","District","Total Population","Average PM 2.5 Concentration","PM 2.5 Concentration Quantile")

Complete2017 <- pollution2017 %>%
  mutate("State" = statename,
         "District" = distname,
         "Total Population" = totalpopul,
         "Average PM 2.5 Concentration" = round(grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollution2017$grid_code,5)) %>%
  dplyr::select("State","District","Total Population","Average PM 2.5 Concentration","PM 2.5 Concentration Quantile")

Complete2018 <- pollution2018 %>%
  mutate("State" = statename,
         "District" = distname,
         "Total Population" = totalpopul,
         "Average PM 2.5 Concentration" = round(grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollution2018$grid_code,5)) %>%
  dplyr::select("State","District","Total Population","Average PM 2.5 Concentration","PM 2.5 Concentration Quantile")

Complete2019 <- pollution2019 %>%
  mutate("State" = statename,
         "District" = distname,
         "Total Population" = totalpopul,
         "Average PM 2.5 Concentration" = round(grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollution2019$grid_code,5)) %>%
  dplyr::select("State","District","Total Population","Average PM 2.5 Concentration","PM 2.5 Concentration Quantile")

st_write(Complete2010, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/new2010pm25.geojson")
st_write(Complete2011, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/new2011pm25.geojson")
st_write(Complete2012, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/new2012pm25.geojson")
st_write(Complete2013, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/new2013pm25.geojson")
st_write(Complete2014, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/new2014pm25.geojson")
st_write(Complete2015, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/new2015pm25.geojson")
st_write(Complete2016, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/new2016pm25.geojson")
st_write(Complete2017, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/new2017pm25.geojson")
st_write(Complete2018, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/new2018pm25.geojson")
st_write(Complete2019, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/new2019pm25.geojson")


Complete2010States <- pollutionstates2010 %>%
  mutate("Name" = Name,
         "Type" = Type,
         "2010 PM 2.5 Score" = round(pollutionstates2010$grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollutionstates2010$grid_code,5)) %>%
  dplyr::select("Name","Type","2010 PM 2.5 Score","PM 2.5 Concentration Quantile")

Complete2011States <- pollutionstates2011 %>%
  mutate("Name" = Name,
         "Type" = Type,
         "2011 PM 2.5 Score" = round(pollutionstates2011$grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollutionstates2011$grid_code,5)) %>%
  dplyr::select("Name","Type","2011 PM 2.5 Score","PM 2.5 Concentration Quantile")

Complete2012States <- pollutionstates2012 %>%
  mutate("Name" = Name,
         "Type" = Type,
         "2012 PM 2.5 Score" = round(pollutionstates2012$grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollutionstates2012$grid_code,5)) %>%
  dplyr::select("Name","Type","2012 PM 2.5 Score","PM 2.5 Concentration Quantile")

Complete2013States <- pollutionstates2013 %>%
  mutate("Name" = Name,
         "Type" = Type,
         "2013 PM 2.5 Score" = round(pollutionstates2013$grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollutionstates2013$grid_code,5)) %>%
  dplyr::select("Name","Type","2013 PM 2.5 Score","PM 2.5 Concentration Quantile")

Complete2014States <- pollutionstates2014 %>%
  mutate("Name" = Name,
         "Type" = Type,
         "2014 PM 2.5 Score" = round(pollutionstates2014$grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollutionstates2014$grid_code,5)) %>%
  dplyr::select("Name","Type","2014 PM 2.5 Score","PM 2.5 Concentration Quantile")

Complete2015States <- pollutionstates2015 %>%
  mutate("Name" = Name,
         "Type" = Type,
         "2015 PM 2.5 Score" = round(pollutionstates2015$grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollutionstates2015$grid_code,5)) %>%
  dplyr::select("Name","Type","2015 PM 2.5 Score","PM 2.5 Concentration Quantile")

Complete2016States <- pollutionstates2016 %>%
  mutate("Name" = Name,
         "Type" = Type,
         "2016 PM 2.5 Score" = round(pollutionstates2016$grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollutionstates2016$grid_code,5)) %>%
  dplyr::select("Name","Type","2016 PM 2.5 Score","PM 2.5 Concentration Quantile")

Complete2017States <- pollutionstates2017 %>%
  mutate("Name" = Name,
         "Type" = Type,
         "2017 PM 2.5 Score" = round(pollutionstates2017$grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollutionstates2017$grid_code,5)) %>%
  dplyr::select("Name","Type","2017 PM 2.5 Score","PM 2.5 Concentration Quantile")

Complete2018States <- pollutionstates2018 %>%
  mutate("Name" = Name,
         "Type" = Type,
         "2018 PM 2.5 Score" = round(pollutionstates2018$grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollutionstates2018$grid_code,5)) %>%
  dplyr::select("Name","Type","2018 PM 2.5 Score","PM 2.5 Concentration Quantile")

Complete2019States <- pollutionstates2019 %>%
  mutate("Name" = Name,
         "Type" = Type,
         "2019 PM 2.5 Score" = round(pollutionstates2019$grid_code, digits=2),
         "PM 2.5 Concentration Quantile" = ntile(pollutionstates2019$grid_code,5)) %>%
  dplyr::select("Name","Type","2019 PM 2.5 Score","PM 2.5 Concentration Quantile")

st_write(Complete2010States, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/states2010pm25.geojson")
st_write(Complete2011States, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/states2011pm25.geojson")
st_write(Complete2012States, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/states2012pm25.geojson")
st_write(Complete2013States, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/states2013pm25.geojson")
st_write(Complete2014States, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/states2014pm25.geojson")
st_write(Complete2015States, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/states2015pm25.geojson")
st_write(Complete2016States, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/states2016pm25.geojson")
st_write(Complete2017States, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/states2017pm25.geojson")
st_write(Complete2018States, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/states2018pm25.geojson")
st_write(Complete2019States, "/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/DataForMap/states2019pm25.geojson")
"C:\Users\Aidan\Desktop\India Pollution Project\India-PM-2.5-Pollution-Project\data\StatewiseData\StatewiseTreeCover.csv"

# Tree Cover
TreeCover <- read.csv("/Users/Aidan/Desktop/India Pollution Project/India-PM-2.5-Pollution-Project/data/StatewiseData/StatewiseTreeCover.csv") 

# ADD ROW TO POLLUTIONandHEALTH FOR 137000 Tract 
PollutionandHealth[nrow(PollutionandHealth) + 1,] <- c(6037137000,2354,'Los Angeles',91367,'Woodland Hills',-118.636,34.16657,11.72,18.27,'15-20%',0.055,73.5,10.81494,53.67,0.046,16.37,702.76,72.97,46.34,46.13,0.01,12.18,232.1077,36.11,347.2178,10.85,0.1,2.43,1.05,9.87,0.05,26.37,3,34.11,0,0,31.67,3.9,24.23,38.86,39.49,2.17,2.75,15.38,68.71,5.9,25.1,2.1,16.42,6.9,3.56,4.9,35.13,12.8,24.78,28.99,3.01,18.54)

# Convert lat/long to a sf 
Pollution_sf <- PollutionandHealth %>%
  st_as_sf(coords = c("Longitude","Latitude"), crs=4326)%>%
  st_transform('EPSG:3498')


# filter to only LA 
#filteredPollution = st_filter(Pollution_sf, Homeless_and_Tracts, .pred = st_within)

Pollution_and_Tracts <- merge(Homeless_and_Tracts, st_drop_geometry(Pollution_sf), by.x="Tract", by.y="Census.Tract", all.Homeless_and_Tracts=TRUE) %>%
  dplyr::select(-Total.Population, -ZIP, -California.County, -Nearby.City...to.help.approximate.location.only.,
                -DRAFT.CES.4.0.Percentile.Range, -Ozone, -PM2.5, -Diesel.PM, -Drinking.Water, 
                -Lead, -Lead.Pctl, -Pesticides, -Pesticides.Pctl, -Tox..Release, -Traffic, -Traffic.Pctl, -Cleanup.Sites,
                -Cleanup.Sites.Pctl, -Groundwater.Threats, -Haz..Waste, -Imp..Water.Bodies, -Solid.Waste,
                -Low.Birth.Weight, -Cardiovascular.Disease,
                -TotalUnemployed, -TotalWorkers, -Institutionalized, -Total18To65, -DRAFT.CES.4.0.Score,
                -DRAFT.CES.4.0.Percentile,-Drinking.Water.Pctl,-Tox..Release.Pctl,
                -Groundwater.Threats.Pctl, -Haz..Waste.Pctl, -Imp..Water.Bodies.Pctl, -Solid.Waste.Pctl,
                -Pollution.Burden.Score,-Asthma, -Education, -Linguistic.Isolation, -Poverty, -Pollution.Burden, 
                -Unemployment, -Housing.Burden, -Pop..Char..Score, -Pop..Char., -Pop..Char..Pctl)











































MapToken = "pk.eyJ1IjoiYWlkYW5wY29sZSIsImEiOiJjbDEzcmwwY2oxeGd4M2tydHJvNmtidjMyIn0.DJrO8ZYZuhECivpDEs2pAA"
mb_access_token(MapToken,install=TRUE,overwrite = TRUE)

tm_shape(pollutionstates2010) + 
  tm_polygons()

hennepin_tiles <- get_static_tiles(
  location = pollutionstates2010,
  zoom = 6,
  style_id = "light-v9",
  username = "mapbox"
)

# Social and Environmental Vulnerability Map 
tm_shape(hennepin_tiles) + 
  tm_rgb() + 
  tm_shape(pollutionstates2010) + 
  tm_polygons(col = "grid_code",
              style = "jenks",
              n = 5,
              palette = "Reds",
              title = "Average PM 2.5 Concentration",
              alpha = 0.7) +
  tm_layout(title = "Average PM 2.5 Concentration\nby district in India",
            legend.outside = TRUE,
            fontfamily = "Verdana") + 
  tm_scale_bar(position = c("left", "bottom")) + 
  tm_compass(position = c("right", "top")) + 
  tm_credits("(c) Mapbox, OSM    ", 
             bg.color = "white",
             position = c("RIGHT", "BOTTOM"))

# DATA WRANGLINGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG


# Hospitals and Urgent Cares  
# Read in the CSV data and store it in a variable 
HAddress <- read.csv("/Users/Aidan/Desktop/code2/LARPFINAL/los-angeles-county-hospitals-and-medical-centers.csv")

# take (lat,lon) out of ADDRESS column
#HisAddress$ADDRESS<-gsub("^.*\\(","",HisAddress$ADDRESS)
#HisAddress$ADDRESS<-gsub(")", "", HisAddress$ADDRESS)
#HisLatLon <- HisAddress %>%
#  mutate(X = gsub("^(.*?),.*", "\\1", HisAddress$ADDRESS),
#         Y = gsub(".*,","",HisAddress$ADDRESS))

# Convert lat/long to a sf
H_sf <- HAddress %>%
  st_as_sf(coords = c("longitude","latitude"), crs=4326)%>%
  st_transform('EPSG:3498') 

# Example visualization to make sure it worked 
ggplot() + 
  geom_sf(data=st_union(filteredTracts)) +
  geom_sf(data=H_sf, 
          show.legend = "point", size= 2) +
  labs(title="Hospitals and Urgent Care Locations", 
       subtitle="Los Angeles, CA", 
       caption="Figure 2") +
  mapTheme()

# Emergency Preparedness Locations (schools)
# Read in the CSV data and store it in a variable 
ELocations <- st_read("/Users/Aidan/Desktop/code2/LARPFINAL/Public_Elementary_Schools.geojson") %>%
  st_transform('EPSG:3498') 

MLocations <- st_read("/Users/Aidan/Desktop/code2/LARPFINAL/Public_Middle_Schools.geojson") %>%
  st_transform('EPSG:3498')

HLocations <- st_read("/Users/Aidan/Desktop/code2/LARPFINAL/Public_High_Schools.geojson") %>%
  st_transform('EPSG:3498')

CLocations <- st_read("/Users/Aidan/Desktop/code2/LARPFINAL/Colleges_and_Universities.geojson") %>%
  st_transform('EPSG:3498')

EandM <- rbind(ELocations, MLocations)
HandC <- rbind(HLocations, CLocations)
EmergencyLocations <- rbind(EandM, HandC)


# Convert lat/long to a sf 
Emergency_sf <- EmergencyLocations %>%
  st_as_sf(coords = c("longitude","latitude"), crs=4326)%>%
  st_transform('EPSG:3498')

# Example visualization to make sure it worked 
ggplot() + 
  geom_sf(data=st_union(filteredTracts)) +
  geom_sf(data=Emergency_sf, 
          show.legend = "point", size= 2) +
  labs(title="Emergency Preparedness Sites", 
       subtitle="Los Angeles, CA", 
       caption="Figure 3") +
  mapTheme()


# community cooling centers = libraries
CoolingLocations <- st_read("/Users/Aidan/Desktop/code2/LARPFINAL/Libraries.geojson") %>%
  st_transform('EPSG:3498')


# Example visualization to make sure it worked 
ggplot() + 
  geom_sf(data=st_union(filteredTracts)) +
  geom_sf(data=CoolingLocations, 
          show.legend = "point", size= 2) +
  labs(title="Community Cooling Centers", 
       subtitle="Los Angeles, CA", 
       caption="Figure 4") +
  mapTheme()



# Homeless Count by Census tract 
HomelessCount <- 
  st_read("/Users/Aidan/Desktop/code2/LARPFINAL/Homeless_Count_Los_Angeles_County_2019.geojson") %>%
  st_transform('EPSG:3498') 

HomelessTracts <- HomelessCount$Tract_N

Homeless_and_Tracts <- filteredTracts %>%
  mutate(HomelessPeople = ifelse(filteredTracts$Tract_N %in% HomelessTracts, HomelessCount$totPeopl_1, 0),
         pctHomeless = ifelse(HomelessPeople > 0 & TotalPop > 0, HomelessPeople/TotalPop,0),
         HomelessDensity = ifelse(filteredTracts$Tract_N %in% HomelessTracts, HomelessCount$t_dens,0))
# combine homeless count with tracts 
#Homeless_and_Tracts <- merge(filteredTracts, st_drop_geometry(HomelessCount), by="Tract_N", all.filteredTracts=TRUE) %>%
#  dplyr::select(-FID, -SPA, -CD, -Detailed_1, -Detailed_N, -SD, -Tract_1, -Year_1, -unincorpor,
#                -SHAPE_Length, -SHAPE_Area, -totUnshe_1, -totShelt_1, -u_dens, -s_dens)


# Pollution and health data 
PollutionandHealth <- read.csv("/Users/Aidan/Desktop/code2/LARPFINAL/CalEnviroScreen_4.0Excel_ADA_D1_2021.csv") %>%
  filter(California.County=='Los Angeles')

# ADD ROW TO POLLUTIONandHEALTH FOR 137000 Tract 
PollutionandHealth[nrow(PollutionandHealth) + 1,] <- c(6037137000,2354,'Los Angeles',91367,'Woodland Hills',-118.636,34.16657,11.72,18.27,'15-20%',0.055,73.5,10.81494,53.67,0.046,16.37,702.76,72.97,46.34,46.13,0.01,12.18,232.1077,36.11,347.2178,10.85,0.1,2.43,1.05,9.87,0.05,26.37,3,34.11,0,0,31.67,3.9,24.23,38.86,39.49,2.17,2.75,15.38,68.71,5.9,25.1,2.1,16.42,6.9,3.56,4.9,35.13,12.8,24.78,28.99,3.01,18.54)

# Convert lat/long to a sf 
Pollution_sf <- PollutionandHealth %>%
  st_as_sf(coords = c("Longitude","Latitude"), crs=4326)%>%
  st_transform('EPSG:3498')


# filter to only LA 
#filteredPollution = st_filter(Pollution_sf, Homeless_and_Tracts, .pred = st_within)

Pollution_and_Tracts <- merge(Homeless_and_Tracts, st_drop_geometry(Pollution_sf), by.x="Tract", by.y="Census.Tract", all.Homeless_and_Tracts=TRUE) %>%
  dplyr::select(-Total.Population, -ZIP, -California.County, -Nearby.City...to.help.approximate.location.only.,
                -DRAFT.CES.4.0.Percentile.Range, -Ozone, -PM2.5, -Diesel.PM, -Drinking.Water, 
                -Lead, -Lead.Pctl, -Pesticides, -Pesticides.Pctl, -Tox..Release, -Traffic, -Traffic.Pctl, -Cleanup.Sites,
                -Cleanup.Sites.Pctl, -Groundwater.Threats, -Haz..Waste, -Imp..Water.Bodies, -Solid.Waste,
                -Low.Birth.Weight, -Cardiovascular.Disease,
                -TotalUnemployed, -TotalWorkers, -Institutionalized, -Total18To65, -DRAFT.CES.4.0.Score,
                -DRAFT.CES.4.0.Percentile,-Drinking.Water.Pctl,-Tox..Release.Pctl,
                -Groundwater.Threats.Pctl, -Haz..Waste.Pctl, -Imp..Water.Bodies.Pctl, -Solid.Waste.Pctl,
                -Pollution.Burden.Score,-Asthma, -Education, -Linguistic.Isolation, -Poverty, -Pollution.Burden, 
                -Unemployment, -Housing.Burden, -Pop..Char..Score, -Pop..Char., -Pop..Char..Pctl)


Pollution_and_Tracts[is.na(Pollution_and_Tracts)] <- 0

SocialTracts <- Pollution_and_Tracts %>%
  mutate(PM2.5.Pctl = as.numeric(Pollution_and_Tracts$PM2.5.Pctl) / 100,
         Pollution.Burden.Pctl = as.numeric(Pollution_and_Tracts$Pollution.Burden.Pctl) / 100,
         Asthma.Pctl = as.numeric(Pollution_and_Tracts$Asthma.Pctl) / 100, 
         Education.Pctl = as.numeric(Pollution_and_Tracts$Education.Pctl) / 100, 
         Linguistic.Isolation.Pctl = as.numeric(Pollution_and_Tracts$Linguistic.Isolation.Pctl) / 100,
         Poverty.Pctl = as.numeric(Pollution_and_Tracts$Poverty.Pctl) / 100, 
         Unemployment.Pctl = as.numeric(Pollution_and_Tracts$Unemployment.Pctl) / 100,
         Housing.Burden.Pctl = as.numeric(Pollution_and_Tracts$Housing.Burden.Pctl) / 100,
         Low.Birth.Weight.Pctl = as.numeric(Pollution_and_Tracts$Low.Birth.Weight.Pctl) / 100, 
         Cardiovascular.Disease.Pctl = as.numeric(Pollution_and_Tracts$Cardiovascular.Disease.Pctl) / 100,
         Ozone.Pctl = as.numeric(Pollution_and_Tracts$Ozone.Pctl) / 100,
         Diesel.PM.Pctl = as.numeric(Pollution_and_Tracts$Diesel.PM.Pctl) / 100) 

SocialTracts <- SocialTracts %>%
  mutate(EducationQuantile = ntile(SocialTracts$Education.Pctl,5),
         PovertyQuantile = ntile(SocialTracts$Poverty.Pctl,5),
         UnemploymentQuantile = ntile(SocialTracts$Unemployment.Pctl,5),
         SingleParentQuantile = ntile(SocialTracts$pctSinglePar,5),
         Under5Quantile = ntile(SocialTracts$pctUnder5,5),
         Over65Quantile = ntile(SocialTracts$pctOver65,5),
         MentalQuantile = ntile(SocialTracts$pctMENTAL,5),
         PhysicalQuantile = ntile(SocialTracts$pctPHY,5),
         NonWhiteQuantile = ntile(SocialTracts$pctNonWhite,5),
         ImmigrantsQuantile = ntile(SocialTracts$pctImmigrants,5),
         PriorImmigrantQuantile = ntile(SocialTracts$pctPriorImmigrants,5),
         LinguisticIsolationQuantile = ntile(SocialTracts$Linguistic.Isolation.Pctl,5),
         AsthmaQuantile = ntile(SocialTracts$Asthma.Pctl,5),
         BirthWeightQuantile = ntile(SocialTracts$Low.Birth.Weight.Pctl,5),
         CardioDiseaseQuantile = ntile(SocialTracts$Cardiovascular.Disease.Pctl,5),
         CarlessQuantile = ntile(SocialTracts$pctCarless,5),
         PublicTransQuantile = ntile(SocialTracts$pctPubTrans,5),
         HomelessQuantile = ntile(SocialTracts$pctHomeless,5),
         InstitQuantile = ntile(SocialTracts$pctInstit,5),
         HBurdenQuantile = ntile(SocialTracts$Housing.Burden.Pctl,5))




SocialVulScore <- SocialTracts %>%
  mutate(SocVulScore = (((SocialTracts$EducationQuantile + SocialTracts$PovertyQuantile + SocialTracts$UnemploymentQuantile) / 3) * 0.2 + ((SocialTracts$SingleParentQuantile + SocialTracts$Under5Quantile + SocialTracts$Over65Quantile + SocialTracts$PhysicalQuantile + SocialTracts$MentalQuantile) / 5) * 0.2 + ((SocialTracts$NonWhiteQuantile + SocialTracts$ImmigrantsQuantile + SocialTracts$PriorImmigrantQuantile + SocialTracts$LinguisticIsolationQuantile) / 4) * 0.2 + ((SocialTracts$AsthmaQuantile + SocialTracts$CardioDiseaseQuantile + SocialTracts$BirthWeightQuantile) / 3) * 0.2 + ((SocialTracts$CarlessQuantile + SocialTracts$HomelessQuantile + SocialTracts$InstitQuantile + SocialTracts$PublicTransQuantile + SocialTracts$HBurdenQuantile) / 5) * 0.2))

SocialVulScore[is.na(SocialVulScore)] <- 0

filteredSocial <- SocialVulScore %>%
  filter(SocialVulScore$Tract_N != 599100 & SocialVulScore$Tract_N != 599000)

ggplot() +
  geom_sf(data=st_union(filteredSocial)) +
  geom_sf(data=filteredSocial,aes(fill=q5(SocVulScore)))+
  scale_fill_manual(values=palette5,
                    labels=qBr(filteredSocial,"SocVulScore"),
                    name="Social Vulnerability Score\n(Quintile Breaks)")+
  labs(title="Social Vulnerability Score", 
       subtitle="Los Angeles, CA", 
       caption="Figure 4") +
  mapTheme()


MapToken = "pk.eyJ1IjoiYWlkYW5wY29sZSIsImEiOiJjbDEzcmwwY2oxeGd4M2tydHJvNmtidjMyIn0.DJrO8ZYZuhECivpDEs2pAA"
mb_access_token(MapToken,install=TRUE,overwrite = TRUE)

tm_shape(filteredSocial) + 
  tm_polygons()

hennepin_tiles <- get_static_tiles(
  location = filteredSocial,
  zoom = 10,
  style_id = "light-v9",
  username = "mapbox"
)

# Social and Environmental Vulnerability Map 
tm_shape(hennepin_tiles) + 
  tm_rgb() + 
  tm_shape(filteredSocial) + 
  tm_polygons(col = "SocVulScore",
              style = "jenks",
              n = 5,
              palette = "Purples",
              title = "Social Vulnerability Index",
              alpha = 0.7) +
  tm_layout(title = "Social Vulnerability Index\nby Census tract",
            legend.outside = TRUE,
            fontfamily = "Verdana") + 
  tm_scale_bar(position = c("left", "bottom")) + 
  tm_compass(position = c("right", "top")) + 
  tm_credits("(c) Mapbox, OSM    ", 
             bg.color = "white",
             position = c("RIGHT", "BOTTOM"))







######## PHYSICAL VULNERABILITY 

# turn SocialVulScore into filteredSocial if you want without catalina islands 
#distance to closest hospital in feet 
nearestHospital <- st_nearest_feature(st_centroid(SocialVulScore),H_sf)
nearestHospitalDist = st_distance(st_centroid(SocialVulScore), H_sf[nearestHospital,], by_element=TRUE)
SocialVulScore$nearestHospitalDist = nearestHospitalDist

#Count of hospitals per census tract 
SocialVulScore <- SocialVulScore %>% 
  mutate(HospitalCounts = lengths(st_intersects(., H_sf)))


#distance to closest emergency preparedness location 
nearestEmergencyPrep <- st_nearest_feature(st_centroid(SocialVulScore),Emergency_sf)
nearestEmergencyPrepDist = st_distance(st_centroid(SocialVulScore), Emergency_sf[nearestEmergencyPrep,], by_element=TRUE)
SocialVulScore$nearestEmergencyPrepDist = nearestEmergencyPrepDist


#Count of emergency preparedness locations per census tracts 
SocialVulScore <- SocialVulScore %>% 
  mutate(EmergencyPrepCounts = lengths(st_intersects(., Emergency_sf)))


#distance to closest community cooling center 
nearestCoolingStation <- st_nearest_feature(st_centroid(SocialVulScore),CoolingLocations)
nearestCoolingDist = st_distance(st_centroid(SocialVulScore), CoolingLocations[nearestCoolingStation,], by_element=TRUE)
SocialVulScore$nearestCoolingDist = nearestCoolingDist


#Count of community cooling locations per census tracts 
SocialVulScore <- SocialVulScore %>% 
  mutate(CoolingStationCounts = lengths(st_intersects(., CoolingLocations)))


# load in public pools dataset 
PoolLocations <- st_read("/Users/Aidan/Desktop/code2/LARPFINAL/Pools.geojson") %>%
  st_transform('EPSG:3498')

# Convert lat/long to a sf 
Pool_sf <- PoolLocations %>%
  st_as_sf(coords = c("longitude","latitude"), crs=4326)%>%
  st_transform('EPSG:3498')


#distance to closest public pool
nearestPool <- st_nearest_feature(st_centroid(SocialVulScore),Pool_sf)
nearestPoolDist = st_distance(st_centroid(SocialVulScore), Pool_sf[nearestPool,], by_element=TRUE)
SocialVulScore$nearestPoolDist = nearestPoolDist


#Count of public pool per census tracts 
SocialVulScore <- SocialVulScore %>% 
  mutate(PoolCounts = lengths(st_intersects(., Pool_sf)))


#HEAT DATA
historicalTemps <- read.csv("/Users/Aidan/Desktop/code2/LARPFINAL/CHAT-Los Angeles County-historical.csv") %>%
  distinct(census_tract, .keep_all = TRUE) %>%
  dplyr::select(census_tract,avg_event_rh_max_perc,avg_event_rh_min_perc,tmax,tmin,hist_avg_annual_events,hist_avg_duration)


Temps_and_Tracts <- merge(SocialVulScore, historicalTemps, by.x="Tract", by.y="census_tract", all.SocialVulScore=TRUE)

### USE A DIFFERENT PROJECTIONS TIME FRAME SINCE HISTORICAL IS SOMEHOW HIGHER THAN 2011-2030
projectedTemps <- read.csv("/Users/Aidan/Desktop/code2/LARPFINAL/CHAT-Los Angeles County-projected (1).csv") %>%
  na.omit() %>%
  filter(.,projections_time_frame == '2031-2050') 

filteredProjected <- projectedTemps %>%
  mutate(Tract = substring(projectedTemps$geoid_long, nchar(as.character(projectedTemps$geoid_long)) - 9)) %>%
  distinct(Tract, .keep_all = TRUE) 


All_Temps_and_Tracts <- merge(Temps_and_Tracts, filteredProjected, by.x="Tract", by.y="Tract", all.Temps_and_Tracts=TRUE) %>%
  dplyr::select(-geoid_long,-rcp,-projections_ct,-census_county,-census_city,-projections_time_frame,
                -socioeconomic_group,-time_of_year,-model_percentiles)


# polygon green space 
GreenSpace <- st_read("/Users/Aidan/Desktop/code2/LARPFINAL/Countywide_Parks_and_Open_Space_(Public_-_Hosted).geojson") %>%
  st_transform('EPSG:3498') 

# Angeles National Forest only, for proximity to largest public access open green space in the county 
AngelesForest <- GreenSpace %>%
  filter(OBJECTID == 1676)

#distance to Angeles National Forest
AngelesForestDist = st_distance(st_centroid(All_Temps_and_Tracts), GreenSpace[AngelesForest,], by_element=TRUE)
All_Temps_and_Tracts$AngelesForestDist = AngelesForestDist


# convert polygons to centroid points to see which parks and open spaces belong to which census tracts
GreenCentroids <- GreenSpace %>%
  filter(OBJECTID != 1676) %>%
  st_drop_geometry() %>%
  st_as_sf(coords = c("CENTER_LON","CENTER_LAT"), crs=4326) %>%
  st_transform('EPSG:3498') %>%
  dplyr::select(ZIP,RPT_ACRES,geometry)

#Count of green space centroids per census tract 
All_Temps_and_Tracts <- All_Temps_and_Tracts %>% 
  mutate(ParkCounts = lengths(st_intersects(., GreenCentroids)))

# list of tracts to help join later 
Tracts <- All_Temps_and_Tracts %>%
  dplyr::select(Tract,geometry)

# sum total green acres per tract, those tracts not in dataframe have zero public green space 
tracts_with_green <- st_join(GreenCentroids, Tracts, left = F)

GreenTracts <- tracts_with_green %>%
  group_by(Tract) %>%
  summarise(Acres = sum(RPT_ACRES))

GreenIDs <- GreenTracts %>%
  st_drop_geometry() %>%
  dplyr::select(Tract)

# join acres to tracts 
AcreTracts <- All_Temps_and_Tracts %>%
  mutate(GreenAcres = ifelse(All_Temps_and_Tracts$Tract %in% GreenIDs$Tract, GreenTracts$Acres, 0))


# load in census tract layer to get area for each census tract to later calculate percent green space per census tract 
#TractAreas <- st_read("/Users/Aidan/Desktop/code2/LARPFINAL/Census_Tracts_2020.geojson") %>%
#  st_transform('EPSG:3498') %>%
#  st_drop_geometry() %>%
#  dplyr::select(CT20, ShapeSTArea)

#filteredTractAreas <- st_filter(TractAreas, AcreTracts, .pred = st_intersects)

# 0.000022956 * square ft area = acres 
MoreAcreTracts <- AcreTracts %>%
  mutate(TotalAreaSF = st_area(AcreTracts),
         TotalAcres = TotalAreaSF * 0.000022956)

# tracts with percent public green space 
GreenSpaceTracts <- MoreAcreTracts %>%
  drop_units() %>%
  mutate(pctGreenSpace = ifelse(TotalAcres > 0 & TotalAcres > GreenAcres, GreenAcres/TotalAcres, 0)) 


nearestPark <- st_nearest_feature(st_centroid(GreenSpaceTracts),GreenCentroids)
nearestParkDist = st_distance(st_centroid(GreenSpaceTracts), GreenCentroids[nearestPark,], by_element=TRUE)
GreenSpaceTracts$nearestParkDist = nearestParkDist
#drop_units(GreenSpaceTracts)



#CALCULATE CITY AVERAGE HISTORICAL TMAX AND THEN MAKE FEATURE FOR DIFFERENCE BETWEEN EACH TRACT'S VALUES AND THE AVERAGE VALUES
GreenSpaceTracts <- GreenSpaceTracts %>%
  mutate(HisProjTDiff = GreenSpaceTracts$proj_avg_tmax - GreenSpaceTracts$tmax,
         HisProjEventDiff = GreenSpaceTracts$proj_ann_num_events - GreenSpaceTracts$hist_avg_annual_events,
         HisProjDurDiff = GreenSpaceTracts$proj_avg_duration - GreenSpaceTracts$hist_avg_duration,
         HisProjPercDiff = GreenSpaceTracts$proj_avg_rhmax - GreenSpaceTracts$avg_event_rh_max_perc) %>%
  filter(GreenSpaceTracts$Tract_N != 599100 & GreenSpaceTracts$Tract_N != 599000) %>%
  drop_units()


# TREE CANOPY 
tracts_w_tc_id <- st_read("/Users/Aidan/Desktop/code2/LARPFINAL/tracts_w_tc_id.geojson") %>%
  st_transform('EPSG:3498') %>%
  st_drop_geometry()

tc_percentages_w_ids <- st_read("/Users/Aidan/Desktop/code2/LARPFINAL/real_tc_percentages_w_id.geojson") %>%
  st_transform('EPSG:3498') %>%
  st_drop_geometry()

tracts_w_tc_percentages <- merge(tracts_w_tc_id, tc_percentages_w_ids, by.x="TC_ID", by.y="TC_ID", all.tracts_w_tc_id=TRUE) 


# group by tract, sum total area, existing tc, possible tc, etc. 
grouped_tc <- tracts_w_tc_percentages %>%
  group_by(CT10) %>%
  summarise(ExistingTC = sum(TC_E_A),
            PossibleTC = sum(TC_P_A),
            TotalArea = sum(TC_Land_A),
            PossibleIP = sum(TC_Pi_A),
            PossibleVG = sum(TC_Pv_A)) %>%   # calculate percentage
  mutate(EpctTC = ExistingTC/TotalArea,
         PpctTC = PossibleTC/TotalArea,
         PpctIP = PossibleIP/TotalArea,
         PpctVG = PossibleVG/TotalArea)

# calculate average tree canopy percentage for whole county,
# and calculate difference between average and each tract's value
# and calculate difference between possible and actual for each tract 
featured_tc <- grouped_tc %>%
  mutate(AvgTCpct = mean(grouped_tc$EpctTC),
         AvgTCpctDiff = EpctTC - AvgTCpct,
         PEpctDiff = PpctTC - EpctTC) %>%
  dplyr::select(CT10, AvgTCpctDiff, PEpctDiff, EpctTC, PpctIP, PpctVG)


TCGreenSpace <- merge(GreenSpaceTracts, featured_tc, by.x="Tract_N", by.y="CT10", all.GreenSpaceTracts=TRUE)


ggplot() +
  geom_sf(data=st_union(TCGreenSpace)) +
  geom_sf(data=TCGreenSpace,aes(fill=EpctTC))+
  labs(title="Percent Tree Canopy Coverage", 
       subtitle="Los Angeles, CA", 
       caption="Figure 1") +
  mapTheme()



### STANDARDIZE FEATURES WITH QUANTILE RANKINGS FOR PHYSVULSCORE
QuantileTracts <- TCGreenSpace %>%
  mutate(HospitalDistQuantile = ntile(TCGreenSpace$nearestHospitalDist,5),
         EmergencyDistQuantile = ntile(TCGreenSpace$nearestEmergencyPrepDist,5),
         CoolingDistQuantile = ntile(TCGreenSpace$nearestCoolingDist,5),
         ParkDistQuantile = ntile(TCGreenSpace$nearestParkDist,5),
         ForestDistQuantile = ntile(TCGreenSpace$AngelesForestDist,5),
         PoolDistQuantile = ntile(TCGreenSpace$nearestPoolDist,5),
         HospitalCountQuantile = ntile(desc(TCGreenSpace$HospitalCounts),5),
         EmergencyCountQuantile = ntile(desc(TCGreenSpace$EmergencyPrepCounts),5),
         CoolingCountQuantile = ntile(desc(TCGreenSpace$CoolingStationCounts),5),
         ParkCountQuantile = ntile(desc(TCGreenSpace$ParkCounts),5),
         PoolCountQuantile = ntile(desc(TCGreenSpace$PoolCounts),5),
         PM2.5Quantile = ntile(TCGreenSpace$PM2.5.Pctl,5),
         DieselPMQuantile = ntile(TCGreenSpace$Diesel.PM.Pctl,5),
         OzoneQuantile = ntile(TCGreenSpace$Ozone.Pctl,5),
         GreenSpaceQuantile = ntile(desc(TCGreenSpace$pctGreenSpace),5),
         HisProjTDiffQuantile = ntile(TCGreenSpace$HisProjTDiff,5),
         HisProjEventDiffQuantile = ntile(TCGreenSpace$HisProjEventDiff,5),
         HisProjDurDiffQuantile = ntile(TCGreenSpace$HisProjDurDiff,5),
         ExistingTCQuantile = ntile(desc(TCGreenSpace$EpctTC),5),
         PdiffETCQuantile = ntile(desc(TCGreenSpace$PEpctDiff),5))


PhysVulScore <- QuantileTracts %>%
  mutate(PhysVulScore = ((HospitalDistQuantile + EmergencyDistQuantile + CoolingDistQuantile + ParkDistQuantile + ForestDistQuantile + PoolDistQuantile) / 6) * 0.20 + ((HospitalCountQuantile + EmergencyCountQuantile + CoolingCountQuantile + ParkCountQuantile + PoolCountQuantile) / 5) * 0.20 + ((PM2.5Quantile + DieselPMQuantile + OzoneQuantile) / 3) * 0.20 + ((GreenSpaceQuantile + ExistingTCQuantile + PdiffETCQuantile) / 3) * 0.20 + ((HisProjTDiffQuantile + HisProjEventDiffQuantile + HisProjDurDiffQuantile) / 3) * 0.20)



ggplot() +
  geom_sf(data=st_union(PhysVulScore)) +
  geom_sf(data=PhysVulScore,aes(fill=q5(PhysVulScore)))+
  scale_fill_manual(values=palette5,
                    labels=qBr(PhysVulScore,"PhysVulScore"),
                    name="Physical Vulnerability Score\n(Quintile Breaks)")+
  labs(title="Physical Vulnerability Score", 
       subtitle="Los Angeles, CA", 
       caption="Figure 4") +
  mapTheme()


MapToken = "pk.eyJ1IjoiYWlkYW5wY29sZSIsImEiOiJjbDEzcmwwY2oxeGd4M2tydHJvNmtidjMyIn0.DJrO8ZYZuhECivpDEs2pAA"
mb_access_token(MapToken,install=TRUE,overwrite = TRUE)

tm_shape(PhysVulScore) + 
  tm_polygons()

hennepin_tiles <- get_static_tiles(
  location = PhysVulScore,
  zoom = 10,
  style_id = "light-v9",
  username = "mapbox"
)

# Social and Environmental Vulnerability Map 
tm_shape(hennepin_tiles) + 
  tm_rgb() + 
  tm_shape(PhysVulScore) + 
  tm_polygons(col = "PhysVulScore",
              style = "jenks",
              n = 5,
              palette = "Purples",
              title = "Physical Vulnerability Index",
              alpha = 0.7) +
  tm_layout(title = "Physical Vulnerability Index\nby Census tract",
            legend.outside = TRUE,
            fontfamily = "Verdana") + 
  tm_scale_bar(position = c("left", "bottom")) + 
  tm_compass(position = c("right", "top")) + 
  tm_credits("(c) Mapbox, OSM    ", 
             bg.color = "white",
             position = c("RIGHT", "BOTTOM"))



TotalVulScore <- PhysVulScore %>%
  mutate(TotalVulScore = (PhysVulScore + SocVulScore)/2,
         TotalVulScoreQuantile = ntile(TotalVulScore,5),
         SocVulScoreQuantile = ntile(SocVulScore,5),
         PhysVulScoreQuantile = ntile(PhysVulScore,5))


ggplot() +
  geom_sf(data=st_union(TotalVulScore)) +
  geom_sf(data=TotalVulScore,aes(fill=q5(TotalVulScore)))+
  scale_fill_manual(values=palette5,
                    labels=qBr(TotalVulScore,"TotalVulScore"),
                    name="Total Vulnerability Score\n(Quintile Breaks)")+
  labs(title="Total Vulnerability Score", 
       subtitle="Los Angeles, CA", 
       caption="Figure 4") +
  mapTheme()


MapToken = "pk.eyJ1IjoiYWlkYW5wY29sZSIsImEiOiJjbDEzcmwwY2oxeGd4M2tydHJvNmtidjMyIn0.DJrO8ZYZuhECivpDEs2pAA"
mb_access_token(MapToken,install=TRUE,overwrite = TRUE)

tm_shape(TotalVulScore) + 
  tm_polygons()

hennepin_tiles <- get_static_tiles(
  location = TotalVulScore,
  zoom = 10,
  style_id = "light-v9",
  username = "mapbox"
)

# Social and Environmental Vulnerability Map 
tm_shape(hennepin_tiles) + 
  tm_rgb() + 
  tm_shape(TotalVulScore) + 
  tm_polygons(col = "TotalVulScore",
              style = "jenks",
              n = 5,
              palette = "Purples",
              title = "Overall Vulnerability Index",
              alpha = 0.7) +
  tm_layout(title = "Overall Extreme Heat Vulnerability Index\nby Census tract",
            legend.outside = TRUE,
            fontfamily = "Verdana") + 
  tm_scale_bar(position = c("left", "bottom")) + 
  tm_compass(position = c("right", "top")) + 
  tm_credits("(c) Mapbox, OSM    ", 
             bg.color = "white",
             position = c("RIGHT", "BOTTOM"))




# EXPORT DATAFRAMES AS GEOJSON LAYERS 
# pools, emergency, cooling, parks, hospitals
#st_write(H_sf, "/Users/Aidan/Desktop/code2/LARPFINAL/hospitals.geojson")
#st_write(Emergency_sf, "/Users/Aidan/Desktop/code2/LARPFINAL/emergencyprep.geojson")
#st_write(CoolingLocations, "/Users/Aidan/Desktop/code2/LARPFINAL/coolingcenters.geojson")
#st_write(Pool_sf, "/Users/Aidan/Desktop/code2/LARPFINAL/publicpools.geojson")
#st_write(GreenCentroids, "/Users/Aidan/Desktop/code2/LARPFINAL/parksandgs.geojson")


#GreenCentroids <- GreenCentroids %>%
#  dplyr::select(OBJECTID,PARK_NAME,ACCESS_TYP,RPT_ACRES,ADDRESS,CITY,ZIP,PHONES,MNG_AGENCY,AGNCY_WEB)

#Emergency_sf <- Emergency_sf %>%
#  dplyr::select(OBJECTID,Name,addrln1,phones,url,zip,link,latitude,longitude)

#H_sf <- H_sf %>%
#  dplyr::select(phones,Name,zip,addrln1,hours,post_id,link,url,cat1,cat2)

#CoolingLocations <- CoolingLocations %>%
#  dplyr::select(OBJECTID,Name,addrln1,hours,phones,url,zip,link,latitude,longitude)

#Pool_sf <- Pool_sf %>%
#  dplyr::select(OBJECTID,Name,addrln1,hours,phones,url,zip,link,latitude,longitude)