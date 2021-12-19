<?php

function exportMysqlToCsv($rodada, $exec ,$filename){
    if($exec == '1'){
        $result_data = executarConsulta($rodada);
    }elseif($exec == '2'){
        $result_data = executarConsultaSessao($rodada);
    }

    $f = fopen("$filename",'a');
    $first = true;

    if($result_data){
        while ($linha = $result_data->fetch_row()){
            fputcsv($f, $linha);
        }
    }

    $result_data->close();

    $size = ftell($f);
    rewind($f);

    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
    header("Content-Length: $size");
    header("Content-type: text/x-csv");
    header("Content-type: text/csv");
    header("Content-type: application/csv");
    header("Content-Disposition: attachment; filename=$filename");
    fpassthru($f);
   // exit;
}

function conectarAoBanco(){
    $host = 'localhost'; // MYSQL database host adress
    $db = 'sys'; // MYSQL database name
    $user = 'root'; // Mysql Database user
    $pass = 'James@123'; // Mysql Database password
    return new MySQLi($host, $user, $pass, $db);
}

function executarConsulta($rodada){
    $sql_query = "select 
                    $rodada,
                    now() as \"Data da Coleta\",
                    TABLE_NAME \"Tabela\",
                    TABLE_ROWS  \"Quantidade de Registros\"
                from information_schema.TABLES
                where TABLE_SCHEMA = 'moodle'
                and TABLE_NAME in ('mdl_assign_grades' ,
                'mdl_assignfeedback_comments' ,
                'mdl_course' ,
                'mdl_assign' ,
                'mdl_assign_submission' ,
                'mdl_assignsubmission_onlinetext' ,
                'mdl_course_modules' ,
                'mdl_grade_items' ,
                'mdl_grade_grades')"; 

    // Conexão com o bando de dados
    $MySQLi = conectarAoBanco();

    return $MySQLi->query($sql_query);
}

function executarConsultaTodos($rodada){
    $sql_query = "select 
                    $rodada,
                    now() as \"Data da Coleta\",
                    TABLE_NAME \"Tabela\",
                    TABLE_ROWS  \"Quantidade de Registros\"
                from information_schema.TABLES
                where TABLE_SCHEMA = 'moodle'"; 

    // Conexão com o bando de dados
    $MySQLi = conectarAoBanco();

    return $MySQLi->query($sql_query);
}

function executarConsultaTodosMaior0($rodada){
    $sql_query = "select 
                     $rodada ,
                    now() as \"Data da Coleta\",
                    TABLE_NAME \"Tabela\",
                    TABLE_ROWS  \"Quantidade de Registros\"
                from information_schema.TABLES
                where TABLE_SCHEMA = 'moodle'
                and TABLE_ROWS > 0"; 

    // Conexão com o bando de dados
    $MySQLi = conectarAoBanco();

    return $MySQLi->query($sql_query);
}

function executarConsultaSessao($rodada){
    $sql_query = "select 
                    $rodada,
                    USER,
                    HOST,
                    DB,
                    COMMAND,
                    TIME,
                    STATE
                FROM 
                    INFORMATION_SCHEMA.PROCESSLIST"; 

    // Conexão com o bando de dados
    $MySQLi = conectarAoBanco();

    return $MySQLi->query($sql_query);
}
?>