library(dplyr)
library(tidytext)
library(janeaustenr)
library(stringr)
library(ggplot2)

texto <- c("É um fato conhecido de todos que um leitor",
           "se distrairá com o conteúdo de texto legível",
           "de uma página quando estiver examinando sua diagramação.",
           "A vantagem de usar Lorem Ipsum é que ele tem uma distribuição")
texto
tx_df <- data_frame(line = 1:4, text = texto)
tx_df
tx_df %>%
  unnest_tokens(word, text)

livro_orignal <- austen_books() %>%
  group_by(book) %>%
  mutate(linha = row_number(),
         capitulo = cumsum(str_detect(text, regex("^CHAPTER [\\divxlc]", 
                                                  ignore_case = TRUE)))) %>%
  ungroup()

livro_orignal

livro_tidy <- livro_orignal %>%
  unnest_tokens(word, text)

livro_tidy
# dados de palavras paradas
data("stop_words")

# remover palavras
livro_tidy <- livro_tidy %>%
  anti_join(stop_words)

# contagem de paravras
livro_tidy %>%
  count(word, sort = TRUE)%>%
  filter(n > 600)%>%
  mutate(word = reorder(word, n))%>%
  ggplot(aes(word, n)) + 
           geom_col() +
           xlab(NULL) +
           coord_flip()

  
library(gutenbergr)

livros_hg <- gutenberg_download(c(35,36,5230, 159))
tidy_hg <- livros_hg %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

tidy_hg %>%
  count(word, sort = TRUE)

livros_bro <- gutenberg_download(c(1260,768,969,91,82, 767))
tidy_bro <- livros_bro %>%
  unnest_tokens(word, text)%>%
  anti_join(stop_words)

tidy_bro%>%
  count(word, sort = TRUE)

library(tidyr)
frequencia <- bind_rows(mutate(tidy_bro, author = "Bronte Sisters"),
                        mutate(tidy_hg,  author = "H.G. Hells"),
                        mutate(livro_tidy, author ="Jane Austen")) %>%
  mutate(word = str_extract(word, "[a-z']+")) %>%
  count(author, word) %>%
  group_by(author) %>%
  mutate(proportion = n/sum(n)) %>%
  select(-n) %>%
  spread(author, proportion) %>%
  gather(author, proportion,"Bronte Sisters":"H.G. Hells" )

library(scales)
ggplot(frequencia, aes(x= proportion, y = `Jane Austen`, 
                       color = abs(`Jane Austen` - proportion)))+
  geom_abline(color = "gray40", lty = 2)+
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3)+
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5)+
  scale_x_log10(labels = percent_format())+
  scale_y_log10(labels = percent_format())+
  scale_color_gradient(limits = c(0,0.001), 
                       low = "darkslategray4",high = "gray75")+
  facet_wrap(~author, ncol = 2)+
  theme(legend.position = "none")+
  labs(y="Jane Austen", x= NULL)