<?php
include "../connection.php";

$date = $_POST['date'];

$sql = "SELECT * FROM tb_history
        WHERE
        created_at LIKE '%$date%'
        ";

$result = $connect -> query($sql);
if ($result->num_rows > 0) {
    $history = array();
    while ($row = $result->fetch_assoc()) {
        $history[] = $row;
    }
    echo json_encode(array(
        "success" => true,
        "data" => $history
    ));
}else{
    echo json_encode(array("success"=>false));
}