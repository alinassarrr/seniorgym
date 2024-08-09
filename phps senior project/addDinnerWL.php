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

// Check if the record already exists for the current date
$query = "SELECT * FROM assignedfood WHERE userID = ? AND foodID = ? AND dateAssigned = CURRENT_DATE";
$stmt = $conn->prepare($query);
$stmt->bind_param('ss', $userID, $foodID);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Record already exists, skip insertion
    echo json_encode(['success' => false, 'message' => 'Record already exists']);
} else {
    // Insert the new record with the current date
    $stmt = $conn->prepare("INSERT INTO assignedfood (userID, foodID, dateAssigned) VALUES (?, ?, CURRENT_DATE)");
    $stmt->bind_param('ss', $userID, $foodID);
    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['error' => 'Failed to add dinner']);
    }
}

$stmt->close();
$conn->close();
?>
