<?php
include 'conn.php';

//Check if file was uploaded 
if (isset($_FILES['image']) && isset($_POST['userID'])) {
    $userID = mysqli_real_escape_string($conn, $_POST['userID']);
    $image = $_FILES['image'];

    //Te3rif upload directory and file path
    $uploadDir = __DIR__ . '/uploads/';
    if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }
    $fileName = basename($image['name']);
    $filePath = $uploadDir . $fileName;

    //Move Uploaded Image to Dir
    if (move_uploaded_file($image['tmp_name'], $filePath)) {
        $query = "UPDATE users SET image = '$filePath' WHERE userID = '$userID'";
        if (mysqli_query($conn, $query)) {
            http_response_code(200);
            echo json_encode(['message' => 'File uploaded and user updated successfully']);
        } else {
            http_response_code(500);
            echo json_encode(['error' => 'Error updating user with file path']);
        }
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Error moving uploaded file']);
    }

    mysqli_close($conn);
} else {
    http_response_code(400);
    echo json_encode(['error' => 'No file uploaded or userID missing']);
}
?>
