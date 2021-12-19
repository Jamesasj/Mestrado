setwd("/home/james/Documents/RII/")
library(dplyr)
library(tidytext)
library(tidyr)
library(stringr)
library(e1071)

texto <- scan("texto1.txt", what="char", sep="\n", encoding = "UTF-8")
dados.full <- data_frame(text = texto)
dados.bigram <- dados.full %>% unnest_tokens(tregram, text, token = "ngrams", n = 3)
dados.bigram.summ <- dados.bigram %>% separate(tregram, c("word1","word2","word3"), sep = " ")
modelo <- naiveBayes(as.factor(word3) ~ ., data = dados.bigram.summ)

infe <- data.frame(word1 = "Peito", word2 = "a")

res <- predict(modelo, infe, type = "class")

print(as.character(res))