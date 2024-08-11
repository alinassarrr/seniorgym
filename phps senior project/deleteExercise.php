<?php
include 'conn.php';

$data = json_decode(file_get_contents('php://input'), true);

if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(array('error' => 'Invalid JSON'));
    exit();
}

$userID = $data['id'] ?? '';
$exerciseID = $data['exerciseID'] ?? '';

if (empty($userID) || empty($exerciseID)) {
    echo json_encode(array('error' => 'Missing parameters'));
    exit();
}

// Prepare and execute the delete query
$query = "DELETE FROM assignedexercise WHERE DATE(dateAssigned) = CURRENT_DATE AND  exerciseID = ? AND userID = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param('ss', $exerciseID, $userID);

if ($stmt->execute()) {
    echo json_encode(array('success' => true));
} else {
    echo json_encode(array('error' => 'Failed to delete exercise'));
}

$stmt->close();
$conn->close();
?>
