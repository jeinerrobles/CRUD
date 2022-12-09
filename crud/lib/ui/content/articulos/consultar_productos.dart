import 'dart:convert';

import 'package:crud/models/cliente.dart';
import 'package:crud/models/producto.dart';
import 'package:crud/models/variables.dart';
import 'package:crud/ui/content/articulos/crearVenta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ConsultarProductos extends StatefulWidget {

  @override
  _ConsultarProductosState createState() => _ConsultarProductosState();
}

class _ConsultarProductosState extends State<ConsultarProductos> {
  var colorestado = Colors.orange;
   TextEditingController controller = new TextEditingController();

  Future<Null> getUserDetails() async {
    final response = await http.get(Uri.parse(
      'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/listarproductos.php')
      );
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        _userDetails.add(Producto.fromJson(user));
      }
    });
  }


  List<Producto> _searchResult = [];
  List<Producto> _userDetails = [];

   onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.nombre.toUpperCase().contains(text.toUpperCase()) || 
      userDetail.tipo.toUpperCase().contains(text.toUpperCase()))
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
        title: Text('Seleccionar Producto'),
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
                      nombreproducto = _searchResult[i].nombre;
                       if(ocupacion == 'Estudiante'){
                        if(sisben == 'a'){
                          valorpagar = _searchResult[i].precio;
                          descuento = "15%";
                          var condescuento = double.parse(_searchResult[i].precio) * 0.15;
                          var aplicado = double.parse(_searchResult[i].precio) - condescuento;
                          totalpagar = aplicado.toString();
                        }else{
                        if(sisben == 'b'){
                          valorpagar = _searchResult[i].precio;
                          descuento = "10%";
                          var condescuento = double.parse(_searchResult[i].precio) * 0.10;
                          var aplicado = double.parse(_searchResult[i].precio) - condescuento;
                          totalpagar = aplicado.toString();
                        }else{
                          valorpagar = _searchResult[i].precio;
                          descuento = "No aplica";
                          totalpagar = _searchResult[i].precio;
                        }

                        }

                      }else{
                        valorpagar = _searchResult[i].precio;
                          descuento = "No aplica para docentes";
                          totalpagar = _searchResult[i].precio;
                      }
                      //print(_searchResult[i].nombre + _searchResult[i].tipo);
                      consultarproducto();
                    },
                    leading: CircleAvatar(
          backgroundImage: AssetImage("assets/copa.png"),), 
                    title: Text(_searchResult[i].nombre),
                    trailing:Text( _searchResult[i].tipo),
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
                      nombreproducto = _userDetails[index].nombre;
                       if(ocupacion == 'Estudiante'){
                        if(sisben == 'a'){
                          valorpagar = _userDetails[index].precio;
                          descuento = "15%";
                          var condescuento = double.parse(_userDetails[index].precio) * 0.15;
                          var aplicado = double.parse(_userDetails[index].precio) - condescuento;
                          totalpagar = aplicado.toString();
                        }else{
                        if(sisben == 'b'){
                          valorpagar = _userDetails[index].precio;
                          descuento = "10%";
                          var condescuento = double.parse(_userDetails[index].precio) * 0.10;
                          var aplicado = double.parse(_userDetails[index].precio) - condescuento;
                          totalpagar = aplicado.toString();
                        }else{
                          valorpagar = _userDetails[index].precio;
                          descuento = "No aplica";
                          totalpagar = _userDetails[index].precio;
                        }

                        }

                      }else{
                        valorpagar = _userDetails[index].precio;
                          descuento = "No aplica para docentes";
                          totalpagar = _userDetails[index].precio;
                      }
                      //print(_userDetails[index].nombre + _userDetails[index].tipo);
                      consultarproducto(); //AQUI QUE LE PASE EL PARAMETRO DE OCUPACION Y SISBEN
                    },
                    leading: CircleAvatar(
          backgroundImage: AssetImage("assets/copa.png"),), 
                    title:  Text(_userDetails[index].nombre),
                    trailing:Text(_userDetails[index].tipo),
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            ),)
        ],
        )
          );
  }
  void consultarproducto() async {
  
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                AdicionarVentas()));
                 
  }
}