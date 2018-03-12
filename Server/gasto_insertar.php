<?php

    $data = json_decode(file_get_contents('php://input'), TRUE);

    //$jsonarray = json_decode($data, true);

    require __DIR__ . '/data/gasto.php';

    $gasto = new Gasto();

    echo $gasto->insertarGasto($data);

?>