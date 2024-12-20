<?php
include "../connection.php";

$idUser = $_POST['id_user'];
$password = md5($_POST['password']);
$date = new DateTime();
$updatedAt = $date->format('Y-m-d H:i:sP');

$sql = "UPDATE tb_user set 
        password='$password',
        updated_at='$updatedAt'
        WHERE
        id_user='$idUser'
        ";
$result = $connect->query($sql);
if($result) {    
    echo json_encode(array(
        "success"=>true
    ));
} else {
    echo json_encode(array(
        "success"=>false
    ));
}