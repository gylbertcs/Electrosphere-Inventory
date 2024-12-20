<?php
include "../connection.php";

$sql = "SELECT id_user FROM tb_user WHERE level='Employee'";
$result = $connect->query($sql);
echo json_encode(array(
    "data" => $result->num_rows,
));