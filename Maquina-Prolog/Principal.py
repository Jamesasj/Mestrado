



def nome(arquivo):
    config = ConfigController(arquivo)
    prolog = PrologController()
    notas_treino = NotasTreinoController(config.obterDiretorio)
    
    while(notas_treino.proximo()):
        aluno = notas_treino.aluno()
        arquivo = aluno[3]
        resultado = prolog.executar(arquivo)
        aluno[4] = resultado

    notas_treino.atualizar(lAlunos)