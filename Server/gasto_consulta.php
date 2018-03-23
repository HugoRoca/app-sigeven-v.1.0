<?php
    try {
        $data = json_decode(file_get_contents('php://input'), TRUE);
    
        require __DIR__ . '/data/gasto.php';
    
        $desde = $data['dDesde'];
        $hasta = $data['dHasta'];
    
        $gasto = new Gasto();
    
        echo $gasto->listaConsultaGasto($desde, $hasta);

    } catch (Exception $e){
        http_response_code(400);
        echo json_encode(['error' => ['Error inisperado.']]);
    }


?>