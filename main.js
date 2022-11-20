let express = require('express');
let app = express();
let mysql = require('mysql');
let ejs=require('ejs');

app.use(express.static("public"))
app.set('view engine', 'html');
app.engine('html',ejs.renderFile);

const router = require("./routes/routes")
app.use("/", router)

app.listen(3011, 'localhost', function() {
});