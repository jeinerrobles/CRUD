
import 'package:crud/models/variables.dart';
import 'package:crud/peticiones/peticioneshttp.dart';
import 'package:crud/ui/content/articulos/crearCliente.dart';
import 'package:crud/ui/content/articulos/crearProducto.dart';
import 'package:crud/ui/content/articulos/editarproducto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ListaProducto extends StatefulWidget {

  @override
  _ListaProductoState createState() => _ListaProductoState();
}

class _ListaProductoState extends State<ListaProducto> {
  var colorestado = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white12,
       appBar: AppBar(
        title: Text('Listar Productos'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              tooltip: 'Agregar producto',
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AdicionarProductos())).then((value) {
                  setState(() {
                    Refrescar();
                  });
                }); 
              })
        ],
      ), 
        body:  FutureBuilder(
    future: listarPostt(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
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
          if(snapshot.data[posicion].tipo == 'Tradicional'){
                                colorestado = Colors.blue;
                              }else{
                                if(snapshot.data[posicion].tipo == 'Malteada'){
                                colorestado = Colors.orange;
                                }else{
                                  if(snapshot.data[posicion].tipo == 'Ensalada'){
                                    colorestado = Colors.green;
                                  }
                                }
                              }
          return Card(
          child: ListTile(
           onTap: () {
             tipoprod = snapshot.data[posicion].tipo;
             nombreprod = snapshot.data[posicion].nombre;
             precioprod = snapshot.data[posicion].precio;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditarProductos())).then((value) {
                                setState(() {
                                  Refrescar();
                                });
                              });
                            },
    onLongPress: () {
      confirmaeliminar(context, snapshot.data[posicion].idproducto);
    },
    leading: CircleAvatar(
          backgroundImage: AssetImage("assets/copa.png"),), 
    title: Text(snapshot.data[posicion].nombre),
    subtitle: Text(snapshot.data[posicion].tipo,style: TextStyle(color: colorestado)),
    trailing: Text(snapshot.data[posicion].precio,
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
          content: Text('¿Desea eliminar este producto?'),
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
                  eliminarProducto(ideliminar);
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
    future: listarPostt(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
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
          if(snapshot.data[posicion].tipo == 'Tradicional'){
                                colorestado = Colors.blue;
                              }else{
                                if(snapshot.data[posicion].tipo == 'Malteada'){
                                colorestado = Colors.orange;
                                }else{
                                  if(snapshot.data[posicion].tipo == 'Ensalada'){
                                    colorestado = Colors.green;
                                  }
                                }
                              }
          return Card(
          child: ListTile(
    leading: CircleAvatar(
          backgroundImage: AssetImage("assets/copa.png"),
        ), 
    title: Text(snapshot.data[posicion].nombre),
    subtitle: Text(snapshot.data[posicion].tipo, style: TextStyle(color: colorestado)),
    trailing: Text(snapshot.data[posicion].precio,
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