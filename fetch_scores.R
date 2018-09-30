# Read locations
locations <- read.csv("./data/locations.csv") # csv file content id,longitude,latitude

api_key <- "YOUR_API_KEY"
# only 5000 requests per day
#locations <- locations[1:5001,]
source('./R/getScoreJson.R')
for( i in seq(1,dim(locations)[1],1))
{
  if(i%%500==0)
    print(paste0("Retrieved scores for ", i, " locations"))
  walkscore <- getScoreJson("",locations$latitude[i],locations$longitude[i],api_key)
  write.table(t(paste(c(locations$id[i],walkscore))),file="./data/scores.csv", sep = ",", append = TRUE, quote = FALSE,
              col.names = FALSE, row.names = FALSE)
}
