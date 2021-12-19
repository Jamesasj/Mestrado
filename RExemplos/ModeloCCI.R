#install.packages('psych')
library(psych)

sf <- matrix(c(
  9,    2,   5,    8,
  6,    1,   3,    2,
  8,    4,   6,    8,
  7,    1,   2,    6,
  10,   5,   6,    9,
  6,   2,   4,    7),ncol=4,byrow=TRUE)

colnames(sf) <- paste("J",1:4,sep="")
rownames(sf) <- paste("S",1:6,sep="")

View(sf)  #example from Shrout and Fleiss (1979)
result <- ICC(sf,lmer=FALSE)  #just use the aov procedure

View(result$summary)
View(result)

