var express = require("express");

var app = express();

app.get('/hello.txt', function(req, res){
  var body = 'Hello World';
  res.setHeader('Content-Type', 'text/plain');
  res.setHeader('Content-Length', Buffer.byteLength(body));
  res.end(body);
});


app.get("/users/:id", function(req,res){

});

app.post("/users/:id/topups", function(req,res) {

});

app.get("users/:user_id/topups/:topup_id", function(req,res) {
  // body...
});

app.listen(3000);
console.log('Listening on port 3000');