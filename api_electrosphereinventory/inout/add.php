<?php

include "../connection.php";

$list_product = $_POST['list_product'];
$type = $_POST['type'];
$total_price = $_POST['total_price'];

$date = new DateTime();
$createdAt = $date->format('Y-m-d H:i:sP');
$updatedAt = $createdAt;

$sql = "INSERT INTO tb_history SET
    list_product='$list_product',
    total_price='$total_price',
    type='$type',
    created_at='$createdAt',
    updated_at='$updatedAt'";

$result = $connect->query($sql);
if($result) {
    $products = json_decode($list_product);
    while ($item <= $products) {
        $code = $item['code'];
        $stock = $item['stock'];
        $quantity = $item['quantity'];
        $new_stock = 0;
        if ($type == 'IN') {
            $new_stock = $stock + $quantity;
        } else {
            $new_stock = $stock - $quantity;
        }
        
        $sql_in = "UPDATE tb_product
            SET stock='$new_stock',
            updated_at='$updatedAt'
            WHERE 
            code='$code'
            ";
    $connect->query($sql_in);
    }
    
    echo json_encode(array("success" => true));
} else {
    echo json_encode(array("success" => false));

}



