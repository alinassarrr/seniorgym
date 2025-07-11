<?php
include 'conn.php'; // Include your database connection file

// Check if the userID is provided
if (isset($_GET['userID'])) {
    $userID = mysqli_real_escape_string($conn, $_GET['userID']);
    
    // Query to get user data
    $query = "SELECT userID, firstName, lastName, image FROM users WHERE userID = '$userID'";
    $result = mysqli_query($conn, $query);
    
    if ($result) {
        $user = mysqli_fetch_assoc($result);
        if ($user) {
            // Construct the image URL
            $imageUrl = 'http://10.0.2.2:8080/uploads/' . basename($user['image']);
            
            // Return user data as JSON
            echo json_encode([
                'userID' => $user['userID'],
                'firstName' => $user['firstName'],
                'lastName' => $user['lastName'],
                'image' => $imageUrl
            ]);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'User not found']);
        }
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Database query failed']);
    }

    // Close database connection
    mysqli_close($conn);
} else {
    http_response_code(400);
    echo json_encode(['error' => 'userID parameter is missing']);
}
?>
