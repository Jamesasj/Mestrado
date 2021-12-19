setwd(dir = "/home/james/Documents/data smart/")
library(skmeans) 
library(cluster)
library(dplyr) 

kmcDF <- read.csv("dados_sem_trat.csv") # lê como DataFrame
wineDF <- t(kmcDF[,-c(1,2,3,4,5,6,7)]) # nova variável DataFrame crica, remove colunas de 1-7, e faz a transposição do DataFrame
wineDF[is.na(wineDF)] <- 0 # substitui os valores NA por Zeros 
wineMatrix <-as.matrix(wineDF) # converte de DataFrame para Matriz

partition <- skmeans(wineMatrix, 5) # com 5 clusters

#Gráfico silhouette para 5
silhouette_k5 <- silhouette(partition)
plot(silhouette_k5)

#silhouette para 4
partition_k4 <- skmeans(wineMatrix, 4)
silhouette_k4 <- silhouette(partition_k4)
plot(silhouette_k4) 

# segmenta os dados
cluster_1 <- names(partition$cluster[partition$cluster == 1])
cluster_2 <- names(partition$cluster[partition$cluster == 2])
cluster_3 <- names(partition$cluster[partition$cluster == 3])
cluster_4 <- names(partition$cluster[partition$cluster == 4])
cluster_5 <- names(partition$cluster[partition$cluster == 5])

