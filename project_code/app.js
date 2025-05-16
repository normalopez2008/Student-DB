//Citation for the following function:
//Date: 05/22/2024
//Based on 
//Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/

/*
  SETUP
*/
const express = require('express');
const app = express();
app.use(express.json())
app.use(express.urlencoded({extended: true}))

const path = require('path');
var db = require('./database/db_connector.js');

const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.



// Serve static files from the 'public' directory
app.use(express.static('public'))
//app.use(express.static(path.join(__dirname, 'public')));

// Start the server
const PORT = 6464;


/*
    ROUTES
*/
app.get('/', function(req, res)
    {  
            res.render('index');
    });                                                 // will process this file, before sending the finished HTML to the client.

app.get('/teachers', function(req, res)
    {  
        let query1 = "SELECT * FROM Teachers;";               // Define our query

        db.pool.query(query1, function(error, rows, fields){    // Execute the query

            res.render('teachers', {data: rows});                  // Render the index.hbs file, and also send the renderer
        })                                                      // an object where 'data' is equal to the 'rows' we
    });                                                 // will process this file, before sending the finished HTML to the client.

app.post('/add-teacher', function(req, res) 
{
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;


    // Create the query and run it on the database
    query1 = `INSERT INTO Teachers (first_name, last_name, email) VALUES ('${data.first_name}', '${data.last_name}', '${data.email}')`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }
        else
        {
            // If there was no error, perform a SELECT * on bsg_people
            query2 = `SELECT * FROM Teachers;`;
            db.pool.query(query2, function(error, rows, fields){

                // If there was an error on the second query, send a 400
                if (error) {
                    
                    // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
                    console.log(error);
                    res.sendStatus(400);
                }
                // If all went well, send the results of the query back.
                else
                {
                    res.send(rows);
                }
            })
        }
    })
});

app.delete('/delete-teacher', function(req,res,next){
    let data = req.body;
    let teacherID = parseInt(data.id);
    let deleteClass = `DELETE FROM Classes WHERE teacher_id = ?`;
    let deleteTeacher = `DELETE FROM Teachers WHERE teacher_id = ?`;
  
            //first query is commented out because classes database has not been implemented yet
          // Run the 1st query
          /*db.pool.query(deleteClass, [teacherID], function(error, rows, fields){
              if (error) {
  
              // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
              console.log(error);
              res.sendStatus(400);
              }
  
              else
              {*/
                  // Run the second query
                  console.log("the teacher id is " + teacherID)
                  db.pool.query(deleteTeacher, [teacherID], function(error, rows, fields) {
  
                      if (error) {
                          console.log(error);
                          res.sendStatus(400);
                      } else {
                          res.sendStatus(204);
                      }
                  })
              }
            );//})});

    app.put('/put-person', function(req,res,next){
        let data = req.body;
        
        let email = data.email;
        let teacherID = parseInt(data.fullname);
        
        let queryUpdateTeachers = `UPDATE Teachers SET email = ? WHERE teacher_id = ?`;
        let selectTeachers = `SELECT * FROM Teachers WHERE teacher_id = ?`
        
                // Run the 1st query
                db.pool.query(queryUpdateTeachers, [email, teacherID], function(error, rows, fields){
                    if (error) {
        
                    // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
                    console.log(error);
                    res.sendStatus(400);
                    }
        
                    // If there was no error, we run our second query and return that data so we can use it to update the people's
                    // table on the front-end
                    else
                    {
                        // Run the second query
                        db.pool.query(selectTeachers, [teacherID], function(error, rows, fields) {
        
                            if (error) {
                                console.log(error);
                                res.sendStatus(400);
                            } else {
                                res.send(rows);
                            }
                        })
                    }
        })});

/*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});
/*
const pageLinks = {
    teachers: "index.html",
    students: "students.html",
    enrollments: "enrollments.html",
    classes: "classes.html",
    tests: "tests.html",
    disciplinaryIncidents: "disciplinary_incidents.html"
};

// Function to generate HTML for the navigation links
function generateNavigationLinks() {
    // Get the container element where the links will be placed
    const navContainer = document.getElementById("nav-container");

    // Iterate over each key-value pair in the pageLinks object
    for (const [page, link] of Object.entries(pageLinks)) {
        // Create a new anchor element
        const anchor = document.createElement("a");
        // Set the href attribute to the corresponding link
        anchor.href = link;
        // Set the innerHTML to the capitalized page name
        anchor.innerHTML = page.charAt(0).toUpperCase() + page.slice(1);
        // Append the anchor element to the navContainer
        navContainer.appendChild(anchor);

        // Add a space between links
        navContainer.appendChild(document.createTextNode(" | "));
    }
}

// Call the function to generate navigation links when the page loads
window.onload = function () {
    generateNavigationLinks();
};
*/