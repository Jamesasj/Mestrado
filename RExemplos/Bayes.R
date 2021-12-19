library(e1071)
jogar_tenis <- read.csv("~/MESTRADO/jogar_tenis.csv", sep=";")

modelo = naiveBayes(jogar_tenis[1:4],jogar_tenis[,5])
class(modelo)
summary(modelo)
print(modelo)

novo_registro <- data.frame(Aparencia = "ensolarado", temperatura = "quente", umidade = "alta", vento = "fraco")

predicao <- predict(modelo, novo_registro, type = "class")
print(predicao)