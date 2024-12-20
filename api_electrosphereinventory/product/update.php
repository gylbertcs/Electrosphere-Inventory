<?php

include "../connection.php";

$old_code = $_POST['old_code'];
$code = $_POST['code'];
$name = $_POST['name'];
$price = $_POST['price'];
$stock = $_POST['stock'];
$unit = $_POST['unit'];

$date = new DateTime();
$updatedAt = $date->format('Y-m-d H:i:sP');
// (code == newCode) && (code != oldCode)
$sql_check_code = "SELECT * FROM tb_product WHERE code='$code' AND NOT code='$old_code'";
$result_check_code = $connect->query($sql_check_code);
if ($result_check_code->num_rows > 0) {
    echo json_encode(array(
        "success" => false,
        "message" => "code",
    ));
}else{
    $sql = "UPDATE tb_product SET
        code='$code',
        name='$name',
        price='$price',
        stock='$stock',
        unit='$unit',
        updated_at='$updatedAt'
        WHERE
        code='$old_code'
        ";
    $result = $connect->query($sql);
    if($result) {
        echo json_encode(array("success"=>true));
    } else {
        echo json_encode(array("success"=>false));
    }
}