<?php
    try {
        $data = json_decode(file_get_contents('php://input'), TRUE);
    
        if(isset($data['Id'])){
          require __DIR__ . '/data/catalogoCodigo.php';
    
          $nCodigo = (isset($data['Id']) ? $data['Id'] : NULL);
          $nTip = (isset($data['nTip']) ? $data['nTip'] : NULL);
    
          if($nCodigo == null){
            http_response_code(400);
            echo json_encode(['error' => ['Faltan datos']]);
          }else{
            $catalogo = new CatalogoCodigo();
            echo $catalogo->listaCatalogoCodigo($nCodigo, $nTip);
          }
        }
    } catch (Exception $e){
        http_response_code(400);
        echo json_encode(['error' => ['Error inisperado.']]);
    }
?>