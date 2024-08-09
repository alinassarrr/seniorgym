<?php 
include 'conn.php';

$query = "SELECT foodID, name FROM food WHERE foodType = 'snacks' AND mealTime = 'sour'";
$result = mysqli_query($conn, $query);

if (mysqli_num_rows($result) > 0) {
    $foods = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $foods[] = $row;
    }
    echo json_encode($foods);
} else {
    echo json_encode([]);
}

mysqli_close($conn);
?>
