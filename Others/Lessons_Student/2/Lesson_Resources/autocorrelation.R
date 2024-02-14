# create vector1 with 8 time periods 
vector1=c(34,56,23,45,21,64,78,90) 

print(acf(vector1, pl=FALSE)) 

# calculate auto correlation with lag 0 
print(acf(vector1,lag=0, pl=FALSE)) 

# calculate auto correlation with lag 2 
print(acf(vector1,lag=2,pl=FALSE)) 

# calculate auto correlation with lag 6 
print(acf(vector1,lag=6,pl=FALSE)) 
