dados <- read.csv("~/Documentos/Metodos-Empiricos-R/Tabela15.1.csv")
relacao <- dados$Y ~ dados$X
lm <- lm(relacao)
plot(relacao)
abline(lm)
coefientes <- lm$coefficients
alfa <- coefientes[1]
beta <- coefientes[2]