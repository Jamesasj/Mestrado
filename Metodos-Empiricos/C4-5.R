dados <- read.csv("~/Documentos/Metodos-Empiricos-R/Tabela15.1.csv")
ANOVA <- aov(dados$Y~dados$X, data =  dados)
sANOVA <- summary(ANOVA)[[1]]
S2 <- sANOVA [2,3]