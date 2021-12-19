library(SnowballC)
library(lsa)
library(textreadr)

#setwd("c://Users/james/PROJETOS/RII/T22.ZIPFUziel/")

tempDire = tempfile()
dir.create(tempDire)

dir.create("output")
tempDire.data.tar <- paste(tempDire,"usielCarneiro.tar.gz", sep = "/" )
download.file("https://inf.ufes.br/~elias/dataSets/usielCarneiro.tar.gz", destfile = tempDire.data.tar)

untar(tempDire.data.tar, exdir= tempDire)

lista.files <- list.files(tempDire, all.files=T, full.names = T, include.dirs = T, 
                    recursive = T, pattern = "docx")

lista.files.names <- list.files(tempDire, all.files=T, full.names = F, include.dirs = F, 
                          recursive = T, pattern = "docx")

write.table(lista.files.names, "saida.txt",row.names = F, col.names = F)

for (ix in 1:length(lista.files)) {
  try({
    txt = read_docx(lista.files[ix])
    nomeArquivo = paste("output", paste(ix,".txt", sep = ""), sep = "/")
    write( txt, file=nomeArquivo)
  })
}

library(tm)
arquivos.convertidos <- list.files("output",  full.names = T)

data.corpus <- VCorpus(DirSource("output"))
matrix.dtm <- DocumentTermMatrix(matrix)

library(dplyr)
library(tidytext)
library(tidyr)

dados.td <- tidy(data.corpus)

dados.token <- dados.td %>% 
  unnest_tokens(word, text) %>% 
  count(id, word , sort = T) %>% 
  ungroup()

colnames(dados.token) <- c("documentos","tokens", "n")

dados.matrix <- spread(dados.token, documentos, n )
dados.matrix[is.na(dados.matrix)] <- 0
dados.matrix$total <- rowSums(dados.matrix[2:ncol(dados.matrix)] > 0 )
dados.matrix$TF <- 1 + log(dados.matrix$total)
dados.matrix <- dados.matrix[order(-dados.matrix$TF),]
dados.matrix$rank <- 1:nrow(dados.matrix)
linha <- lm(dados.matrix$TF ~ dados.matrix$rank)

jpeg("zipf_resulta.jpg")
plot(dados.matrix$TF ~ dados.matrix$rank , 
     ylab = "Frequencia em documentos (log2)",
     xlab = "Rank de Termos",
     col = "blue", pch = 19, cex = 1, lty = "solid", lwd = 2)
abline(linha, lwd = 2, col="red")
dev.off()