<?php
 
require 'coletor/ExtratorPlugin.php';

$rodada = $argv[2];
$nome_export = $argv[3];
$nome_sessao = $argv[4];
exportMysqlToCsv($rodada, '1', $nome_export);
exportMysqlToCsv($rodada, '2', $nome_sessao);
?>