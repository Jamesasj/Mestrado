nm_saida <- "/home/james/Documentos/Metodos-Empiricos-R/saida.csv"
dados <- read.csv("~/Documentos/Metodos-Empiricos-R/Tabela15.1.csv")
regressao <- lm(dados$Y ~ dados$X)
alfa <- regressao$coefficients['(Intercept)']
beta <- regressao$coefficients['dados$X']
plot(dados$Y ~ dados$X)
saida <- paste(alfa, beta, sep = ";")
cat("alfa;beta", saida, file= nm_saida, sep="\n")
