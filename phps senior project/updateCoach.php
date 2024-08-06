<?php
include 'conn.php';

$data = json_decode(file_get_contents('php://input'), true);

if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(array('error' => 'Invalid JSON'));
    exit();
}

$userID = $data['userID'] ?? '';
$coachID = $data['coachID'] ?? '';
$date = $data['date'] ?? '';

if (empty($userID) || empty($coachID) || empty($date)) {
    echo json_encode(array('error' => 'Missing parameters'));
    exit();
}

// Update the existing row for the given userID
$query = "UPDATE registeredcoach SET coachID = ?, date = ? WHERE userID = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param('sss', $coachID, $date, $userID);

if ($stmt->execute()) {
    if ($stmt->affected_rows > 0) {
        // Successfully updated an existing row
        echo json_encode(array('success' => true));
    } else {
        // No rows updated (e.g., userID not found)
        echo json_encode(array('error' => 'No rows updated'));
    }
} else {
    // SQL execution error
    echo json_encode(array('error' => 'Failed to update coach'));
}

$stmt->close();
$conn->close();
?>
