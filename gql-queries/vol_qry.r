#Problem 4b #### 

require(glue)

# GQL function 
vol_qry <- function(id, from, to){
  #translate the string using %s for strings 
  gettextf(' 
  {
    trafficData(trafficRegistrationPointId: "%s") {
      volume {
        byHour(from: "%s", to: "%s") {
          edges {
            node {
              from
              to
              total {
                volumeNumbers {
                  volume
                }
              }
            }
          }
        }
      }
    }
  }', id, from, to) 
}


# verify 
GQL(
  vol_qry(
    id=stations_metadata_df$id[1], 
    from=to_iso8601(stations_metadata_df$latestData[1],-4),
    to=to_iso8601(stations_metadata_df$latestData[1],0)
  ),
  .url = configs$vegvesen_url
)
