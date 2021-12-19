library(tidyr)
library(dplyr)
library(corrplot)

file_alunos <- "bases/notas.csv"
file_professor <- "bases/notas_prof.csv"

file_alunos <- "bases/logica-pnota-TT3-637_consolidado.csv"
file_professor <- "bases/logica-pnota-TT3-637_notastreinoShort.csv"

setwd("~/Documentos/Avaliacao_pares/")
file_saida <- "pictures/"
file_name <- "logica-pnota-TT1-636"

notasA <- read.csv(file_alunos, sep=";")
notasP<- read.csv(file_professor, sep=";")

notasA$nota <- as.numeric(notasA$nota)
notasP$nota <- as.numeric(notasP$nota)

notasA <- notasA %>% filter(avaliado %in% notasP$avaliado) 
notasP <- notasP %>% filter(avaliado %in% notasA$avaliado) 

matrix <- spread(notasA, avaliador, nota)
matrix$avaliado <- NULL

prof <- notasP$nota
matrix <- cbind(prof, matrix)
matrix[is.na(matrix)] <- 0
dados <- cor(matrix, method = "pearson")

dados[is.na(dados)] <- 0
dados <- dados[order(-dados[,1]), order(-dados[,1])]

corrplot.mixed(dados, upper = "color", lower.col = "black", number.cex = .3 ,tl.pos = "d", tl.cex = 0.5)

#corrplot(dados, method = "color")
