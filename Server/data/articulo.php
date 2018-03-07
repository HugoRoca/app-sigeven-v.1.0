<?php

require __DIR__ . '/../connection.php';

class Articulo{
  protected $db;

  public function __construct(){
    $this->db = DB();
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

  public function insertarArticulo($cDescripcion, $nStock, $nTipo, $nMarca, $nPrecioCompra, $nPrecioVenta){
    $query = $this->db->prepare("call Articulo_Insrtar_SP(?,?,?,?,?,?)");
    $query->bindparam(1, $cDescripcion);
    $query->bindparam(2, $nStock);
    $query->bindparam(3, $nTipo);
    $query->bindparam(4, $nMarca);
    $query->bindparam(5, $nPrecioCompra);
    $query->bindparam(6, $nPrecioVenta);
    $query->execute();
    return json_encode(['articulo' => [
      'cDescripcion' => $cDescripcion
  ]]);
  }


}

?>