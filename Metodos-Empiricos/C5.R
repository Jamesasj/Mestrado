dados     <- read.csv("~/Documentos/Metodos-Empiricos-R/BAEZA3.1.csv", header=TRUE, sep=";")
num_docs <- 4
dados$total <- rowSums(dados[2:5])
dados$TF <- 1 + log2(dados$total)

dados$documentos <- rowSums(dados[2:5] > 0)
dados$IDF <- log2(num_docs/dados$documentos)


dados$TFIDF <- dados$TF * dados$IDF 
dados <- dados[order(-dados$TF),]

par(mfrow=c(1,2)) 
# grafico a
plot(dados$TF , col = "blue", pch = 19, cex = 1, lty = "solid", lwd = 2)
points(dados$IDF, col = "red", pch = 23, cex = 1, lty = "solid", lwd = 2)

# grafico B
plot(dados$TFIDF,   col="blue", pch = 24, cex = 1, lty = "solid", lwd = 2)
