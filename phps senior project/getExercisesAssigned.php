<?php
header('Content-Type: application/json');

include('conn.php');

$data = json_decode(file_get_contents('php://input'), true);
$userID = $data['id'];
$dateAssigned = $data['dateAssigned'];

$assignedExercises = array();

$sql = "SELECT e.exerciseID, e.exerciseType, IF(ed.exerciseID IS NOT NULL, 1, 0) as isDone
        FROM assignedexercise ae
        JOIN exercises e ON ae.exerciseID = e.exerciseID
        LEFT JOIN exercisesdone ed ON ae.exerciseID = ed.exerciseID AND ae.userID = ed.userID AND DATE(ae.dateAssigned) = DATE(ed.dateAssigned)
        WHERE ae.userID = ? AND DATE(ae.dateAssigned) = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("is", $userID, $dateAssigned);
$stmt->execute();
$result = $stmt->get_result();

while ($row = $result->fetch_assoc()) {
    $assignedExercises[] = $row;
}

echo json_encode(array('exercises' => $assignedExercises));

$stmt->close();
$conn->close();
?>
