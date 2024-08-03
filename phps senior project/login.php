<?php 
include 'conn.php';

$jsonData = file_get_contents('php://input');
$data = json_decode($jsonData, true);

if ($data !== null) {
    $id = $data['id'];
    $password = $data['pass'];

    // Prepare SQL query
    $query = mysqli_query($conn, "SELECT * FROM `users` WHERE `userID` = '$id' AND `password` = '$password'");

    if ($query) {
        if (mysqli_num_rows($query) > 0) {
            $emparray = array();
            while ($row = mysqli_fetch_assoc($query)) {
                $emparray[] = $row;
            }
            echo json_encode($emparray);
        } else {
            http_response_code(404);
            echo "No matching records found";
        }
        mysqli_close($conn);
    } else {
        http_response_code(500);
        echo "Query failed: " . mysqli_error($conn);
    }
} else {
    http_response_code(400);
    echo "Invalid JSON data";
}
?>
