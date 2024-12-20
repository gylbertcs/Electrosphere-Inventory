<?php
include "../connection.php";

$count = 10;
$page = $_POST['page'];

$start = ($page-1) * $count;

$sql = "SELECT id_history, created_at, total_price,type FROM tb_history
        ORDER BY created_at DESC
        LIMIT $start, $count";

$result = $connect->query($sql);
if ($result ->num_rows > 0) {
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