<?php
include 'conn.php';

$data = json_decode(file_get_contents('php://input'), true);

if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(['error' => 'Invalid JSON']);
    exit();
}

$userID = $data['id'] ?? '';
$foodID = $data['foodID'] ?? '';

if (empty($userID) || empty($foodID)) {
    echo json_encode(['error' => 'Missing parameters']);
    exit();
}

// Check if the entry already exists
$checkQuery = "SELECT * FROM assignedfood WHERE userID = ? AND foodID = ?";
$checkStmt = $conn->prepare($checkQuery);
$checkStmt->bind_param('ss', $userID, $foodID);
$checkStmt->execute();
$checkResult = $checkStmt->get_result();

if ($checkResult->num_rows > 0) {
    echo json_encode(['error' => 'Entry already exists']);
} else {
    // Insert the new entry only if it doesn't exist
    $query = "INSERT INTO assignedfood (userID, foodID) VALUES (?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param('ss', $userID, $foodID);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['error' => 'Failed to add snack']);
    }

    $stmt->close();
}

$checkStmt->close();
$conn->close();
?>
