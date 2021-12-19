dados <- read.csv("~/Documentos/Metodos-Empiricos-R/Tabela16.2.csv")
relacao <- dados$y ~ dados$x
lm <- lm(relacao)
anova <- aov(relacao)
SQRes <- sum(anova$residuals^2)
plot(relacao, pch=20, xlab="Idade(x)", ylab="Estímulo(y)", col="darkblue")
abline(lm, lwd=2, col="red")
c_linear <- anova$coefficients[1] # indica o valor do aluguel de uma casa nova
c_angular <- anova$coefficients[2] # coeficente angular indica declive no aluguel para casas mais velhas