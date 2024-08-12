<?php
include 'conn.php';

$data = json_decode(file_get_contents('php://input'), true);

if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(array('error' => 'Invalid JSON'));
    exit();
}

$userID = $data['userID'] ?? '';

if (empty($userID)) {
    echo json_encode(array('error' => 'Missing parameters'));
    exit();
}

// Check if userID exists in the table
$query = "SELECT COUNT(*) AS count FROM registeredcoach WHERE userID = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param('s', $userID);

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $isCoachAssigned = $row['count'] > 0;

    echo json_encode($isCoachAssigned); // Return true or false
} else {
    echo json_encode(array('error' => 'Failed to check coach assignment'));
}

$stmt->close();
$conn->close();
?>