#install.packages("tidytext")
#install.packages("dplyr")
#install.packages("tidyr")
#install.packages("tm")

library(tidyr)
library(dplyr)
library(tidytext)

setwd("/home/james/Documents/data smart")
criar_dicionario <- function(dataset){
  dataset.df <- data_frame(documento = 1:length(dataset$Tweet), texto = dataset$Tweet)
  dataset.tokens <- dataset.df %>% unnest_tokens(palavra, texto)
  dataset.dic <- dataset.tokens %>% count(documento, palavra, sort = TRUE)
  dataset.dic$probabilidade <- dataset.dic$n/sum(dataset.dic$n)
  return(dataset.dic)
}

peso_out_dataset <- .00005
calcular_score <- function(dataset, dicionario){
  score = 0
  palavras_in_dataset <- intersect(dicionario$palavra, dataset$palavra)
  palavras_out_dataset <- setdiff(dataset$palavra, palavras_in_dataset)
  score <- score + length(palavras_out_dataset) * log(peso_out_dataset)
  probabilidades <- dicionario$probabilidade[match(palavras_in_dataset, dicionario$palavra)]
  score <- score + sum(log(probabilidades))
  return(score)
}

dados.mandril <- read.csv('cap3_relacionados.csv', header = TRUE, sep = ";" )
dados.nao_mandril  <-  read.csv('cap3_nao_relacionados.csv', header = TRUE, sep = ";" )
dados.teste <- read.csv('Cap3_teste.csv', header = TRUE, sep = ";" )

dados.mandril$Tweet  <- as.character(dados.mandril$Tweet)
dados.nao_mandril$Tweet <- as.character(dados.nao_mandril$Tweet)
dados.teste$Tweet <- as.character(dados.teste$Tweet)

dados.dic.mandril <- criar_dicionario(dados.mandril)
dados.dic.nao_mandril <- criar_dicionario(dados.nao_mandril)

dados.df.teste <- data_frame(documento = dados.teste$Number, texto = dados.teste$Tweet)
dados.tokens.teste <- dados.df.teste %>% unnest_tokens(palavra, texto)

score <- matrix(ncol = 3, nrow = 0, dimnames = list( c(),c("mandril","nao_mandril","Classificacao")))

for(i in 1:length(dados.df.teste$documento)){
  palavras <- dados.tokens.teste %>% filter(documento == i)
  app <- calcular_score(palavras, dados.dic.mandril)
  nao_app <- calcular_score(palavras, dados.dic.nao_mandril)
  classi <- ifelse(app > nao_app, "App", "Other")
  aux <- cbind(app ,nao_app, classi)
  score <- rbind(score, aux)
}

result <- cbind(dados.teste, score)

