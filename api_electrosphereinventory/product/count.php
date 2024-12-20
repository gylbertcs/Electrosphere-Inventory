<?php
include "../connection.php";

$sql = "SELECT code FROM tb_product";
$result = $connect->query($sql);
echo json_encode(array(
    "data" => $result->num_rows,
));