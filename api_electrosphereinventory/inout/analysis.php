<?php
include "../connection.php";


// if (!isset($_POST['type']) || !isset($_POST['today'])) {
//     echo json_encode(array(
//         "success" => false,
//         "message" => "Missing required fields: type or today"
//     ));
//     exit; // Menghentikan eksekusi jika data tidak valid
// }

$type = $_POST['type'] ?? 'IN'; // Default value jika tidak ada data
$today = new DateTime($_POST['today'] ?? date('Y-m-d')); // Default hari ini jika tidak ada data
$loc = (new DateTime) -> getTimezone();

$today-> setTimezone($loc);
$day6 = date_sub($today,new DateInterval('P1D'))->format('Y-m-d');
$day5 = date_sub($today,new DateInterval('P2D'))->format('Y-m-d');
$day4 = date_sub($today,new DateInterval('P3D'))->format('Y-m-d');
$day3 = date_sub($today,new DateInterval('P4D'))->format('Y-m-d');
$day2 = date_sub($today,new DateInterval('P5D'))->format('Y-m-d');
$day1 = date_sub($today,new DateInterval('P6D'))->format('Y-m-d');
$week = array($day1,$day2,$day3,$day4,$day5,$day6,$today);

$sql = "SELECT * FROM tb_history
        WHERE
        type = '$type'
        ORDER BY created_at DESC
        ";

$result = $connect -> query($sql);
if ($result->num_rows > 0) {
    $list_total = array(0,0,0,0,0,0,0);
    $history = array();
    while ($row = $result->fetch_assoc()) {
        $date = new DateTime($row['created_at']);
        $the_day = $date->format('Y-m-d');
        if($the_day < $day1) {
            break;
        }

        for ($i=0; $i < count($week); $i++) {
            if ($the_day == $week[$i]) {
                $list_total[$i] += floatval($row['total_price']);
            }
        }

        $history[] = $row;
    }

    echo json_encode(array(
        "success" => true,
        "list_total" => $list_total,
        "data" => $history,
    ));
}else {
    echo json_encode(array("success" => false));
}

// error_log(json_encode($week));
// error_log(json_encode($list_total));

