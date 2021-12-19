dados <- read.csv("~/Documentos/Metodos-Empiricos-R/Tabela16.6.csv")
lm <- lm(dados$volume~dados$tempo)
plot(dados$volume~dados$tempo) #Questao a
abline(lm)

anova <- summary(aov(dados$volume~dados$tempo))[[1]] #Questa C

S2E <- anova[2,3] #Questa D

