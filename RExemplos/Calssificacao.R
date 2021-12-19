  normal <- function(x, media, desvio) {
    res <- pnorm(x, media, desvio)
    if((res < 0.05) | res >(0.95)){
      return(0)  
    }else{
      return(res)
    }
  }
  
  classificador <- function(x){
    treina <- read.csv("C:/PROJETOS/RExemplos/treina.csv", sep=";")
    
    titu <- treina[treina$label == "T",]
    sdT <- sd(titu$total)
    mT  <- mean(titu$total)
    
    intr <- treina[treina$label == "I",]
    dese <- treina[treina$label == "D",]
    conc <- treina[treina$label == "C",]
    nac <- treina[treina$label == "NAS",]
    
    
    sdT <- sd(titu$total)
    mT  <- mean(titu$total)
    
    sdI <- sd(intr$total)
    mI  <- mean(intr$total)
    
    sdD <- sd(dese$total)
    mD  <- mean(dese$total)
    
    sdC <- sd(conc$total)
    mC  <- mean(conc$total)
    
    sdN <- sd(nac$total)
    mN  <- mean(nac$total)
    
    cT <- normal(x, mT, sdT)
    cI <- normal(x, mI, sdI)
    cD <- normal(x, mD, sdD)
    cC <- normal(x, mC, sdC)
    cN <- normal(x, mN, sdN)
    
    probab = c(cT, cI, cD, cC, cN)
    maior <- max(probab)
    if (maior == 0){
      return("NA")
    }
    if (maior == cT){
      return("T")
    }
    if (maior == cI){
      return("I")
    }
    if (maior == cD){
      return("D")
    }
    if (maior == cC){
      return("C")
    }
    return("NA")
  }
  h <- classificador(7)
  
