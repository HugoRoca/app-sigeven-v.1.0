<?php

require __DIR__ . '/../connection.php';

class Articulo{
  protected $db;

  public function __construct(){
    $this->db = DB();
  }

  public function listaArticuloMasVendido(){
    $query = $this->db->prepare("call Articulo_ListaMasVendidos_SP");
    $query->execute();
    $data = array();
    while($row = $query->fetch(PDO::FETCH_ASSOC)){
      $data[] = $row;
    }
    return json_encode($data);
  }

  public function dashboardConsulta(){
    $query = $this->db->prepare("call Dashboard_Consulta_SP");
    $query->execute();
    $data = array();
    while($row = $query->fetch(PDO::FETCH_ASSOC)){
      $data[] = $row;
    }
    return json_encode($data);
  }

  public function listaPorIdArticulo($Id){
    $query = $this->db->prepare("call Articulo_ListaPorId_SP(?)");
    $query->bindparam(1, $Id);
    $query->execute();
    $data = array();
    while($row = $query->fetch(PDO::FETCH_ASSOC)){
      $data[] = $row;
    }
    return json_encode($data);
  }

  public function listaArticulo(){
    $query = $this->db->prepare("call Articulo_Lista_SP");
    $query->execute();
    $data = array();
    while($row = $query->fetch(PDO::FETCH_ASSOC)){
      $data[] = $row;
    }
    return json_encode($data);
  }

  public function anulaArticulo($nID){
    $query = $this->db->prepare("call Articulo_Anular_SP(?)");
    $query->bindparam(1, $nID);
    $query->execute();
    return json_encode(['articulo' => [
      'ID' => $nID
    ]]);
  }

  public function insertarArticulo($cDescripcion, $nStock, $nTipo, $nMarca, $nPrecioCompra, $nPrecioVenta, $cUser){
    $query = $this->db->prepare("call Articulo_Insrtar_SP(?,?,?,?,?,?,?)");
    $query->bindparam(1, $cDescripcion);
    $query->bindparam(2, $nStock);
    $query->bindparam(3, $nTipo);
    $query->bindparam(4, $nMarca);
    $query->bindparam(5, $nPrecioCompra);
    $query->bindparam(6, $nPrecioVenta);
    $query->bindparam(7, $cUser);
    $query->execute();
    return json_encode(['articulo' => [
      'cDescripcion' => $cDescripcion
    ]]);
  }

  public function actualizarArticulo($nId, $cDescripcion, $nStock, $nTipo, $nMarca, $nPrecioCompra, $nPrecioVenta, $cUser){
    $query = $this->db->prepare("call Articulo_Actualiza_SP(?,?,?,?,?,?,?,?)");
    $query->bindparam(1, $nId);
    $query->bindparam(2, $cDescripcion);
    $query->bindparam(3, $nStock);
    $query->bindparam(4, $nTipo);
    $query->bindparam(5, $nMarca);
    $query->bindparam(6, $nPrecioCompra);
    $query->bindparam(7, $nPrecioVenta);
    $query->bindparam(8, $cUser);
    $query->execute();
    return json_encode(['articulo' => [
      'cDescripcion' => $cDescripcion
    ]]);
  }


}

?>