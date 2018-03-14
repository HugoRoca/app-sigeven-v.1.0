<?php

    $data = json_decode(file_get_contents('php://input'), TRUE);

    require __DIR__ . '/data/venta.php';

    $id = $data['nIdVenta'];

    $venta = new Venta();

    echo $venta->listaConsultaVentaDetalle($id);

?>