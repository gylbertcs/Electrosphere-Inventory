<?php
include "../connection.php";

$name = $_POST['name'];
$email = $_POST['email'];
$password = md5($_POST['password']);

$date = new DateTime();
$createdAt = $date->format('Y-m-d H:i:sP');
$updatedAt = $createdAt;

$sql_check_email = "SELECT * FROM tb_user WHERE email='$email'";
$resultCheckEmail = $connect->query($sql_check_email);
if ($resultCheckEmail->num_rows > 0) {
    echo json_encode(array(
        "success" => false,
        "message" => "email",
    ));
}else{
    $sql = "INSERT INTO tb_user
            SET
            name='$name',
            email='$email',
            password='$password',
            level='Employee',
            created_at='$createdAt',
            updated_at='$updatedAt'
            ";
    $result = $connect->query($sql);
    if($result) {
        echo json_encode(array("success"=>true));
    } else {
        echo json_encode(array("success"=>false));
    }
}