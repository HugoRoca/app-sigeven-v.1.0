<?php

    require __DIR__ . '/../connection.php';

    class Venta{
        protected $db;

        public function __construct(){
            $this->db = DB();
        }

        public function insertarVenta($datos){
            $valor = '';
            
            foreach ($datos as $row) {
                $fecha = $row['dFecha'];
                $user =$row['cUser'];
                $id = $row['nId'];
                $cant = $row['nCant'];

                $query = $this->db->prepare("call Venta_Insertar_SP(?, ?, ?, ?)");
                $query->bindparam(1, $fecha, PDO::PARAM_STR);
                $query->bindparam(2, $user, PDO::PARAM_STR);
                $query->bindparam(3, $id, PDO::PARAM_STR);
                $query->bindparam(4, $cant, PDO::PARAM_STR);
                $query->execute();
                $valor = 'ok';
            }
            return $valor;
        }
    }

?>