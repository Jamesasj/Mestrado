#!/bin/bash
rm exportado.csv;
rm sessao.csv;

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
o) executa passo g)
h)retorna ao passo h)
'
for y in {0..1}
do
    mysql --user=root --password=James@123 moodle < moodle.sql &&
    php coletor/Extrator.php -l $(($y*100)) &&
    php download.php -d ./arquivos/ --conf teste.conf && 
    cp arquivos/Cursos para teste do plugin-experimento3-9/notastreinoO.csv arquivos/Cursos para teste do plugin-experimento3-9/notastreino.csv &&
    php upload.php -d ./arquivos/ --conf teste.conf


    aux = $(($y*100))

    for x in {1..99}
    do
        echo "Inicio da execução numero $(($x+$aux))" &&
        php coletor/Extrator.php -l $(($x+$aux)) &&
        php download.php -d ./arquivos/ --conf teste.conf &&
        php upload.php -d ./arquivos/ --conf teste.conf &&
        echo "Fim da execução numero $(($x+$aux))";
    done
done