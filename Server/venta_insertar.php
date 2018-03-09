<?php

    $data = json_decode(file_get_contents('php://input'), TRUE);

    //$jsonarray = json_decode($data, true);

    require __DIR__ . '/data/venta.php';

    $venta = new Venta();

    echo $venta->insertarVenta($data);

?>