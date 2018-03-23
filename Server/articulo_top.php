<?php
    try {
        require __DIR__ . '/data/articulo.php';
    
        $articulo = new Articulo();
    
        echo $articulo->listaArticuloMasVendido();
    } catch (Exception $e){
        http_response_code(400);
        echo json_encode(['error' => ['Error inisperado.']]);
    }
?>