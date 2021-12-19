#!/bin/bash
# Experimento 3
:'
a) Criar uma nova atividade
b) Responder nova atividade
c) Criar um backup do banco de dados

d) Executar download do plugin
e) Realizar consulta sql e guardar resultados no csv 
f) Criar backup do arquivo notas treino

e) Realizar consulta sql e guardar resultados no csv 
x) Restaurar backup
d) Executar download do plugin
y) Restaurar notas treino
g) Executar upload de notas

h) Realizar consulta sql e guardar resultados no csv 
i) executa download do plugin 
j) executa upload pelo plugin 
k) retorna ao passo h)

l) Restaurar backup
m) executa passo d)
n) Restaurar notas treino
o) executa passo g) 12674
h)retorna ao passo h)
'

nome_arquivo_tabela="exportado100.csv";
nome_arquivo_sessao="sessao100.csv";
nome_grafico="exportado100.jpg";

rm $nome_arquivo_tabela;
rm $nome_arquivo_sessao;
rm $nome_grafico;

mysql --user=root --password=James@123 moodle < moodle.sql &&
php coletor/Extrator.php -l 0 $nome_arquivo_tabela $nome_arquivo_sessao &&
php download.php -d ./arquivos/ --conf teste.conf && 
cp arquivos/"Cursos para teste do plugin-experimento3-9"/notastreino0.csv arquivos/"Cursos para teste do plugin-experimento3-9"/notastreino.csv &&
php upload.php -d ./arquivos/ --conf teste.conf

for x in {1..99}
do
    echo "Inicio da execução numero $x" &&
    php coletor/Extrator.php -l $x $nome_arquivo_tabela $nome_arquivo_sessao &&
    php download.php -d ./arquivos/ --conf teste.conf &&
    php upload.php -d ./arquivos/ --conf teste.conf &&
    echo "Fim da execução numero $x";
done
Rscript GeradorGraficos.R --origem $nome_arquivo_tabela --destino $nome_grafico

max_rodada=100;

for y in {1..2}
do
    max_rodada=$(($max_rodada+100))
    nome_arquivo_tabela="exportado$max_rodada.csv"
    nome_arquivo_sessao="sessao$max_rodada.csv"
    nome_grafico="exportado$max_rodada.jpg"

    rm $nome_arquivo_tabela;
    rm $nome_arquivo_sessao;
    rm $nome_grafico;

    mysql --user=root --password=James@123 moodle < moodle.sql &&
    php coletor/Extrator.php -l 0 $nome_arquivo_tabela $nome_arquivo_sessao &&
    php download.php -d ./arquivos/ --conf teste.conf && 
    cp arquivos/"Cursos para teste do plugin-experimento3-9"/notastreino0.csv arquivos/"Cursos para teste do plugin-experimento3-9"/notastreino.csv &&
    php upload.php -d ./arquivos/ --conf teste.conf &&

    for x in $(eval echo "{1..$max_rodada}")
    do
        echo "Inicio da execução numero $x" &&
        php coletor/Extrator.php -l $x $nome_arquivo_tabela $nome_arquivo_sessao &&
        php download.php -d ./arquivos/ --conf teste.conf &&
        php upload.php -d ./arquivos/ --conf teste.conf &&
        echo "Fim da execução numero $x";
    done

    Rscript GeradorGraficos.R --origem $nome_arquivo_tabela --destino $nome_grafico
done