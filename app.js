var express = require("express");

var app = express();
app.use(express.bodyParser());

var users = {
  "2046" : {
    "name" : "Hurry Sadu"
  },
  "1111" : {
    "name" : "John Bacon"
  }
}

var topups = {};
var payments = {};

app.get('/hello.txt', function(req, res){
  var body = 'Hello World';
  res.setHeader('Content-Type', 'text/plain');
  res.setHeader('Content-Length', Buffer.byteLength(body));
  res.end(body);
});


app.get("/users/:id", function(req,res){
  var id = req.params.id +"";
  console.log("user id:" + id);
  var user = users[id];
  var body = JSON.stringify(user);

  res.setHeader('Content-Type', 'application/json');
  res.setHeader('Content-Length', Buffer.byteLength(body));
  res.end(body);
});

app.get("/topups/:token_id", function(req,res) {
  var token_id = req.params.token_id;
  topup = topups[token_id];
  
  console.log("get token:"+token_id);
  console.log("get token topup:"+JSON.stringify(topup));
  if((!!topup) && topup["token"] === token_id) {
    console.log("here!!");
    var body = JSON.stringify(topup);
    res.setHeader('Content-Type', 'application/json');
    res.setHeader('Content-Length', Buffer.byteLength(body));
    res.end(body);
  } else {
    var body = JSON.stringify({"valid":false});
    res.setHeader('Content-Type', 'application/json');
    res.setHeader('Content-Length', Buffer.byteLength(body));
    res.end(body);
  }
});

app.post("/topups/:token_id", function(req,res) {
  var topup = req.body.topup;
  var token = req.body.token;
  console.log("post topup tokenID:"+token);
  console.log("post topup :"+topup);

  topups[token] = {"val" : topup, "valid" : true, "token": token};

  var body = '';
  res.setHeader('Content-Type', 'application/json');
  res.setHeader('Content-Length', Buffer.byteLength(body));
  res.end(body);
});

app.post("/payments/:token_id", function (req,res) {
  var token_id = req.params.token_id;
  payments[token_id] = {"paid" : true};

  var body = '';
  res.setHeader('Content-Type', 'application/json');
  res.setHeader('Content-Length', Buffer.byteLength(body));
  res.end(body);
})

app.get("/payments/:token_id", function (req,res) {
  var token_id = req.params.token_id;
  var payment = payments[token_id]

  if((!!payment) && payment["paid"]) {
    var body = JSON.stringify(payment);
    res.setHeader('Content-Type', 'application/json');
    res.setHeader('Content-Length', Buffer.byteLength(body));
    res.end(body);
  } else {
    var body = JSON.stringify({"paid":false});
    res.setHeader('Content-Type', 'application/json');
    res.setHeader('Content-Length', Buffer.byteLength(body));
    res.end(body);
  }
})

var port = Number(process.env.PORT || 3000);
app.listen(port, function() {
  console.log("Listening on " + port);
});