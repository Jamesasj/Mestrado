dados <- read.csv("arquivo.csv", sep=" ", header = F)
dados$V1 <- NULL

modelo <- lm(data = dados , formula = V3 ~ V2)

save(modelo, file = "MODELO")
