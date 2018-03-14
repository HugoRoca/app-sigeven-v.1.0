<?php

    $data = json_decode(file_get_contents('php://input'), TRUE);

    require __DIR__ . '/data/venta.php';

    $desde = $data['dDesde'];
    $hasta = $data['dHasta'];

    $venta = new Venta();

    echo $venta->listaConsultaVenta($desde, $hasta);

?>