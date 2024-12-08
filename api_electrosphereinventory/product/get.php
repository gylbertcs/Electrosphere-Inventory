<?php
include "../connection.php";

$sql = "SELECT * FROM tb_product";
$result = $connect->query($sql);
if ($result->num_rows > 0) {
    $products = array();
    while ($row = $result->fetch_assoc()) {
        $products[] = $row;
    }
    echo json_encode(array(
        "success" => true,
        "data" => $products,
    ));
} else {
    echo json_encode(array("success" => false));
}