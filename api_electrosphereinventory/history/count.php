<?php
include "../connection.php";

$sql = "SELECT id_history FROM tb_history";
$result = $connect->query($sql);
echo json_encode(array(
    "data" => $result->num_rows,
));