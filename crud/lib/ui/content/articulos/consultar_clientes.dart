import 'dart:convert';


import 'package:crud/models/cliente.dart';
import 'package:crud/models/variables.dart';
import 'package:crud/ui/content/articulos/consultar_productos.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ConsultarUsuarios extends StatefulWidget {

  @override
  _ConsultarUsuariosState createState() => _ConsultarUsuariosState();
}

class _ConsultarUsuariosState extends State<ConsultarUsuarios> {
  var colorestado = Colors.orange;
   TextEditingController controller = new TextEditingController();

  Future<Null> getUserDetails() async {
    final response = await http.get(Uri.parse(
      'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/listarclientes.php')
      );
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        _userDetails.add(Cliente.fromJson(user));
      }
    });
  }


  List<Cliente> _searchResult = [];
  List<Cliente> _userDetails = [];

   onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.nombre.toUpperCase().contains(text.toUpperCase()) || 
      userDetail.idCliente.toUpperCase().contains(text.toUpperCase()))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }

@override
  void initState() {
    super.initState();

    getUserDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white12,
       appBar: AppBar(
        title: Text('Seleccionar Cliente'),
        backgroundColor: Colors.redAccent,
      ),
        body:  Column(
        children: [
          SizedBox(
                height: 5,
              ),
              Container(
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Buscar', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },),
                ),
              ),
            ),
          ),
        SizedBox(
                height: 5,
              ),
        Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return new Card(
                  child: new ListTile(
                    onTap: () {
                      idcliente = _searchResult[i].idCliente;
                      ocupacion = _searchResult[i].ocupacion;
                      sisben = _searchResult[i].sisben;
                     
                      //print(_searchResult[i].idCliente + _searchResult[i].ocupacion + _searchResult[i].sisben);
                      consultarusuario();
                    },
                    leading: CircleAvatar(
          backgroundImage: AssetImage("assets/usuario.png"),), 
                    title: Text(_searchResult[i].nombre),
                    trailing:Text( _searchResult[i].idCliente),
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            )
                : new ListView.builder(
              itemCount: _userDetails.length,
              itemBuilder: (context, index) {
                return new Card(
                  child: new ListTile(
                    onTap: () {
                      idcliente = _userDetails[index].idCliente;
                      ocupacion = _userDetails[index].ocupacion;
                      sisben = _userDetails[index].sisben;
                      //print(_userDetails[index].idCliente + _userDetails[index].ocupacion + _userDetails[index].sisben);
                      consultarusuario(); //AQUI QUE LE PASE EL PARAMETRO DE OCUPACION Y SISBEN
                    },
                    leading: CircleAvatar(
          backgroundImage: AssetImage("assets/usuario.png"),), 
                    title:  Text(_userDetails[index].nombre),
                    trailing:Text(_userDetails[index].idCliente),
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            ),)
        ],
        )
          );
  }
  void consultarusuario() async {
  
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ConsultarProductos()));
                 
  }
}


