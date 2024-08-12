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

// First, attempt to update the existing record for the given userID
$query = "UPDATE registeredcoach SET coachID = ?, date = ? WHERE userID = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param('sss', $coachID, $date, $userID);

if ($stmt->execute()) {
    if ($stmt->affected_rows > 0) {
        // Successfully updated an existing row
        echo json_encode(array('success' => true));
    } else {
        // No rows updated, so try inserting a new record
        $insertQuery = "INSERT INTO registeredcoach (userID, coachID, date) VALUES (?, ?, ?)";
        $insertStmt = $conn->prepare($insertQuery);
        $insertStmt->bind_param('sss', $userID, $coachID, $date);

        if ($insertStmt->execute()) {
            echo json_encode(array('success' => true, 'action' => 'inserted'));
        } else {
            echo json_encode(array('error' => 'Failed to insert new coach'));
        }
        $insertStmt->close();
    }
} else {
    // SQL execution error
    echo json_encode(array('error' => 'Failed to update coach'));
}

$stmt->close();
$conn->close();
?>
