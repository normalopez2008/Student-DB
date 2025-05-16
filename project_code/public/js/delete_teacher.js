//Citation for the following function:
//Date: 05/22/2024
//Based on 
//Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/

function deleteTeacher(teacherID) {
    // Put our data we want to send in a javascript object
    let data = {
        id: teacherID
    };

    // Setup our AJAX request
    var xhttp = new XMLHttpRequest();
    xhttp.open("DELETE", "/delete-teacher", true);
    xhttp.setRequestHeader("Content-type", "application/json");

    // Tell our AJAX request how to resolve
    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 204) {

            // Add the new data to the table
            deleteRow(teacherID);

        }
        else if (xhttp.readyState == 4 && xhttp.status != 204) {
            console.log("There was an error with the input. teacherid: " + teacherID)
        }
    }
    // Send the request and wait for the response
    xhttp.send(JSON.stringify(data));
}


function deleteRow(teacherID){

    let table = document.getElementById("teachers-table");
    for (let i = 0, row; row = table.rows[i]; i++) {
       //iterate through rows
       //rows would be accessed using the "row" variable assigned in the for loop
       if (table.rows[i].getAttribute("data-value") == teacherID) {
            table.deleteRow(i);
            break;
       }
    }
}