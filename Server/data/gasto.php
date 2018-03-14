<?php

    require __DIR__ . '/../connection.php';

    class Gasto{
        protected $db;

        public function __construct(){
            $this->db = DB();
        }

        public function listaConsultaGasto($desde, $hasta){
            $query = $this->db->prepare("call Gasto_Consulta_SP(?,?)");
            $query->bindparam(1, $desde);
            $query->bindparam(2, $hasta);
            $query->execute();
            $data = array();
            while($row = $query->fetch(PDO::FETCH_ASSOC)){
              $data[] = $row;
            }
            return json_encode($data);
        }

        public function listaConsultaGastoDetalle($id){
            $query = $this->db->prepare("call GastoDetalle_Consulta_SP(?)");
            $query->bindparam(1, $id);
            $query->execute();
            $data = array();
            while($row = $query->fetch(PDO::FETCH_ASSOC)){
              $data[] = $row;
            }
            return json_encode($data);
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