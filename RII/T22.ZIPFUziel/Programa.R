library(SnowballC)
library(lsa)
library(textreadr)
library(tm)
library(dplyr)
library(tidytext)
library(tidyr)

#setwd("c://Users/james/PROJETOS/RII/T25.ZIPFAtribuna/")

tempDire = tempfile()
dir.create(tempDire)

tempDire.data.tar <- paste(tempDire,"dadosbaixados.tar.gz", sep = "/" )
download.file("http://www.inf.ufes.br/???elias/dataSets/aTribuna-21dir.tar.gz", destfile = tempDire.data.tar)

untar(tempDire.data.tar, exdir= tempDire)

lista.files <- list.files(tempDire, all.files=T, full.names = T, include.dirs = T, 
                    recursive = T, pattern = "txt")

lista.files.names <- list.files(tempDire, all.files=T, full.names = F, include.dirs = F, 
                          recursive = T, pattern = "txt")

write.table(lista.files.names, "saida.txt",row.names = F, col.names = F)

data.corpus <- VCorpus(DirSource(tempDire, recursive = T, pattern = "txt"))

dados.td.all <- tidy(data.corpus)
rm(data.corpus)

dados.td <- sample_frac(dados.td.all, .025)

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

rm(dados.td, dados.matrix, dados.token, linha, lista.files, 
   lista.files.names, tempDire, tempDire.data.tar)

rm(tempDire)
save(dados.td.all, file = "data.Rdata")
