// Get the objects we need to modify
let updateTeacherForm = document.getElementById('update-teacher-form');

// Modify the objects we need
updateTeacherForm.addEventListener("submit", function (e) {
   
    // Prevent the form from submitting
    e.preventDefault();

    // Get form fields we need to get data from
    let inputFullName = document.getElementById("mySelect");
    let inputEmail = document.getElementById("input-email-update");

    // Get the values from the form fields
    let fullNameValue = inputFullName.value;
    let emailValue = inputEmail.value;
    
    

    if (!emailValue)
    {
        alert("please provide an email value");
    console.log(fullNameValue + " " + emailValue);
        return;
    }


    // Put our data we want to send in a javascript object
    let data = {
        fullname: fullNameValue,
        email: emailValue,
    }
    
    // Setup our AJAX request
    var xhttp = new XMLHttpRequest();
    xhttp.open("PUT", "/put-person", true);
    xhttp.setRequestHeader("Content-type", "application/json");

    // Tell our AJAX request how to resolve
    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 200) {

            // Add the new data to the table
            updateRow(xhttp.response, fullNameValue);
            
            inputFullName.value = 'Select a Teacher';
            inputEmail.value = '';

        }
        else if (xhttp.readyState == 4 && xhttp.status != 200) {
            console.log("There was an error with the input.")
        }
    }
    // Send the request and wait for the response
    xhttp.send(JSON.stringify(data));

})


function updateRow(data, teacherID){
    let parsedData = JSON.parse(data);
    
    let table = document.getElementById("teachers-table");

    for (let i = 0, row; row = table.rows[i]; i++) {
       //iterate through rows
       //rows would be accessed using the "row" variable assigned in the for loop
       if (table.rows[i].getAttribute("data-value") == teacherID) {

            // Get the location of the row where we found the matching person ID
            let updateRowIndex = table.getElementsByTagName("tr")[i];

            // Get td of email value
            let td = updateRowIndex.getElementsByTagName("td")[3];

            console.log("Found the row to update: " + i);
            // Reassign homeworld to our value we updated to
            td.innerHTML = parsedData[0].email; 
       }
    }
}