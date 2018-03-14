<?php

    $data = json_decode(file_get_contents('php://input'), TRUE);

    //$jsonarray = json_decode($data, true);

    require __DIR__ . '/data/proveedor.php';

    $proveedor = new Proveedor();

    echo $proveedor->insertarProveedor($data);

?>