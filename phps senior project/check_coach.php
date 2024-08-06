<?php
include 'conn.php';

// Get the raw POST data
$data = json_decode(file_get_contents('php://input'), true);

// Check if JSON data was successfully decoded
if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(array('error' => 'Invalid JSON'));
    exit();
}

// Retrieve userID from JSON data
$userID = isset($data['userID']) ? intval($data['userID']) : null;

if ($userID === null) {
    echo json_encode(array('error' => 'userID not provided'));
    exit();
}

// Prepare and execute the query
$sql = "SELECT * FROM registeredcoach WHERE userID = ?";
$stmt = $conn->prepare($sql);

if ($stmt === false) {
    echo json_encode(array('error' => 'Failed to prepare statement'));
    exit();
}

$stmt->bind_param("i", $userID);
$stmt->execute();
$result = $stmt->get_result();

// Check if any rows were returned
if ($result->num_rows > 0) {
    echo json_encode(true);
} else {
    echo json_encode(false);
}

// Close statement and connection
$stmt->close();
$conn->close();
?>
