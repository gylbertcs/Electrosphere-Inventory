<?php

include "../connection.php";

$id_history = $_POST['id_history'];

$sql = "DELETE FROM tb_history
        WHERE
        id_history='$id_history'
        ";
$result = $connect->query($sql);
if($result) {
    echo json_encode(array("success"=>true));
} else {
    echo json_encode(array("success"=>false));    
}
