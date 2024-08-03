<?php
include 'conn.php'; 
// Get JSON data from the request
$jsonData = file_get_contents('php://input');
$data = json_decode($jsonData, true);

if ($data !== null) {
    $id = $data['id'];
    $password = $data['pass'];
    $firstName = $data['firstName'];
    $lastName = $data['lastName'];
    $role = $data['role'];

    // Validation no input is empty
    if (empty($id) || empty($password) || empty($firstName) || empty($lastName) || empty($role)) {
        http_response_code(400);
        echo json_encode(["error" => "All fields are required"]);
        exit();
    }

    // Some security to avoid SQL INJ
    $id = mysqli_real_escape_string($conn, $id);
    $password = mysqli_real_escape_string($conn, $password);
    $firstName = mysqli_real_escape_string($conn, $firstName);
    $lastName = mysqli_real_escape_string($conn, $lastName);
    $role = mysqli_real_escape_string($conn, $role);

    // Check bl awal if user already exists
    $query = "SELECT * FROM `users` WHERE `userID` = '$id'";
    $result = mysqli_query($conn, $query);

    if (mysqli_num_rows($result) > 0) {
        http_response_code(409);
        echo json_encode(["error" => "User ID already exists"]);
        exit();
    }

    // Prepare SQL query to insert new user
    $query = "INSERT INTO `users` (`userID`, `password`, `Fname`, `Lname`, `role`) VALUES ('$id', '$password', '$firstName', '$lastName', '$role')";

    if (mysqli_query($conn, $query)) {
        http_response_code(200);
        echo json_encode(["message" => "User created successfully"]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => "Error creating user: " . mysqli_error($conn)]);
    }

    mysqli_close($conn);
} else {
    http_response_code(400);
    echo json_encode(["error" => "Invalid JSON data"]);
}
?>
