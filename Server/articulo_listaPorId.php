<?php
    try {
        $data = json_decode(file_get_contents('php://input'), TRUE);
    
        if(isset($data['Id'])){
            require __DIR__ . '/data/articulo.php';
    
            $nId = (isset($data["Id"]) ? $data["Id"] : NULL);
    
            if ($nId == NULL) {
                http_response_code(400);
                echo json_encode(['error' => ['Faltan datos']]);
            }else{
                $articulo = new Articulo();
                echo $articulo->listaPorIdArticulo($nId);
            }
        }
    } catch (Exception $e){
        http_response_code(400);
        echo json_encode(['error' => ['Error inisperado.']]);
    }
?>