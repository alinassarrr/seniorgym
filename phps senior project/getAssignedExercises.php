<?php
header('Content-Type: application/json');

// Include your database connection file
include('conn.php');

// Get user ID from POST request
$data = json_decode(file_get_contents('php://input'), true);
$userID = $data['id'];

// Initialize an empty array to hold assigned exercises
$assignedExercises = array();

// Prepare the SQL query to fetch assigned exercises
$sql = "SELECT e.exerciseType
        FROM assignedexercise ae
        JOIN exercises e ON ae.exerciseID = e.exerciseID
        WHERE ae.userID = ?";

// Prepare and execute the SQL statement
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $userID);
$stmt->execute();
$result = $stmt->get_result();

// Fetch the results and store them in the array
while ($row = $result->fetch_assoc()) {
    $assignedExercises[] = $row;
}

// Return the results as JSON
echo json_encode(array('exercises' => $assignedExercises));

// Close the database connection
$stmt->close();
$conn->close();
?>
