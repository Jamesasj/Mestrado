#!/bin/bash
rm exportado.csv;
rm sessao.csv;
#####começa pelo coletor...

# Experimento 2
:'
1 - Criar uma nova atividade no plugin e submeter uma resposta
2 - Fazer download
3 - dar nota e feedback
4 - fazer upload
5 - Rodar 100x
' 
php coletor/Extrator.php -l 0
php upload.php -d ./arquivos/ --conf teste.conf
for x in {1..10}
do
    echo "Inicio da execução numero $x" &&
    php coletor/Extrator.php -l $x &&
    php download.php -d ./arquivos/ --conf teste.conf &&
    php upload.php -d ./arquivos/ --conf teste.conf &&
    echo "Fim da execução numero $x";
done
