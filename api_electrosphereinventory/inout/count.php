<?php
include "../connection.php";

$type = $_POST['type'];

$sql = "SELECT id_history FROM tb_history WHERE type='$type'";
$result = $connect->query($sql);
echo json_encode(array(
    "data" => $result->num_rows,
));