library(tidyr)
library(corrplot)
setwd("C:/PROJETOS/RExemplos")
notas <- read.csv("notas.csv", sep=";")
matrix <- spread(notas, avaliador, valor)

notasP<- read.csv("notas_prof.csv", sep=";")

matrix$avaliado<-NULL
prof <- notasP$valor
matrix <- cbind(prof, matrix)

metodos <- c("pearson", "kendall", "spearman")

for (metodo in metodos) {
  jpeg(paste(metodo,".jpg"))
  correlacionado <- cor(matrix, method = metodo)
  correlacionado[is.na(correlacionado)] <- 0
  corrplot.mixed(correlacionado, lower.col = "black", number.cex = .6)
  corrplot(correlacionado)
  dev.off()
}

metodos <- c("euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski")
tM <- t(matrix)
for (metodo in metodos) {
  print(metodo)
  print(dist(tM, method = metodo))
}
dM <- dist(tM)