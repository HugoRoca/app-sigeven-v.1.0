<?php
    try {
        $data = json_decode(file_get_contents('php://input'), TRUE);
    
        require __DIR__ . '/data/venta.php';
    
        $id = $data['nIdVenta'];
    
        $venta = new Venta();
    
        echo $venta->listaConsultaVentaDetalle($id);        

    } catch (Exception $e){
        http_response_code(400);
        echo json_encode(['error' => ['Error inisperado.']]);
    }

?>