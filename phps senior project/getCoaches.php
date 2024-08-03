<?php 
    include 'conn.php';
    $jsonData = file_get_contents('php://input');
    $data = json_decode($jsonData, true);
    if($data !== null){
        $id = $data['id'];
        
//jebna l id wl pass mn android studio la naamel fihon li badna ye        
        $query = mysqli_query($conn, "SELECT * FROM `users` WHERE `role` =`$id`");
        if(mysqli_num_rows($query)>0){
            $emparray = array();
            while($row = mysqli_fetch_assoc($query))
                $emparray[] = $row;

           echo(json_encode($emparray));
           mysqli_close($conn);
        }

    }else{
        http_response_code(400);
        echo "Invalid JSON data";
    }
?>
