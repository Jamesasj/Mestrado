library(ggplot2)
library(dplyr)
library(KappaGUI)

setwd("C:\\PROJETOS\\avaliacao_pares_professor")
lista_doc <- c("professor1.csv", "professor2.csv", "professor3.csv")

jpeg("01_GERAL.jpg")
plot <- ggplot()
for (documento in lista_doc) {
  cor1 <- sample(1:100,1)
  dados <- read.csv(documento,sep = ";")
  varl <- data_frame(x = dados[,7])
  scala <- data.frame(x =c(0:1000,100))
  plot <- plot + 
    stat_function(data = varl, aes(x = scala),fun = dnorm, args = list(mean(varl$x), sd(varl$x)), colour = cor1) +
    geom_vline(xintercept = mean(varl$x), colour = cor1,  linetype = "dashed")
}
plot
dev.off()


jpeg("01_GERAL.jpg")
plot <- ggplot()
for (documento in lista_doc) {
  cor1 <- sample(1:100,1)
  dados <- read.csv(documento,sep = ";")
  varl <- data_frame(x = dados[,7])
  scala <- data.frame(x =c(0:1000,100))
  plot <- plot + 
    stat_function(data = varl, aes(x = scala),fun = dnorm, args = list(mean(varl$x), sd(varl$x)), colour = cor1) +
    geom_vline(xintercept = mean(varl$x), colour = cor1,  linetype = "dashed")
}
plot
dev.off()



##### Analise cohen kappa #######
dados1 <- read.csv("professor1.csv", sep = ";")
dados2 <- read.csv("professor2.csv", sep = ";")

dadosC <- data.frame(professor1 = as.character(), professor2 =as.character(), nota = as.character(), kappa=as.numeric())

for (n in 2:7) {
  scores <- data.frame(
    Professor1_N = dados1[,n],
    Professor2_N = dados2[,n]
  )
  res <- kappaCohen(scores, weight="squared")
  registro <- data.frame(professor1 = 1, professor2 = 2, nota = n, kappa = res$Kappa)
  dadosC <- rbind(dadosC, registro)
}


