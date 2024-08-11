<?php
header('Content-Type: application/json');

// Include your database connection file
include('conn.php');

// Get userID, dateAssigned, and mealTime from the POST request
$data = json_decode(file_get_contents('php://input'), true);
$userID = $data['id'] ?? '';
$dateAssigned = $data['dateAssigned'] ?? '';
$mealTime = $data['mealTime'] ?? '';

if (empty($userID) || empty($dateAssigned) || empty($mealTime)) {
    echo json_encode(['error' => 'Missing parameters']);
    exit();
}

// Prepare the SQL query to fetch the assigned foods with their names
$sql = "SELECT f.name AS foodName, f.mealTime
        FROM assignedfood af
        JOIN food f ON af.foodID = f.foodID
        WHERE af.userID = ? AND af.dateAssigned = ? AND f.mealTime = ?";

// Prepare and execute the SQL statement
$stmt = $conn->prepare($sql);
$stmt->bind_param('sss', $userID, $dateAssigned, $mealTime);
$stmt->execute();
$result = $stmt->get_result();

// Initialize an empty array to hold the foods
$assignedFoods = [];

while ($row = $result->fetch_assoc()) {
    $assignedFoods[] = [
        'foodName' => $row['foodName'],
        'mealTime' => $row['mealTime']
    ];
}

// Return the results as JSON
echo json_encode(['foods' => $assignedFoods]);

$stmt->close();
$conn->close();
?>
