dados <- read.csv("~/Documentos/Metodos-Empiricos-R/Tabela16.3.csv")
relacao <- dados$Temperatura ~ dados$Potencia
lm <- lm(relacao)
anova <- aov(relacao)
SQRes <- sum(anova$residuals^2)
plot(relacao, pch=20, xlab="Temperatura", ylab="Potencia", col="darkblue")
abline(lm, lwd=2, col="red")