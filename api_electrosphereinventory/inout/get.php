<?php
include "../connection.php";

$count = 10;
$page = $_POST['page'];
$type = $_POST['type'];

$start = ($page-1) * $count;

$sql = "SELECT id_history,created_at,total_price,type FROM tb_history
        WHERE
        type='$type'
        ORDER BY created_at DESC
        LIMIT $start, $count";
$result = $connect->query($sql);
if ($result->num_rows > 0) {
    $history = array();
    while ($row = $result->fetch_assoc()) {
        $history[] = $row;
    }
    echo json_encode(array(
        "success" => true,
        "data" => $history,
    ));
} else {
    echo json_encode(array("success" => false));
}
