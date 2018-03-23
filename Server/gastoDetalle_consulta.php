<?php
    try {
        $data = json_decode(file_get_contents('php://input'), TRUE);
    
        require __DIR__ . '/data/gasto.php';
    
        $id = $data['nIdGasto'];
    
        $gasto = new Gasto();
    
        echo $gasto->listaConsultaGastoDetalle($id);

    } catch (Exception $e){
        http_response_code(400);
        echo json_encode(['error' => ['Error inisperado.']]);
    }


?>