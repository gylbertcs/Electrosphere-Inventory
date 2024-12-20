<?php

include "../connection.php";

$code = $_POST['code'];

$sql = "DELETE FROM tb_product
        WHERE
        code='$code'
        ";
$result = $connect->query($sql);
if($result) {
    echo json_encode(array("success"=>true));
} else {
    echo json_encode(array("success"=>false));
}