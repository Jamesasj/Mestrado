texto <- scan("/var/log/apache2/error.log.1", what="char", sep="\n", encoding = "UTF-8")
texto <- tolower(texto)
lista_palavras <- strsplit(texto, "\\W+")
vetor_palavras <- unlist(lista_palavras)
frequencia_palavras <- table(vetor_palavras)
frequencia_ordenada_palavras <- sort(frequencia_palavras, decreasing=TRUE)
palavras <- paste(names(frequencia_ordenada_palavras), frequencia_ordenada_palavras, sep=";")
cat("Palavra;Frequencia", palavras, file="/home/james/Documentos/temp2.csv", sep="\n") 

temp2 <- read.csv("~/Documentos/temp2.csv", sep=";")
temp1 <- read.csv("~/Documentos/temp1.csv", sep=";")
temp2$Rodada <- 2

total <- rbind(temp1, temp2 )
palavras <- paste(temp1$Palavra, temp1$Frequencia, temp1$Rodada, sep=";")
cat("Palavra;Frequencia;Rodada", palavras, file="/home/james/Documentos/temp1.csv", sep="\n") 