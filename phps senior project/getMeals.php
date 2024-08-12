<?php
header('Content-Type: application/json');

include('conn.php');

$data = json_decode(file_get_contents('php://input'), true);
$foodType = $data['foodType'] ?? '';
$mealTime = $data['mealTime'] ?? '';

if (empty($foodType) || empty($mealTime)) {
    echo json_encode(['error' => 'Missing parameters']);
    exit();
}

// Prepare the SQL query to fetch the assigned foods with their names based on foodType and mealTime
$sql = "SELECT name FROM food WHERE foodType = ? AND mealTime = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param('ss', $foodType, $mealTime);
$stmt->execute();
$result = $stmt->get_result();

$foods = [];
while ($row = $result->fetch_assoc()) {
    $foods[] = ['name' => $row['name']];
}

echo json_encode(['foods' => $foods]);

$stmt->close();
$conn->close();
?>
