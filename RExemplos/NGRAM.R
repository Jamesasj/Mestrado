library(dplyr)
library(tidytext)
library(tidyr)
library(stringr)
library(ggplot2)

texto <- c("Há um fato conhecido de todos que um leitor leitor leitor leitor",
           "se distrairá com o conteúdo de texto legível",
           "de uma página quando estiver examinando sua diagramação.",
           "A vantagem de usar Lorem Ipsum é que ele tem uma distribuição")

dados.full <- data_frame(line = 1:4, text = texto)

dados.words <- dados.full %>% unnest_tokens(word, text)

dados.words.summ <- dados.words %>% count(word, sort = TRUE)

dados.words.summ$total <- sum(dados.words.summ$n)

dados.words.summ <- dados.words.summ %>% mutate(tr = n/total)

dados.bigram <- dados.full %>% unnest_tokens(bigram, text, token = "ngrams", n = 2)

dados.bigram.summ <- dados.bigram %>% count(bigram, sort = TRUE)

dados.bigram.summ <- dados.bigram.summ %>% separate(bigram, c("word1","word2"), sep = " ")
