<?php
    //echo "Calulando 2 ".$_POST['data_in'];
    //if (isset($_GET[’data_out’]) && $_GET[’data_out’] != ”) {
    //$data_out = $_GET[’data_out’];
    //echo "<p>Data_Out da regressão: "; //. $data_out . "</p>";
    //}
    $commando = "Rscript Predizer.R ".$_GET['data_in'];
    $saida = shell_exec("$commando");
    echo "O Resultado é: ".$saida;
?>