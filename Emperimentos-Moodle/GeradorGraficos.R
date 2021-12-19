args <- commandArgs()
origem = args[7]
destino = args[9]
dados <- read.csv(origem, header=FALSE)
dados[2]<-NULL
dados$V5 <- paste(dados$V1-1, dados$V3)
dados$V6 <- paste(dados$V1, dados$V3)
dados$V7 <- dados$V4[match(dados$V5, dados$V6)]
dados$V8 <- dados$V4 - dados$V7
jpeg(destino)
plot(dados$V1,dados$V8, xlab = "Rodadas", ylab = "Quantidade de Linhas", col = ifelse(dados$V8>0,"red", "black"))
dev.off()