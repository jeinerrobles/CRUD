
import 'package:crud/models/variables.dart';
import 'package:crud/peticiones/peticioneshttp.dart';
import 'package:crud/ui/content/articulos/crearCliente.dart';
import 'package:crud/ui/content/articulos/editarCliente.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ListaCliente extends StatefulWidget {

  @override
  _ListaClienteState createState() => _ListaClienteState();
}

class _ListaClienteState extends State<ListaCliente> {
  var colorestado = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white24,
       appBar: AppBar(
        title: Text('Lista Clientes'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              tooltip: 'Agregar Cliente',
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AdicionarClientes())).then((value) {
                  setState(() {
                    Refrescar();
                  });
                }); 
              })
        ],
      ), 
        body:  FutureBuilder(
    future: listarPost(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          return snapshot.data != null
      ? ListView.builder(
        itemCount: snapshot.data.length == 0 ? 0 : snapshot.data.length,
        itemBuilder: (context, posicion) {
          if(snapshot.data[posicion].ocupacion == 'Estudiante'){
                                colorestado = Colors.blue;
                              }else{
                                if(snapshot.data[posicion].ocupacion == 'Docente'){
                                colorestado = Colors.orange;
                                }
                              }
          return Card(
          child: ListTile(
           onTap: () {
             idcli = snapshot.data[posicion].idCliente;
             nombrecli = snapshot.data[posicion].nombre;
             ocupacioncli = snapshot.data[posicion].ocupacion;
             sisbencli = snapshot.data[posicion].sisben;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditarClientes())).then((value) {
                                setState(() {
                                  Refrescar();
                                });
                              });
                            },
    onLongPress: () {
      confirmaeliminar(context, snapshot.data[posicion].idCliente);
    },
    leading: CircleAvatar(
          backgroundImage: AssetImage("assets/usuario.png"),
        ), 
    title: Text(snapshot.data[posicion].nombre),
    subtitle: Text(snapshot.data[posicion].ocupacion+" - Nivel: "+snapshot.data[posicion].sisben ,style: TextStyle(color: colorestado)),
    trailing: Text(snapshot.data[posicion].idCliente,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    
          ),
      );
        })
      : Text('Sin Datos');

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Refrescar();
          });
        },
        tooltip: 'Refrescar',
        child: Icon(Icons.refresh),
      ),
          );
  }

  void confirmaeliminar(context, ideliminar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('¿Desea eliminar este cliente?'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                setState(() {
                  eliminarCliente(ideliminar);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class Refrescar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var colorestado = Colors.blue;
    return FutureBuilder(
    future: listarPost(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          return snapshot.data != null
      ? ListView.builder(
        itemCount: snapshot.data.length == 0 ? 0 : snapshot.data.length,
        itemBuilder: (context, posicion) {
          if(snapshot.data[posicion].ocupacion == 'Estudiante'){
                                colorestado = Colors.blue;
                              }else{
                                if(snapshot.data[posicion].ocupacion == 'Docente'){
                                colorestado = Colors.orange;
                                }
                              }
          return Card(
          child: ListTile(
    leading: CircleAvatar(
          backgroundImage: AssetImage("assets/usuario.png"),
        ), 
    title: Text(snapshot.data[posicion].nombre),
    subtitle: Text(snapshot.data[posicion].ocupacion +" - Nivel: "+snapshot.data[posicion].sisben , style: TextStyle(color: colorestado)),
    trailing: Text(snapshot.data[posicion].idCliente,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    
          ),
      );
        })
      : Text('Sin Datos');

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
  }
}

