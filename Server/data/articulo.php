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


}

?>