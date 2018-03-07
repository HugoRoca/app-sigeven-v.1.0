<?php
require __DIR__ . '/../connection.php';

class Usuario{

    protected $db;

    public function __construct(){
        $this->db = DB();
    }

    public function Validate($cUsuario, $cContrasenia)
    {
        $query = $this->db->prepare("call Usuario_Validar_SP(? ,?)");
        $query->bindparam(1, $cUsuario, PDO::PARAM_STR);
        $query->bindparam(2, $cContrasenia, PDO::PARAM_STR);
        $query->execute();
        $data = array();
        while ($row = $query->fetch(PDO::FETCH_ASSOC)) {
            $data[] = $row;
        }
 
        //return json_encode($cUsuario . '-' . $cContrasenia);
        return json_encode($data);
    }
}
?>