const express = require("express");
const routes = express.Router();

//Leer
routes.get("/", (req, res) => {
  //res.send('testeando Api')
  req.getConnection((err, conn) => {
    if (err) return res.send(err);

    conn.query("SELECT * FROM Producto", (err, rows) => {
      if (err) return res.send(err);

      res.json(rows);
    });
  });
});

//Insertar
routes.post("/nuevo", (req, res) => {
  req.getConnection((err, conn) => {
    if (err) return res.send(err);
    //console.log(req.body)
    conn.query("INSERT INTO Producto set ?", [req.body], (err, rows) => {
      if (err) return res.send(err);

      res.json(req.body);
    });
  });
});

//Actualizar
routes.put("/actualizar/:id", (req, res) => {
  req.getConnection((err, conn) => {
    if (err) return res.send(err);
    conn.query(
      "UPDATE Producto set ? WHERE id = ?",
      [req.body, req.params.id],
      (err, rows) => {
        if (err) return res.send(err);

        res.json(req.body);
      }
    );
  });
});

//Eliminar
routes.delete("/eliminar/:id", (req, res) => {
  req.getConnection((err, conn) => {
    if (err) return res.send(err);
    conn.query(
      "DELETE FROM Producto WHERE id = ?",
      [req.params.id],
      (err, rows) => {
        if (err) return res.send(err);

        //res.json(rows)
        res.json({ rows });
      }
    );
  });
});

//Buscar por url
//http://localhost:9000/api/ver?id=1&nombre=Agendas&img=https://api.com&precio=4355&fechaCracion=15-02-2023
routes.get("/ver", (req, res) => {
  const requestquery = req.query;
  //console.log(query);

  req.getConnection((err, conn) => {
    if (err) {
      return res.send(err);
    }
    //res.json(requestquery);
    conn.query(
      "SELECT * FROM Producto WHERE id = ?",
      [requestquery.id],
      (err, rows) => {
        if (err) {
          return res.send(err);
        }
        res.json(rows);
        //res.json(requestquery);
      }
    );
  });
});

module.exports = routes;

//node server.js
//npm run start
