<?php
include 'conn.php';

$data = json_decode(file_get_contents('php://input'), true);

if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(['error' => 'Invalid JSON']);
    exit();
}

$userID = $data['id'] ?? '';
$foodIDs = $data['foodIDs'] ?? [];

if (empty($userID) || empty($foodIDs)) {
    echo json_encode(['error' => 'Missing parameters']);
    exit();
}

// Prepare the query to delete multiple rows
$query = "DELETE FROM assignedfood WHERE userID = ? AND foodID = ?  AND dateAssigned = CURRENT_DATE";
$stmt = $conn->prepare($query);

foreach ($foodIDs as $foodID) {
    $stmt->bind_param('ss', $userID, $foodID);
    if (!$stmt->execute()) {
        echo json_encode(['error' => 'Failed to delete food with ID ' . $foodID]);
        $stmt->close();
        $conn->close();
        exit();
    }
}

echo json_encode(['success' => true]);

$stmt->close();
$conn->close();
?>
