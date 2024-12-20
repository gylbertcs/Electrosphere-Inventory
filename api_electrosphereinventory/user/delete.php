<?php
include "../connection.php";

$id_user = $_POST['id_user'];

$sql = "DELETE FROM tb_user WHERE id_user='$id_user'";
$result = $connect->query($sql);
if($result) {
    echo json_encode(array("success"=>true));
} else {
    echo json_encode(array("success"=>false));
}