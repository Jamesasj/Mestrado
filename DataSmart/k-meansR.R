#install.packages("tibble", dependencies = TRUE)
#install.packages(c("Rcpp", "readr"))
#install.packages("fpc")
#Visualização da clusterização

library(cluster)
library(fpc)

setwd(dir = "/home/james/Documents/data smart/")
dados <- read.csv("dados_cap2_num.csv")
dados$Offer <- NULL #remove a coluna passada
dadosT <- t(dados) #realiza a transposição dos dados
k <-kmeans(dadosT, centers=4, iter.max = 500) #cria x clusters 
table(k$cluster) #conta os pontos de dados alocados em cada cluster
clus <- kmeans(dadosT, centers=4, iter.max = 500)
plotcluster(dadosT, clus$cluster)

