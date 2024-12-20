<?php
include "../connection.php";

$sql = "SELECT * FROM tb_user WHERE level='Employee'";
$result = $connect->query($sql);
if ($result->num_rows > 0) {
    $users = array();
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }
    echo json_encode(array(
        "success" => true,
        "data" => $users,
    ));
} else {
    echo json_encode(array("success" => false));
}

