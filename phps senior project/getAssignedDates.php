<?php
include 'conn.php';

$data = json_decode(file_get_contents('php://input'), true);

if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(['error' => 'Invalid JSON']);
    exit();
}

$userID = $data['userID'] ?? '';

if (empty($userID)) {
    echo json_encode(['error' => 'Missing parameters']);
    exit();
}

$query = "SELECT DISTINCT DATE(dateAssigned) as dateAssigned FROM assignedexercise WHERE userID = ? ORDER BY dateAssigned DESC";
$stmt = $conn->prepare($query);
$stmt->bind_param('s', $userID);

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $dates = [];

    while ($row = $result->fetch_assoc()) {
        $dates[] = $row['dateAssigned'];
    }

    echo json_encode($dates);
} else {
    echo json_encode(['error' => 'Failed to retrieve dates']);
}

$stmt->close();
$conn->close();
?>
