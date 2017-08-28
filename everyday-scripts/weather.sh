#!/bin/sh
#Change the url for locations of weather
URL='http://www.accuweather.com/en/au/sydney/22889/weather-forecast/22889'

wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $1", "$14 ", " $12"°C"}'| head -1 | sed 's/"/,/g' | cut -d, -f2,3,6,7 
