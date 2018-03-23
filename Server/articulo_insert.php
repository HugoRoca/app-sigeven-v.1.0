<?php
    try {
        $data = json_decode(file_get_contents('php://input'), TRUE);

        if(isset($data['articulo'])){
            require __DIR__ . '/data/articulo.php';

            $cDescripcion = (isset($data['articulo']['cDescripcion']) ? $data['articulo']['cDescripcion'] : NULL);
            $nStock = (isset($data['articulo']['nStock']) ? $data['articulo']['nStock'] : NULL);
            $nTipo = (isset($data['articulo']['nTipo']) ? $data['articulo']['nTipo'] : NULL);
            $nMarca = (isset($data['articulo']['nMarca']) ? $data['articulo']['nMarca'] : NULL);
            $nPrecioCompra = (isset($data['articulo']['nPrecioCompra']) ? $data['articulo']['nPrecioCompra'] : NULL);
            $nPrecioVenta = (isset($data['articulo']['nPrecioVenta']) ? $data['articulo']['nPrecioVenta'] : NULL);
            $cUser = (isset($data['articulo']['cUser']) ? $data['articulo']['cUser'] : NULL);

            if ($cDescripcion == NULL || $nStock == NULL || $nTipo == NULL || $nMarca == NULL || $nPrecioCompra == NULL || $nPrecioVenta == NULL) {
                http_response_code(400);
                echo json_encode(['error' => ['Faltan Datos']]);
            }else{
                $articulo = new Articulo();
                echo $articulo->insertarArticulo($cDescripcion, $nStock, $nTipo, $nMarca, $nPrecioCompra, $nPrecioVenta, $cUser);
            }
        }
    } catch (Exception $e){
        http_response_code(400);
        echo json_encode(['error' => ['Error inisperado.']]);
    }

?>