<?php
require __DIR__ . '/../connection.php';

class CatalogoCodigo{

  protected $db;

  public function __construct(){
    $this->db = DB();
  }

  public function listaCatalogoCodigo($nCodigo, $nTip){
    $query = $this->db->prepare("call CatalogoCodigo_Lista_SP(?, ?)");
    $query->bindparam(1, $nCodigo);
    $query->bindparam(2, $nTip);
    $query->execute();
    $data = array();
    while($row = $query->fetch(PDO::FETCH_ASSOC)){
      $data[] = $row;
    }

    return json_encode($data);
  }

  public function insertarCatalogoCodigo($nId, $cNom , $cVal, $nEst){
    $valor = '';

        $query = $this->db->prepare("call CatalogoCodigo_Insertar_SP(?, ?, ?, ?)");
        $query->bindparam(1, $nId, PDO::PARAM_STR);
        $query->bindparam(2, $cNom, PDO::PARAM_STR);
        $query->bindparam(3, $cVal, PDO::PARAM_STR);
        $query->bindparam(4, $nEst, PDO::PARAM_STR);
        $query->execute();
        $valor = 'ok';
    
    return $valor;
}
}

?>