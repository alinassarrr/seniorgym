<?php
include 'conn.php';

$data = json_decode(file_get_contents('php://input'), true);

if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(['error' => 'Invalid JSON']);
    exit();
}

$userID = $data['id'] ?? '';

if (empty($userID)) {
    echo json_encode(['error' => 'Missing parameters']);
    exit();
}

$query = "SELECT foodID FROM assignedfood WHERE userID = ? AND dateAssigned = CURRENT_DATE";
$stmt = $conn->prepare($query);
$stmt->bind_param('i', $userID);  // 'i' for integer

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $assignedFoods = [];

    while ($row = $result->fetch_assoc()) {
        $assignedFoods[] = $row['foodID'];
    }

    echo json_encode($assignedFoods);
} else {
    echo json_encode(['error' => 'Failed to retrieve assigned foods']);
}

$stmt->close();
$conn->close();
?>
