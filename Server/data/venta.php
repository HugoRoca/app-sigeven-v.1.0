<?php

    require __DIR__ . '/../connection.php';

    class Venta{
        protected $db;

        public function __construct(){
            $this->db = DB();
        }

        public function listaPorSemana(){
            $query = $this->db->prepare("call Ventas_ListaPorSemana_SP");
            $query->execute();
            $data = array();
            while($row = $query->fetch(PDO::FETCH_ASSOC)){
              $data[] = $row;
            }
            return json_encode($data);
        }

        public function listaConsultaVenta($desde, $hasta){
            $query = $this->db->prepare("call Venta_Consulta_SP(?,?)");
            $query->bindparam(1, $desde);
            $query->bindparam(2, $hasta);
            $query->execute();
            $data = array();
            while($row = $query->fetch(PDO::FETCH_ASSOC)){
              $data[] = $row;
            }
            return json_encode($data);
        }

        public function listaConsultaVentaDetalle($id){
            $query = $this->db->prepare("call VentaDetalle_Consulta_SP(?)");
            $query->bindparam(1, $id);
            $query->execute();
            $data = array();
            while($row = $query->fetch(PDO::FETCH_ASSOC)){
              $data[] = $row;
            }
            return json_encode($data);
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