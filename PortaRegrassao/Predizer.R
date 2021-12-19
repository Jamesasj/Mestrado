arg <- commandArgs()
param.valor <- as.numeric(arg[6])

load("MODELO")

ds.test <- data.frame(V2 = param.valor)

predito <- as.numeric(predict(modelo, ds.test))

cat(predito)
