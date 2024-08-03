<?php 
    include 'conn.php';
    $jsonData = file_get_contents('php://input');
    $data = json_decode($jsonData, true);
    if($data !== null){
        
        $query = mysqli_query($conn, "SELECT * FROM food WHERE foodtype = 'weightgain' AND mealtime = 'breakfast'");
        
        if(mysqli_num_rows($query) > 0){
            $resultArray = array();
            while($row = mysqli_fetch_assoc($query))
                $resultArray[] = $row;

           echo(json_encode($resultArray));
           mysqli_close($conn);
        }

    } else {
        http_response_code(400);
        echo "Invalid JSON data";
    }
?>