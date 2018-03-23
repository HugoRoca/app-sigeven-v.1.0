<?php
    try {
        require __DIR__ . '/data/venta.php';
    
        $venta = new Venta();
    
        echo $venta->listaPorSemana();

    } catch (Exception $e){
        http_response_code(400);
        echo json_encode(['error' => ['Error inisperado.']]);
    }


?>