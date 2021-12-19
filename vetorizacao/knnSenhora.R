
insereNomeColuna = function(x){
  names(x)[1:19] <- c("feature", "tipo", "ini", "cap", "simb", "prevW",
                      "prevT", "prevCap", "nextW", "nextT", "nextCap", 
                      "prev2W", "prev2T", "prev2Cap", "next2W", "next2T", 
                      "next2Cap", "palpite", "target")   
  return(x)
}

limpaDados = function(x){
  x[["tipo"]] <- gsub("-", "", x[["tipo"]])
  x[["ini"]] <- gsub("ini=", "", x[["ini"]])
  x[["cap"]] <- gsub("cap=", "", x[["cap"]])
  x[["simb"]] <- gsub("simb=", "", x[["simb"]])
  x[["prevW"]] <- gsub("prevW=", "", x[["prevW"]])
  x[["prevT"]] <- gsub("prevT=", "", x[["prevT"]])
  x[["prevT"]] <- gsub("-", "", x[["prevT"]])
  x[["prevCap"]] <- gsub("prevCap=", "", x[["prevCap"]])
  x[["nextW"]] <- gsub("nextW=", "", x[["nextW"]])
  x[["nextT"]] <- gsub("nextT=", "", x[["nextT"]])
  x[["nextT"]] <- gsub("-", "", x[["nextT"]])
  x[["nextCap"]] <- gsub("nextCap=", "", x[["nextCap"]])
  x[["prev2W"]] <- gsub("prev2W=", "", x[["prev2W"]])
  x[["prev2T"]] <- gsub("prev2T=", "", x[["prev2T"]])
  x[["prev2T"]] <- gsub("-", "", x[["prev2T"]])
  x[["prev2Cap"]] <- gsub("prev2Cap=", "", x[["prev2Cap"]])
  x[["next2W"]] <- gsub("next2W=", "", x[["next2W"]])
  x[["next2T"]] <- gsub("next2T=", "", x[["next2T"]])
  x[["next2T"]] <- gsub("-", "", x[["next2T"]])
  x[["next2Cap"]] <- gsub("next2Cap=", "", x[["next2Cap"]])
  x[["palpite"]] <- gsub("palpite=", "", x[["palpite"]])
  x[["palpite"]] <- gsub("I_", "", x[["palpite"]])
  x[["target"]] <- gsub("I_", "", x[["target"]])    
  
  return(x)
}


senhora <- read.csv("TreinoPVetorizarSenhora.csv", sep=" ",stringsAsFactors = T, header = F)
#str(senhora)
#head(senhora)

senhoraF <- senhora
senhoraF <- insereNomeColuna(senhoraF)
senhoraF <- limpaDados(senhoraF)

senhora.fac <- factor(unlist(senhoraF))
dict <- levels(senhora.fac)
senhora.mat <- senhoraF

for (ind in 1:ncol(senhoraF)) {
  senhora.mat[,ind] <- factor(senhoraF[,ind], levels = dict)
  senhora.mat[,ind] <- as.integer(senhora.mat[,ind])
}

write.table(senhora.mat, file="senhoraVet.csv", row.names=FALSE, col.names=FALSE, sep=",")
#senhora.mat[,1] 

