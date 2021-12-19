#!/bin/bash
rm exportado.csv;
rm sessao.csv;

# Experimento 1
# consite em fazer download e upload do plugin apenas com as atividades
# existentes.
for x in {0..10}
do
    echo "Inicio da execução numero $x" &&
    php coletor/Extrator.php -l 0 $x &&
    php download.php -d ./arquivos/ --conf teste.conf &&
    php upload.php -d ./arquivos/ --conf teste.conf &&
    echo "Fim da execução numero $x";
done
