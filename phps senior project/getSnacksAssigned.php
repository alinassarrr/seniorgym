<?php
header('Content-Type: application/json');

include('conn.php');

// Get userID, dateAssigned, and foodType from the POST request
$data = json_decode(file_get_contents('php://input'), true);
$userID = $data['id'] ?? '';
$dateAssigned = $data['dateAssigned'] ?? '';
$foodType = $data['foodType'] ?? '';

if (empty($userID) || empty($dateAssigned) || empty($foodType)) {
    echo json_encode(['error' => 'Missing parameters']);
    exit();
}

// Prepare the SQL query to fetch the assigned foods with their names based on foodType
$sql = "SELECT f.name AS foodName, f.foodType
        FROM assignedfood af
        JOIN food f ON af.foodID = f.foodID
        WHERE af.userID = ? AND af.dateAssigned = ? AND f.foodType = ?";

// Prepare and execute the SQL statement
$stmt = $conn->prepare($sql);
$stmt->bind_param('sss', $userID, $dateAssigned, $foodType);
$stmt->execute();
$result = $stmt->get_result();

// Initialize an empty array to hold the foods
$assignedFoods = [];

while ($row = $result->fetch_assoc()) {
    $assignedFoods[] = [
        'foodName' => $row['foodName'],
        'foodType' => $row['foodType']
    ];
}

// Return the results as JSON
echo json_encode(['foods' => $assignedFoods]);

$stmt->close();
$conn->close();
?>
