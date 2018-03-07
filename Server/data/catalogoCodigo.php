<?php
require __DIR__ . '/../connection.php';

class CatalogoCodigo{

  protected $db;

  public function __construct(){
    $this->db = DB();
  }

  public function listaCatalogoCodigo($nCodigo){
    $query = $this->db->prepare("call CatalogoCodigo_Lista_SP(?)");
    $query->bindparam(1, $nCodigo);
    $query->execute();
    $data = array();
    while($row = $query->fetch(PDO::FETCH_ASSOC)){
      $data[] = $row;
    }

    return json_encode($data);
  }
}

?>