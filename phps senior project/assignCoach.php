<?php
include 'conn.php';

// Get the data from the request
$data = json_decode(file_get_contents('php://input'), true);
$userID = $data['userID'];
$coachID = $data['coachID'];
$date = $data['date'];

// Prepare and execute the query
$sql = "INSERT INTO registeredcoach (userID, coachID, date) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("iis", $userID, $coachID, $date);

if ($stmt->execute()) {
    echo json_encode(array('success' => true));
} else {
    echo json_encode(array('success' => false));
}

// Close connection
$stmt->close();
$conn->close();
?>
