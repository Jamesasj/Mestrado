library(tm)
library(dplyr)

## Criação do corpus
my.corpus<- Corpus(DirSource("../TestesVetorizacao/HAREM/TestePVetorizar"))
print(my.corpus)


# Criando os nomes dos documentos para os testes
doc1<-content(my.corpus[[1]])
doc2<-content(my.corpus[[2]])
doc3<-content(my.corpus[[3]])
doc4<-content(my.corpus[[4]])
doc5<-content(my.corpus[[5]])
doc6<-content(my.corpus[[6]])
doc7<-content(my.corpus[[7]])
doc8<-content(my.corpus[[8]])
doc9<-content(my.corpus[[9]])
doc10<-content(my.corpus[[10]])
doc11<-content(my.corpus[[11]])
doc12<-content(my.corpus[[12]])
doc13<-content(my.corpus[[13]])

# Lista dos documentos
doc.list <- list(doc1, doc2, doc3, doc4, doc5, doc6, doc7, doc8, doc9, doc10, doc11, doc12, doc13)

N.docs <- length(doc.list)
names(doc.list) <- paste0("doc", c(1:N.docs))

# A query de busca
query <- "Igreja de Santa Cruz"

my.docs <- VectorSource(c(doc.list, query))
my.docs$Names <- c(names(doc.list), "query")
my.corpus <- Corpus(my.docs)
my.corpus

# Remove a pontuação
my.corpus <- tm_map(my.corpus, removePunctuation)

# Remove números, maíúsculas e espaços
my.corpus <- tm_map(my.corpus, removeNumbers)
my.corpus <- tm_map(my.corpus, content_transformer(tolower))
my.corpus <- tm_map(my.corpus, stripWhitespace)

# Cria a matriz de documentos
term.doc.matrix.stm <- TermDocumentMatrix(my.corpus)
colnames(term.doc.matrix.stm) <- c(names(doc.list), "query")
inspect(term.doc.matrix.stm[0:14, ])

# Compara o tamanho em bytes das matrizes
term.doc.matrix <- as.matrix(term.doc.matrix.stm)

cat("Dense matrix representation costs", object.size(term.doc.matrix), "bytes.\n", 
    "Simple triplet matrix representation costs", object.size(term.doc.matrix.stm), "bytes.")

# Ranking de palavras
most_frecuent_matrix <- addmargins(term.doc.matrix, margin = 2) 
most_frecuent_matrix <- most_frecuent_matrix[order(most_frecuent_matrix[,15], decreasing = TRUE),] 
most_frecuent_matrix_top50 <- head(most_frecuent_matrix[,c(1,15)], n = 50)
print(most_frecuent_matrix_top50)

# Criação do Vector Space Model
get.tf.idf.weights <- function(tf.vec) {
  # Calcula tfidf com base na frequência dos termos
  n.docs <- length(tf.vec)
  doc.frequency <- length(tf.vec[tf.vec > 0])
  weights <- rep(0, length(tf.vec))
  weights[tf.vec > 0] <- (1 + log2(tf.vec[tf.vec > 0])) * log2(n.docs/doc.frequency)
  return(weights)
}

tfidf.matrix <- t(apply(term.doc.matrix, 1, FUN = function(row) {get.tf.idf.weights(row)}))
colnames(tfidf.matrix) <- colnames(term.doc.matrix)
tfidf.matrix[0:3, ]

tfidf.matrix <- scale(tfidf.matrix, center = FALSE, scale = sqrt(colSums(tfidf.matrix^2)))
tfidf.matrix[0:3, ]

query.vector <- tfidf.matrix[, (N.docs + 1)]
tfidf.matrix <- tfidf.matrix[, 1:N.docs]

doc.scores <- t(query.vector) %*% tfidf.matrix

results.df <- data.frame(doc = names(doc.list), score = t(doc.scores), text = unlist(doc.list))
results.df <- results.df[order(results.df$score, decreasing = TRUE), ]

# Similaridade dos documentos em relação à query
results<- results.df[,c(1,2)]
print(results, row.names = FALSE, right = FALSE, digits = 2)
