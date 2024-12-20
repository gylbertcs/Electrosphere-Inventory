<?php

include "../connection.php";

$date = $_POST['date'];
$date_time = new DateTime($date);

// change to local date in this server
$loc = (new DateTime())->getTimezone();
$date_time->setTimezone($loc);

$date_time_string = $date_time->format('Y-m-d');

$sql = "DELETE FROM tb_history
        WHERE
        created_at<'$date_time_string'
        ";
$result = $connect->query($sql);
if($result) {    
    echo json_encode(array("success"=>true));
} else {
    echo json_encode(array("success"=>false));    
}
