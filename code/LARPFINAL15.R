# Aidan Cole LARP 745 Final Project 
# Calculating Extreme Heat Vulnerability in Los Angeles, CA  

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


# load census data and filter to wanted variables 

census_api_key("ea7bd3babfc0da6a4caa6d2536b66403a88929f2", overwrite = TRUE) 

#keep all variables in first three rows and columns
#variables in rows 4 and 5 are for males over age of 65 
#variables in 6 and 7 are for females over age of 65 
#first two in row 8 are males under 5 and females under 5 
#third in row 8 is start of male from 18 to 65 all the way to row 12 B01001_019E
#row 13 female 18 to 65 to first variable in row 17 to B01001_043E
#second two variables in row 17 are male 18-34, 35-64 with disability 
#first two variables in row 18 are female 18-34, 35-64 with disability 
# last variable in row 18 is per capita income in last 12 months, B19301_001E
# first variable row 19 is total unemployed, second and third male mental dis 18-64 
# first andsecond row in 20 is female mental dis 18-64, third is # of people using public transportation to get to work C08111_016E
# first in row 21 # of people using car to get to work, # w no vehicle, # under 6 yrs living with one parent C23008_008E
# first in row 22 # 17 w one parent, second is total work force, third is institutionalized group quarters B26103_003E
# first row 23 spanish b bad english, second other language b bad english, immigrant turned citizen after 5 years B05001_005E
# first row 24 non citizen, second is mobility (moved within LA county), renter occupied B25036_013E
# first row 25 owner occupied, second is total housing units, median age B01002_001E
# row 26 is male age 5-17, row 27 is female age 5-17
tracts19 <- 
  get_acs(geography = "tract", variables = c("B01003_001E","B02001_002E","B02001_003E",
                                             "B03002_003E","B02001_005E","B19013_001E",
                                             "B15002_015E","B15002_032E","B06012_002E",
                                             "B01001_020E","B01001_021E","B01001_022E",
                                             "B01001_023E","B01001_024E","B01001_025E",
                                             "B01001_044E","B01001_045E","B01001_046E",
                                             "B01001_047E","B01001_048E","B01001_049E",
                                             "B01001_003E","B01001_027E","B01001_007E",
                                             "B01001_008E","B01001_009E","B01001_010E",
                                             "B01001_011E","B01001_012E","B01001_013E",
                                             "B01001_014E","B01001_015E","B01001_016E",
                                             "B01001_017E","B01001_018E","B01001_019E",
                                             "B01001_031E","B01001_032E","B01001_033E",
                                             "B01001_034E","B01001_035E","B01001_036E",
                                             "B01001_037E","B01001_038E","B01001_039E",
                                             "B01001_040E","B01001_041E","B01001_042E",
                                             "B01001_043E","B18101_010E","B18101_013E",
                                             "B18101_029E","B18101_032E","B19301_001E",
                                             "B23025_005E","B18104_007E","B18104_010E",
                                             "B18104_023E","B18104_026E","B08006_008E",
                                             "B08006_002E","B08014_002E","B05009_013E",
                                             "B05009_031E","B08006_001E","B26001_001E",
                                             "B06007_005E","B06007_008E","B05001_005E",
                                             "B05001_006E","B07001PR_050E","B25036_013E",
                                             "B25036_002E","B25001_001E","B01002_001E",
                                             "B01001_004E","B01001_005E","B01001_006E",
                                             "B01001_028E","B01001_029E","B01001_030E"), 
          year=2019, state=06, county=037, geometry=T, output='wide') %>%
  st_transform('EPSG:3498') %>%
  rename(TotalPop = B01003_001E, 
         Whites = B02001_002E,
         FemaleBachelors = B15002_032E, 
         MaleBachelors = B15002_015E,
         MedHHInc = B19013_001E, 
         AfricanAmericans = B02001_003E,
         Latinos = B03002_003E,
         Asians = B02001_005E,
         TotalPoverty = B06012_002E,
         MaleUnder5 = B01001_003E,
         FemaleUnder5 = B01001_027E,
         Male6566 = B01001_020E,
         Male6769 = B01001_021E,
         Male7074 = B01001_022E,
         Male7579 = B01001_023E,
         Male8084 = B01001_024E,
         Male85Up = B01001_025E,
         Female6566 = B01001_044E,
         Female6769 = B01001_045E,
         Female7074 = B01001_046E,
         Female7579 = B01001_047E,
         Female8084 = B01001_048E,
         Female85Up = B01001_049E,
         Male1819 = B01001_007E,
         Male20 = B01001_008E,
         Male21 = B01001_009E,
         Male2224 = B01001_010E,
         Male2529 = B01001_011E,
         Male3034 = B01001_012E,
         Male3539 = B01001_013E,
         Male4044 = B01001_014E,
         Male4549 = B01001_015E,
         Male5054 = B01001_016E,
         Male5559 = B01001_017E,
         Male6061 = B01001_018E,
         Male6264 = B01001_019E,
         Female1819 = B01001_031E,
         Female20 = B01001_032E,
         Female21 = B01001_033E,
         Female2224 = B01001_034E,
         Female2529 = B01001_035E,
         Female3034 = B01001_036E,
         Female3539 = B01001_037E,
         Female4044 = B01001_038E,
         Female4549 = B01001_039E,
         Female5054 = B01001_040E,
         Female5559 = B01001_041E,
         Female6061 = B01001_042E,
         Female6264 = B01001_043E,
         Male1834PhyDis = B18101_010E,
         Male3564PhyDis = B18101_013E,
         Female1834PhyDis = B18101_029E,
         Female3564PhyDis = B18101_032E,
         PerCapInc = B19301_001E,
         TotalUnemployed = B23025_005E,
         Male1834MenDis = B18104_007E,
         Male3564MenDis = B18104_010E,
         Female1834MenDis = B18104_023E,
         Female3564MenDis = B18104_026E,
         PublicTrans = B08006_008E,
         CarTrans = B08006_002E,
         NoVehicle = B08014_002E,
         OneParent6 = B05009_013E,
         OneParent17 = B05009_031E,
         TotalWorkers = B08006_001E,
         Institutionalized = B26001_001E,
         SpanNoEng = B06007_005E,
         LangNoEng = B06007_008E,
         ImmNaturalized = B05001_005E,
         ImmNonCitizen = B05001_006E,
         Mobility = B07001PR_050E,
         OwnerOccupied = B25036_002E,
         RenterOccupied = B25036_013E,
         TotalHousingUnits = B25001_001E,
         MedianAge = B01002_001E,
         Male59 = B01001_004E,
         Male1014 = B01001_005E,
         Male1517 = B01001_006E,
         Female59 = B01001_028E,
         Female1014 = B01001_029E,
         Female1517 = B01001_030E) %>%
  dplyr::select(-NAME, -starts_with("B")) %>%
  mutate(pctWhite = ifelse(TotalPop > 0, Whites / TotalPop,0),
         pctBlack = ifelse(TotalPop > 0, AfricanAmericans / TotalPop,0),
         pctLatino = ifelse(TotalPop > 0, Latinos / TotalPop,0),
         pctAsian = ifelse(TotalPop > 0, Asians / TotalPop,0),
         pctNonWhite = ifelse(TotalPop > 0, 1 - pctWhite,0),
         pctBachelors = ifelse(TotalPop > 0, ((FemaleBachelors + MaleBachelors) / TotalPop),0),
         pctPoverty = ifelse(TotalPop > 0, TotalPoverty / TotalPop, 0),
         year = "2019",
         pctUnder5 = ifelse(TotalPop > 0, ((MaleUnder5 + FemaleUnder5) / TotalPop),0),
         pctOver65 = ifelse(TotalPop > 0, ((Male6566 + Male6769 + Male7074 + Male7579 + Male8084 + Male85Up + Female6566 + Female6769 + Female7074 + Female7579 + Female8084 + Female85Up) / TotalPop),0),
         Males18To65 = ifelse(TotalPop > 0, (Male1819 + Male20 + Male21 + Male2224 + Male2529 + Male3034 + Male3539 + Male4044 + Male4549 + Male5054 + Male5559 + Male6061 + Male6264),0),
         Females18To65 = ifelse(TotalPop > 0, (Female1819 + Female20 + Female21 + Female2224 + Female2529 + Female3034 + Female3539 + Female4044 + Female4549 + Female5054 + Female5559 + Female6061 + Female6264),0),
         Total18To65 = ifelse(TotalPop > 0, (Males18To65 + Females18To65),0),
         Total18To65PHY = ifelse(TotalPop > 0, (Male1834PhyDis + Male3564PhyDis + Female1834PhyDis + Female3564PhyDis),0),
         Total18To65MENTAL = ifelse(TotalPop > 0, (Male1834MenDis + Male3564MenDis + Female1834MenDis + Female3564MenDis),0),
         pctPHY = ifelse(TotalPop > 0, (Total18To65PHY / Total18To65),0),
         pctMENTAL = ifelse(TotalPop > 0, (Total18To65MENTAL / Total18To65),0),
         SinglePar_H = ifelse(TotalPop > 0, (OneParent6 + OneParent17),0),
         pctSinglePar = ifelse(TotalPop > 0, (SinglePar_H / (MaleUnder5 + Male59 + Male1014 + Male1517 + FemaleUnder5 + Female59 + Female1014 + Female1517)),0),
         pctRented = ifelse(TotalHousingUnits > 0, (RenterOccupied / TotalHousingUnits),0),
         pctInstit = ifelse(TotalPop > 0, (Institutionalized / TotalPop),0),
         pctPubTrans = ifelse(TotalWorkers > 0, (PublicTrans / TotalWorkers),0),
         pctCarTrans = ifelse(TotalWorkers > 0, (CarTrans / TotalWorkers),0),
         pctCarless = ifelse(TotalPop > 0, (NoVehicle / TotalPop),0),
         pctPoorEnglish = ifelse(TotalPop > 0, ((SpanNoEng + LangNoEng) / TotalPop),0),
         pctDisplacment = ifelse(TotalPop > 0, (Mobility / TotalPop),0),
         pctImmigrants = ifelse(TotalPop > 0, (ImmNonCitizen / TotalPop),0),
         pctPriorImmigrants = ifelse(TotalPop > 0, (ImmNaturalized / TotalPop),0)) %>%
  dplyr::select(-Whites, -FemaleBachelors, -MaleBachelors, -TotalPoverty, -AfricanAmericans, -Asians, -Latinos,
                -MaleUnder5, -FemaleUnder5, -Male6566, -Male6769, -Male7074, -Male7579, -Male8084, -Male85Up, -Female6566,
                -Female6769, -Female7074, -Female7579, -Female8084, -Female85Up, - Male1819, -Male20, -Male21, 
                -Male2224, -Male2529, -Male3034, -Male3539, -Male4044, -Male4549, -Male5054, -Male5559, -Male6061, -Male6264,
                -Female1819, -Female20, -Female21, -Female2224, -Female2529, -Female3034, -Female3539, -Female4044, -Female4549, 
                -Female5054, -Female5559, -Female6061, -Female6264, -Male1834PhyDis, -Male3564PhyDis, -Female1834PhyDis,
                -Female3564PhyDis, -OneParent6, -OneParent17, -RenterOccupied, 
                -OwnerOccupied, -PublicTrans, -CarTrans, -Mobility, -Males18To65, -Females18To65,
                -Total18To65PHY, -Total18To65MENTAL, -Male59, -Male1014, -Male1517, -Female59, -Female1014, -Female1517, -NoVehicle,
                -SpanNoEng, -LangNoEng, -SinglePar_H, -pctDisplacment, -Male1834MenDis, -Male3564MenDis, -Female1834MenDis, -Female3564MenDis)


tracts19[is.na(tracts19)] <- 0


#only if filtering to LA CITY 
#LosAngelesBoundary <- 
#  st_read("/Users/Aidan/Desktop/code2/LARPFINAL/City Boundary of Los Angeles.geojson") %>%
#  st_transform('EPSG:3498') 


#filteredTracts = st_filter(tracts19na, LosAngelesBoundary, .pred = st_intersects)
filteredTracts <- tracts19 %>%
  mutate(Tract_N = substring(tracts19$GEOID, nchar(as.character(tracts19$GEOID)) - 5),
         Tract = substring(tracts19$GEOID, nchar(as.character(tracts19$GEOID)) - 9))


ggplot() +
  geom_sf(data=st_union(filteredTracts)) +
  geom_sf(data=filteredTracts,aes(fill=q5(MedHHInc)))+
  scale_fill_manual(values=palette5,
                    labels=qBr(filteredTracts,"MedHHInc"),
                    name="Median Household Income\n(Quintile Breaks)")+
  labs(title="Median Household Income", 
       subtitle="Los Angeles, CA", 
       caption="Figure 1") +
  mapTheme()



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












