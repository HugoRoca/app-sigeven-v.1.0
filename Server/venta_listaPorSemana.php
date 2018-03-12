<?php

require __DIR__ . '/data/venta.php';

$venta = new Venta();

echo $venta->listaPorSemana();

?>