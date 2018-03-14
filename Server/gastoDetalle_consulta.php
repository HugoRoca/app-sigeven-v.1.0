<?php

    $data = json_decode(file_get_contents('php://input'), TRUE);

    require __DIR__ . '/data/gasto.php';

    $id = $data['nIdGasto'];

    $gasto = new Gasto();

    echo $gasto->listaConsultaGastoDetalle($id);

?>