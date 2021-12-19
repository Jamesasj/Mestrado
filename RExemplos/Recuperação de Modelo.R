setwd("C://Users/james/PROJETOS/RExemplos/")
library(dplyr)
library(tidytext)
library(tidyr)
library(stringr)
library(e1071)

load(file = "modeloBayes.RData")

infe <- data.frame(word1 = "Peito", word2 = "a")

res <- predict(modelo, infe, type = "class")

print(as.character(res))