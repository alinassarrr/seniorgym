<?php
include 'conn.php';

$query = mysqli_query($conn, "SELECT * FROM `users` WHERE `role` = 'coach'");

if(mysqli_num_rows($query) > 0){
    $emparray = array();
    while($row = mysqli_fetch_assoc($query))
        $emparray[] = $row;

    echo json_encode($emparray);
    mysqli_close($conn);
} else {
    http_response_code(404);
    echo json_encode(array('error' => 'No coaches found.'));
}
?>
