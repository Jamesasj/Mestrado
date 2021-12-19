args <- commandArgs()
n <- length(args)
for(i in 1:n){
  if(args[i] == "-t"){
    if(args[i] == "-a"){
      arquivo_aluno <- args[i+1]
    }else{
      if(args[i] == "-p"){
        file_professor <- args[i+1]
      }else{
        if(args[i] == "-d"){
          file_saida <- args[i+1]
        }
      }
    }
  }else{
    file_alunos <- "bases/notas.csv"
    file_professor <- "bases/notas_prof.csv"
    file_saida <- "~/Documentos/Avaliacao_pares/"
    setwd("~/Documentos/Avaliacao_pares/")
  }
}