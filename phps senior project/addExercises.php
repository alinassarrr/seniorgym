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

// Check if the record already exists for the same user, exercise, and date
$query = "SELECT * FROM assignedexercise WHERE userID = ? AND exerciseID = ? AND dateAssigned = CURRENT_DATE";
$stmt = $conn->prepare($query);
$stmt->bind_param('ss', $userID, $exerciseID);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Record already exists, skip insertion
    echo json_encode(array('success' => false, 'message' => 'Record already exists'));
} else {
    // Insert the new record with the current date
    $stmt = $conn->prepare("INSERT INTO assignedexercise (exerciseID, userID, dateAssigned) VALUES (?, ?, CURRENT_DATE)");
    $stmt->bind_param('ss', $exerciseID, $userID);

    if ($stmt->execute()) {
        echo json_encode(array('success' => true));
    } else {
        echo json_encode(array('error' => 'Failed to add exercise'));
    }
}

$stmt->close();
$conn->close();
?>
