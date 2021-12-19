#setwd("C:/Users/james/PROJETOS/RII/S5.LSI/")
library(SnowballC)
library(lsa)

write( c("Secretaria exemplo"), file="Documents/busca.txt")

txt <- list.files()

dados.matrix = textmatrix( txt[1], minWordLength = 1)

dados.matrix.lsa <- lw_bintf(dados.matrix) * gw_idf(dados.matrix)

dados.lsa <- lsa( dados.matrix.lsa , dims = dimcalc_share())

dados.dist.matrix <- as.textmatrix(dados.lsa)
                                   
dist.mat.lsa <- dist(t(dados.matrix))

cor(dados.dist.matrix)

teste <- query("computer information", rownames(dados.matrix))

