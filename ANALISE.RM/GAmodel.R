library(genalg)
library(dplyr)
data("iris")
features <- iris[,1:ncol(iris)-1]
label <- as.numeric(iris[,ncol(iris)])

funcao_avaliacao <- function(colunas){
  if (sum(colunas) == 0) return(1000)
  if (sum(colunas) > 1) {
    teste <- features[,colunas == 1]
    tx_formula = paste(colnames(features)[colunas==1] , collapse = "+")
  }else{
    teste <- data_frame(features[,colunas == 1])
    tx_formula = colnames(features)[colunas==1]
  }
  
  tx_formula = paste("label", tx_formula, sep = "~")
  fr <- formula(tx_formula)
  
  teste$label <- label
  
  if (sum(colunas) == 1) {
    colnames(teste) <- c(colnames(features)[colunas==1],"label")
  }
  
  model <- lm(fr, data = teste)
  anv <- anova(model)
  erro <- sum(anv$`Sum Sq`)-anv$`Sum Sq`[length(anv$`Sum Sq`)]
  return(erro)
}

GAmodel <- rbga.bin(size = ncol(features), 
                    popSize = 10, 
                    iters = 100, 
                    mutationChance = 0.01, 
                    elitism = T, 
                    evalFunc = funcao_avaliacao)

fun2 <- function(pesos){
  teste <- features
  teste <-as.data.frame(teste ** pesos)
  teste$label <- label
  tx_formula = paste(colnames(teste), collapse = "+")
  tx_formula = paste("label", tx_formula, sep = "~")
  fr <- formula(tx_formula)
  model <- lm(fr, data = teste)
  anv <- anova(model)
  erro <- sum(anv$`Sum Sq`)-anv$`Sum Sq`[length(anv$`Sum Sq`)]
  return(erro)
}

res <- rbga(c(0,0,0,0), c(100,100,100,100), popSize = 100, iters = 50 , mutationChance =  0.01, evalFunc = fun2)
plot(res)
plot(GAmodel)
