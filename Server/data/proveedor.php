<?php

    require __DIR__ . '/../connection.php';

    class Proveedor{
        protected $db;

        public function __construct(){
            $this->db = DB();
        }

        public function insertarProveedor($datos){
            $valor = '';
            
            foreach ($datos as $row) {
                $dFech = $row['dFech'];
                $cNomProv =$row['cNomProv'];
                $idArt = $row['idArt'];
                $nCant = $row['nCant'];
                $nPxC = $row['nPxC'];
                $nPxV = $row['nPxV'];
                $nPTotal = $row['nPTotal'];
                $cUsu = $row['cUsu'];

                $query = $this->db->prepare("call Proveedor_Insertar_SP(?, ?, ?, ?, ?, ?, ?, ?)");
                $query->bindparam(1, $dFech, PDO::PARAM_STR);
                $query->bindparam(2, $cNomProv, PDO::PARAM_STR);
                $query->bindparam(3, $idArt, PDO::PARAM_STR);
                $query->bindparam(4, $nCant, PDO::PARAM_STR);
                $query->bindparam(5, $nPxC, PDO::PARAM_STR);
                $query->bindparam(6, $nPxV, PDO::PARAM_STR);
                $query->bindparam(7, $nPTotal, PDO::PARAM_STR);
                $query->bindparam(8, $cUsu, PDO::PARAM_STR);
                $query->execute();
                $valor = 'ok';
            }
            return $valor;
        }
    }

?>