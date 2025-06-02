req <- request("https://r-project.org")
resp <- req_perform(req)

install.packages("httr")
library(httr)
r <- GET("https://google.com")

