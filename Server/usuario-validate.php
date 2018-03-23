<?php
    try{
        $data = json_decode(file_get_contents('php://input'), TRUE);

        if(isset($data['usuario'])){
            require __DIR__. '/data/usuario.php';

            $cUsuario = (isset($data['usuario']['cUsuario']) ? $data['usuario']['cUsuario'] : NULL);
            $cContrasenia = (isset($data['usuario']['cContrasenia']) ? $data['usuario']['cContrasenia'] : NULL);

            if($cUsuario == NULL || $cContrasenia == NULL){
                http_response_code(400);
                echo json_encode(['error' => ["Faltan datos"]]);
            }else{
                $usuario = new Usuario();
                echo (string)$usuario->Validate($cUsuario, $cContrasenia);
            }
        }
    }catch (Exception $e){
        http_response_code(400);
        echo json_encode(['error' => ["Error al autenticar."]]);
    }
?>