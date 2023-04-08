const express = require("express");
const mysql = require("mysql");
var cors = require("cors");
const myconn = require("express-myconnection");

//express.static(root, [options]);
//Para poder subir los cambios en fly.io es necesario poner fly deploy
const routes = require("./rutas");
const app = express();

/*app.set("port", process.env.Port || 3000);*/
const PORT = process.env.PORT || 3000;

const dbOptions = {
  host: "aws.connect.psdb.cloud",
  //port: 3307,
  user: "u3z7u9e8cywizj6oprkh",
  password: "pscale_pw_svVItih7QnozcATmiGRLnN3OYX6FKtCyfOgJAcGoekB",
  database: "servicio",
  ssl: {},
};

app.use("/", express.static("public"));
app.use(cors());
app.use(myconn(mysql, dbOptions, "single"));

app.use(express.json());

//rutas-------
app.get("/", (req, res) => {
  res.send("Bienvenido");
});

app.use("/api", routes);

/*app.get('/api',(req,res)=>{
    res.send('testeando Api')
})*/

//Iniciar el servidor---
/*app.listen(app.get("port"), () => {
  console.log("Server encendido en el puerto", app.get("port"));
});*/

app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`);
});
