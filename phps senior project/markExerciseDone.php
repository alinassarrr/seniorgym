<?php
include 'conn.php';

$data = json_decode(file_get_contents('php://input'), true);

if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(['error' => 'Invalid JSON']);
    exit();
}

$userID = $data['userID'] ?? '';
$exerciseID = $data['exerciseID'] ?? '';
$dateAssigned = $data['dateAssigned'] ?? '';

if (empty($userID) || empty($exerciseID) || empty($dateAssigned)) {
    echo json_encode(['error' => 'Missing parameters']);
    exit();
}

// Ensure dateAssigned is in the correct format (yyyy-mm-dd)
$dateAssigned = date('Y-m-d', strtotime($dateAssigned));

$query = "INSERT INTO exercisesdone (exerciseID, userID, dateAssigned) VALUES (?, ?, ?)";
$stmt = $conn->prepare($query);
$stmt->bind_param('sss', $exerciseID, $userID, $dateAssigned);

if ($stmt->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['error' => 'Failed to mark exercise as done', 'sqlError' => $stmt->error]);
}

$stmt->close();
$conn->close();
?>
