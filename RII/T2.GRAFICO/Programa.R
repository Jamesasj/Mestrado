#setwd("C:\\Users\\james\\PROJETOS\\RII\\T2.GRAFICO")
file.folder.mainDir = getwd()

file.name <- "https://inf.ufes.br/~elias/dataSets/basic-datasets.tar.gz"
file.name2 <- "dataset.tar.gz"
file.name.output <- "indice.dat"
file.folder.output <- "output"
file.folder.output2 <- "resultado"

dir.create(file.path(file.folder.mainDir, file.folder.output), showWarnings = FALSE)

download.file(file.name, destfile =  file.name2)
untar(file.name2, exdir = file.path(file.folder.mainDir, file.folder.output))

file.list <- data.frame(arquivos = list.files(file.folder.output, full.names = TRUE))
write.table(file.list, file.name.output, quote = FALSE, row.names = FALSE, col.names = FALSE)

# executa o aLine
system(paste("aLine -i -l indice.dat -d", file.folder.output2))
system(paste("aLine --convert -d", file.folder.output2))
system("aLine ine --similarity --features resultado/cache.txt -o resultado2") #calculo da similaridade

library(tidyr)
library(scatterplot3d)

dados.feature <- read.csv("resultado/features.mtx", sep = " ", header = FALSE)
dados.dim <- dados.feature[2,] #obtem as diment��es da tabela
dados.feature <- dados.feature[3:nrow(dados.feature),] # remove dados espurios
colnames(dados.feature) <- c("documento","feature","qtd") # renomeia campos da tabela

dados.feature.matrix <- spread(dados.feature, feature, qtd) # realiza tranformacao dos dados
dados.feature.matrix[is.na(dados.feature.matrix)] <- 0 # substitui vazios por 0

# Exporta o gr�fico
jpeg("saida.jpg", quality = 100)
scatterplot3d(dados.feature.matrix[2:4], pch=19, cex.symbols = 2, type = "p", color = dados.feature.matrix[1] , highlight.3d=TRUE, col.axis="blue", col.grid="lightblue")
dev.off()

dados.medias.row <- rowMeans(dados.feature.matrix[2:ncol(dados.feature.matrix)]) 
write.table(dados.medias.row, "row-mean.dat", quote = FALSE, row.names = FALSE, col.names = FALSE)

dados.medias.col <- colMeans(dados.feature.matrix[2:ncol(dados.feature.matrix)]) 
write.table(t(dados.medias.col), "column-mean.dat", quote = FALSE, row.names = FALSE, col.names = FALSE)

dados.corr <- read.csv("resultado2", sep = " ", header = TRUE)[1:3]
dados.corr <- dados.corr[2:nrow(dados.corr),]
colnames(dados.corr ) <- c("doc1","doc2","cor")
dados.corr <- spread(dados.corr, doc2,cor)

dados.corr$doc1 <- NULL
matriz <- as.matrix(dados.corr)

library(corrplot)
jpeg("correlacao.jpg", quality = 100)
corrplot.mixed(matriz, lower.col = "black", number.cex =.5 , upper = "color", tl.cex =.8)
dev.off()

# Apaga tudo
#unlink(file.folder.output, recursive = TRUE)
#unlink(file.folder.output2, recursive = TRUE)
#unlink(file.name2)
#unlink(file.name.output)
