#setwd("/home/james/Documents/RII/T12.SALTON")
dataset.link <- "https://inf.ufes.br/~elias/dataSets/aTribuna-21dir.tar.gz"
folders.raiz <- getwd()

download.file(dataset.link, "dataset.tar.gz")
untar("dataset.tar.gz", exdir = file.path(folders.raiz, "output"))
arquivos.lista <- list.files("output", ".txt", recursive = T, full.names = T)
arquivos.amostra <- data.frame(arquivos = sample(arquivos.lista, 200))
write.table(arquivos.amostra, "indice.dat", quote = F,row.names =  F, col.names = F)
system("aLine -i -l indice.dat -d output2")
system("aLine --convert -d output2")

dados.features <-read.csv("output2/features.mtx", sep = " ", header = F)
dados.features <- dados.features[3:nrow(dados.features),]
