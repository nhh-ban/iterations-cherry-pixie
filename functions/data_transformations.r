# Problem 2 #### 

# packages 
# just added about all of them from iterations.r, probably do not need most of them
library(httr)
library(jsonlite)
library(ggplot2)
library(DescTools)
library(tidyverse)
library(magrittr)
library(rlang)
library(lubridate)
library(anytime)
library(readr)

# function based on the lecture content, modified to fit the assignment  
transform_metadata_to_df <- function(data){
  data[[1]] %>%  
    map(as_tibble) %>%  
    list_rbind() %>%  
    mutate(latestData = map_chr(latestData, 1, .default = NA_character_)) %>%  
    mutate(latestData = as_datetime(latestData, tz = "UTC"))  %>%  
    unnest_wider(location) %>%  
    unnest_wider(latLon)
}

# test if the function works 
transform_metadata_to_df(stations_metadata)
# yep, seems to work? 


# Problem 4a #### 

# function 
to_iso8601 <- function(date_time, offset){
  #datetime defined as: 
  date_time <- as_datetime(date_time, tz="UTC")
    if(is.na(date_time)) stop("Datetime error", date_time) 
  #offset defined as: 
  offset_date <- (date_time + days(offset))
    if(is.na(offset_date)) stop("Invalid offset", date_time)
  # using paste0 to make string (instead of paste to remove space before Z)
  conversion <- paste0(iso8601(offset_date),"Z")  
    return(conversion)
}


# test 
to_iso8601(as_datetime("2016-09-01 10:11:12"),0)

# test 2 
to_iso8601(as_datetime("2016-09-01 10:11:12"),-4)


# Problem 5 #### 

# function data_volumes 
data_volumes <- function()
