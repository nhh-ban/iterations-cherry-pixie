# This file contains tests to be applied to 
# the Vegvesen stations-data *after* being transformed
# to a data frame. 
# 
# All tests are packed in a function test_stations_metadata that apples
# all the aforementioned tests

# Test to see if the column names are correct 
# if the column names match the specified names below, it returns "pass", otherwise
# it returns "fail", both of which give a message saying whether it matches or not 
test_stations_metadata_colnames <-
  function(df) {
    
    expected_colnames <- c("id", "name", "latestData", "lat", "lon")
    
    if (all(colnames(df) == expected_colnames) == TRUE) {
      print("PASS: Data has the correct columns")
    } else{
      print("FAIL: Columns do not match the correct specification")
    }
  }

# Test to see if the number of rows seems reasonable. The expected number is between 
# 5000 and 10000, which returns a "pass" message. Above or below these numbers return 
# a "fail" message with feedback on whether the number is too high or too low. 
test_stations_metadata_nrows <-
  function(df) {
    
    min_expected_rows <- 5000
    max_expected_rows <- 10000
    
    if (nrow(df) > min_expected_rows & nrow(df) < max_expected_rows) {
      print("PASS: Data has a reasonable number of rows")
    } else if (nrow(df) <= min_expected_rows) {
      print("FAIL: Data has suspiciously few rows")
    } else {
      print("FAIL: Data has suspiciously many rows")
    }
  }

# Test to see if the columns are specified to be the correct type 
test_stations_metadata_coltypes <-
  function(df) {
    expected_coltypes <-
      c("character", "character", "double", "double", "double")
    
    if (all(df %>%
            map_chr( ~ typeof(.)) == expected_coltypes) == TRUE) {
      print("PASS: All cols have the correct specifications")
    } else{
      print("FAIL: Columns do not have the correct specification")
    }
  }

# Test to see if a lot of data is missing or if it seems within normal expectations   
test_stations_metadata_nmissing <-
  function(df) {
    max_miss_vals <- 200
    
    if (df %>% map_int( ~ sum(is.na((.)))) %>% sum(.) < max_miss_vals) {
      print("PASS: Amount of missing values is reasonable")
    } else {
      print("FAIL: Too many missing values in data set")
    }
  }

# Test to see if the timezone is set to UTC 
test_stations_metadata_latestdata_timezone <-
  function(df) {
    
    if (attr(df$latestData,"tzone")=="UTC") {
      print("PASS: latestData has UTC-time zone")
    } else {
      print("FAIL: latestData does not have expected UTC-time zone")
    }
  }

# Gathering all the tests in one function 
test_stations_metadata <- 
  function(df){
    test_stations_metadata_colnames(df)
    test_stations_metadata_coltypes(df)
    test_stations_metadata_nmissing(df)
    test_stations_metadata_nrows(df)
    test_stations_metadata_latestdata_timezone(df)
  }





