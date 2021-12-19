library(tidyr)
library(dplyr)
library(corrplot)

setwd("/home/james/Documentos/Avaliacao_pares")
file_alunos <- "bases/mtpc-peer-03-174_consolidado.csv"
file_professor <- "bases/mtpc-peer-01-170_notastreinoShort.csv"
file_saida <- "pictures/"

notasA <- read.csv(file_alunos, sep=";")
notasP<- read.csv(file_professor, sep=";")
notasA$nota <- as.numeric(notasA$nota)
notasP$nota <- as.numeric(notasP$nota)
notasA <- notasA %>% filter(avaliado %in% notasP$avaliado) 
notasP <- notasP %>% filter(avaliado %in% notasA$avaliado) 

matrix_alunos <- spread(notasA, avaliador, nota)
matrix_alunos$avaliado <- NULL
matrix_aluno_professor <- cbind(notasP$nota, matrix_alunos)
matrix_alunos[is.na(matrix_alunos)] <- 0
matrix_aluno_professor[is.na(matrix_aluno_professor)] <- 0
write.csv(matrix_alunos, "matrix_alunos.csv")
write.csv(matrix_aluno_professor, "matrix_aluno_professor.csv")

matrix_correlacao_geral <- cor(matrix_aluno_professor)
matrix_correlacao_geral[is.na(matrix_correlacao_geral)] <- 0
write.csv(matrix_correlacao_geral, "matrix_correlacao_geral.csv")

matrix_correlacao_alunos <- cor(matrix_alunos)
matrix_alunos[is.na(matrix_alunos)] <- 0
write.csv(matrix_correlacao_alunos, "matrix_correlacao_alunos.csv")

t_matrix_aluno <- t(matrix_alunos)
write.csv(t_matrix_aluno, "i_matrix_aluno.csv")

t_matrix_geral <- t(matrix_aluno_professor)
write.csv(t_matrix_geral, "i_matrix_geral.csv")

v_correlacao_aluno_professor <- matrix_correlacao_geral[2:ncol(matrix_alunos)]

matriz_correlacao_geral_Ord <-matrix_correlacao_geral[order(-matrix_correlacao_geral[,1]), order(-matrix_correlacao_geral[,1])]

cluster_aluno <- kmeans(t_matrix_aluno, 4)

matrix_correlacao_alunos_O_pro <- cbind(v_correlacao_aluno_professor, t_matrix_aluno)
write.csv(matrix_correlacao_alunos_O_pro, "matrix_correlacao_alunos_O_pro.csv")

par(mfcol=c(1,2), mar=c(3,3,3,3))
corrplot(matriz_correlacao_geral_Ord, method = "color")

plot(t_matrix_aluno, col=cluster_aluno$cluster, pch = 19, cex = 1.5)
text(matrix_correlacao_alunos_O_pro[,1], row.names(matrix_correlacao_alunos_O_pro), cex = .5, pos = 4)
