<?php
header('Content-Type: application/json');
include 'conn.php'; // Include your database connection script

// Get the user ID from the request
$data = json_decode(file_get_contents('php://input'), true);
$userID = $data['userID'];

// Check if the userID is in the registeredcoach table
$query = "SELECT * FROM registeredcoach WHERE userID = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("s", $userID);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // User is registered
    echo json_encode(['registered' => true]);
} else {
    // User is not registered
    echo json_encode(['registered' => false]);
}

$stmt->close();
$conn->close();
?>
