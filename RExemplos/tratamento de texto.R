arquivo <- "/var/www/html/Marcador/Util/teste.txt"
texto <- scan(arquivo, what="char", sep="\n", encoding = "UTF-8")
lTexto <- strsplit(texto, "\\W+")
linha1 <- lTexto[1]
total = length(linha1[[1]])
linha2 <- lTexto[2]
total2 <-  length(linha2[[1]])

linha3<-  c("texte1",1, total, "NA")

temp1 <- read.csv("/home/james/Documentos/plugin_rii_textos/temp1.csv", sep=";")
temp1 <- rbind(temp1, linha3 )
palavras <- paste(temp1$Palavra, temp1$Frequencia, temp1$Rodada, sep=";")
cat("Palavra;Frequencia;Rodada; classi", palavras, file="/home/james/Documentos/plugin_rii_textos/temp1.csv", sep="\n") 

temp1 <- read.csv("/home/james/Documentos/plugin_rii_textos/temp1.csv", sep=";")
temp1 <- rbind(temp1, c("texte1",2, total2, "NA") )
palavras <- paste(temp1$Palavra, temp1$Frequencia, temp1$Rodada, sep=";")
cat("Palavra;Frequencia;Rodada", palavras, file="/home/james/Documentos/plugin_rii_textos/temp1.csv", sep="\n") 
