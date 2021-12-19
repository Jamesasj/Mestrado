# X - idade Y - aluguel

dados <- read.csv("~/Documentos/Metodos-Empiricos-R/Tabela16.2.csv")
lm <- lm(dados$y~dados$x)
plot(dados$y~dados$x)
abline(lm)
anova <- summary(aov(dados$y~dados$x))[[1]] 