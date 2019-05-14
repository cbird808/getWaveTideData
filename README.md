# getWaveTideData
download and manipulate data from NOAA wave buoys and tide stations

script and files to download wave buoy and tide station data from Hawaiian waters
and extract the maximum observed air temperature each year,
then graph the temperatures against latitude

code will need to be updated if querying before year 2000

to use, run getdata2.bash from the linux (ubuntu) command line

getHiWaveTideData.bash	bash script that uses files listed below to get and summarize data

the following files are required by getdata2.bash to run properly

buoy_tidestations.tab	inventory of stations and associated metadata
stations2				list of station names to query
years					list of years to query

R script for graphing max temperature data:

graph_maxT.R

the bash and R scripts were run in the "data" folder
