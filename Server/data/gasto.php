<?php

    require __DIR__ . '/../connection.php';

    class Gasto{
        protected $db;

        public function __construct(){
            $this->db = DB();
        }

        public function insertarGasto($datos){
            $valor = '';
            
            foreach ($datos as $row) {
                $fecha = $row['dFecha'];
                $user =$row['cUser'];
                $cDesc = $row['cDesc'];
                $nTot = $row['nTot'];

                $query = $this->db->prepare("call Gasto_Insertar_SP(?, ?, ?, ?)");
                $query->bindparam(1, $fecha, PDO::PARAM_STR);
                $query->bindparam(2, $user, PDO::PARAM_STR);
                $query->bindparam(3, $cDesc, PDO::PARAM_STR);
                $query->bindparam(4, $nTot, PDO::PARAM_STR);
                $query->execute();
                $valor = 'ok';
            }
            return $valor;
        }
    }

?>