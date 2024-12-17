<?php
include "../connection.php";

$id_history = $_POST['id_history'];

$sql = "SELECT * FROM tb_history WHERE id_history='$id_history'";
$result = $connect->query($sql);
if ($result->num_rows > 0) {
    $history = array();
    while ($row = $result->fetch_assoc()) {
        $history[] = $row;
    }
    echo json_encode(array(
        "success" => true,
        "data" => $history[0],
    ));
} else {
    echo json_encode(array("success" => false));
}

