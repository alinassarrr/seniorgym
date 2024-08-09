<?php
// Include your database connection file
include 'conn.php';

// Set the content type to JSON
header('Content-Type: application/json');

// Query to get all exercises
$sql = "SELECT exerciseID, exerciseType FROM exercises";
$result = $conn->query($sql);

// Initialize an array to hold the exercises
$exercises = array();

if ($result->num_rows > 0) {
    // Fetch all rows and add them to the array
    while ($row = $result->fetch_assoc()) {
        $exercises[] = $row;
    }
}

// Output the exercises as JSON
echo json_encode($exercises);

// Close the database connection
$conn->close();
?>
