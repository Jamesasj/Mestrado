library(dplyr)

dtfm <- read.csv("Tabela15.1.csv", sep= ",",header =  T, stringsAsFactors = T)
model <-  lm(formula = Y~X, dtfm)
data <- data.frame(X= c(20, 25, 30, 35, 40))
res <- predict(model, data)
anv<-anova(model)
plot(dtfm$X, dtfm$Y, ylab = "Estímulo(Y)", xlab = "Idade(Y)")
abline(model)

print(model$coefficients) #coerficente alfa e bata

print(model$residuals) #residous

print(anv$`Sum Sq`[2]) # soma do quadrado dos erros
print(anv$`Mean Sq`[2]) # Variancia residual 
print(sqrt(anv$`Mean Sq`[2]))
print(sqrt(anv$`Mean Sq`[2])*2)
print(res) #resultado predito
