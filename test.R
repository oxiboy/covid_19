library(leaflet)

download.file('https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/02-05-2021.csv','data.csv')
inputs <- read.csv2('data.csv',sep = ',')
inputs <- inputs[,c('Province_State','Country_Region','Lat','Long_','Deaths','Recovered','Active')]
country <- inputs[inputs$Country_Region =='Colombia',]
names(country) <- c('Province_State','Country_Region','Lat','Lng','Deaths','Recovered','Active')
country$Lat <- as.numeric(country$Lat)
country$Lng <- as.numeric(country$Lng)
country %>%
  leaflet() %>%
  addTiles() %>%
  addCircles(weight = 2, radius = sqrt(country$Recovered) * 100,popup = country$Province_State,
    label = (country$Recovered))