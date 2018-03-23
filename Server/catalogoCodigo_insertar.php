<?php
    try {
        $data = json_decode(file_get_contents('php://input'), TRUE);
    
        if(isset($data['catalogo'])){
            require __DIR__ . '/data/catalogoCodigo.php';    
            $nId = (isset($data['catalogo']['nId']) ? $data['catalogo']['nId'] : NULL);
            $cVal = (isset($data['catalogo']['cValor']) ? $data['catalogo']['cValor'] : NULL);
            $cNom = (isset($data['catalogo']['cDescripcion']) ? $data['catalogo']['cDescripcion'] : NULL);
            $nEst = (isset($data['catalogo']['nEstado']) ? $data['catalogo']['nEstado'] : NULL);    
            $catalogo = new CatalogoCodigo();
            echo $catalogo->insertarCatalogoCodigo($nId, $cNom , $cVal, $nEst);            
        }
    } catch (Exception $e){
        http_response_code(400);
        echo json_encode(['error' => ['Error inisperado.']]);
    }
?>