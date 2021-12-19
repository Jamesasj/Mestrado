dados <- read.csv("~/Documentos/Metodos-Empiricos-R/Tabela16.3.csv")
relacao <- dados$Potencia~dados$Temperatura
lm <- lm(relacao)
plot(relacao)
abline(lm)
anova <- summary(aov(relacao))[[1]] 