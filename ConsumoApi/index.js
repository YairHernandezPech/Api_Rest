//Añadir
var añadir = document.getElementById("añadir");
añadir.addEventListener("submit", function (e) {
  e.preventDefault();
  var id = document.getElementById("id").value;
  var nombre = document.getElementById("nombre").value;
  var img = document.getElementById("img").value;
  var precio = document.getElementById("precio").value;
  var fechaCracion = document.getElementById("fechaCracion").value;

  //fech request
  fetch("https://my-api-rest.fly.dev/api/nuevo", {
    method: "POST",
    body: JSON.stringify({
      id: id,
      nombre: nombre,
      img: img,
      precio: precio,
      fechaCracion: fechaCracion,
    }),
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
  })
    .then(function (response) {
      return response.json();
    })
    .then(function (data) {
      console.log(data);
    });
});

//Consumir api
let url = "https://my-api-rest.fly.dev/api";
fetch(url)
  .then((response) => response.json())
  .then((data) => mostrarData(data))
  .catch((error) => console.log(error));

const mostrarData = (data) => {
  console.log(data);
  let body = "";
  for (var i = 0; i < data.length; i++) {
    body += `<tr><td>${data[i].id}</td><td>${data[i].nombre}</td><td>${data[i].img}</td><td>${data[i].precio}</td><td>${data[i].fechaCracion}</td></tr>`;
  }
  document.getElementById("data").innerHTML = body;
  //console.log(body)
};

//Eliminar
function Eliminar() {
  let eliminar = document.getElementById("eliminar");
  fetch(`https://my-api-rest.fly.dev/api/eliminar/${eliminar.id.value}`, {
    method: "DELETE",
  }).catch((err) => console.log(err));
}

//Actualizar
async function Actualizar() {
  let actualizar = document.getElementById("actualizar");

  const obj = {};
  new FormData(actualizar).forEach((value, key) => (obj[key] = value));

  fetch(`https://my-api-rest.fly.dev/api/actualizar/${actualizar.id.value}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(obj),
  })
    .then((res) => res.json())
    .catch((err) => console.log(err));
}

/*Enviar*/
function enviar1() {
  swal("API REST", "Producto Añadido", "success");
}
function enviar2() {
  swal("API REST", "Producto Actualizado", "success");
}
function enviar3() {
  swal("Gracias", "Producto Eliminado", "success");
}
