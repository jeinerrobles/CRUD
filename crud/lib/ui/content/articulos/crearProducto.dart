import 'dart:convert';
import 'dart:io';

import 'package:crud/models/variables.dart';
import 'package:crud/peticiones/peticioneshttp.dart';
import 'package:crud/widget/messagewidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class AdicionarProductos extends StatefulWidget {
  const AdicionarProductos({Key key}) : super(key: key);

  @override
  State<AdicionarProductos> createState() => _AdicionarProductosState();
}

  String tipo;
  var _tipo = ["Malteada", "Tradicional", "Ensalada"];
class _AdicionarProductosState extends State<AdicionarProductos> {
  
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlPrecio = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Productos"),
        //automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
                      'Tipo de producto',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.black),
                    ),
            DropdownButton(
                      isExpanded: true,
                      value: tipo,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconDisabledColor: Colors.red,
                      iconEnabledColor: Colors.red,
                      items: _tipo.map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                  color: Colors.black),
                            ));
                      }).toList(),
                      onChanged: changedDropDownItem,
                    ),
            
            
            
           
            TextField(
              controller: controlNombre,
              decoration: const InputDecoration(labelText: 'Ingrese el Nombre del Producto'),
            ),
            TextField(
              controller: controlPrecio,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Ingrese el Precio del Producto'),
            ),
            
            const SizedBox(
              height: 40,
            ),
            
            ElevatedButton(
                onPressed: () async {
                  if (tipo == 'Ensalada' || tipo == 'Tradicional' || tipo == 'Malteada' &&
                          controlNombre.text.isNotEmpty &&
                          controlPrecio.text.isNotEmpty) {
                             var url = Uri.parse(
                            'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/consultarproducto.php');
                              var response = await http.post(url, body: {'tipo': tipo, 'nombre': controlNombre.text});

                              var datos = jsonDecode(response.body);
                              if(datos == 0){
                                adicionarProducto(tipo, controlNombre.text, controlPrecio.text);
                            MessageWidget.confirmacion(
                            context, "Se guardo el producto correctamente", 3);
                              }else{
                                MessageWidget.advertencia(
                            context, "Este producto ya existe", 3);
                              }
                        
                      }else{
                        MessageWidget.advertencia(
                            context, "Hay campos vacios", 3);
                      } 
                   //cambio a toNamed
                },
                child: const Text("Guardar Producto")),
            
            const SizedBox(
              height: 10,
            ),
            
            ElevatedButton(
                onPressed: () async {
                  if (tipo == 'Ensalada' || tipo == 'Tradicional' || tipo == 'Malteada' &&
                          controlNombre.text.isNotEmpty &&
                          controlPrecio.text.isNotEmpty) {

                            var url = Uri.parse(
                            'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/consultarproducto.php');
                              var response = await http.post(url, body: {'tipo': tipo, 'nombre': controlNombre.text});

                              var datos = jsonDecode(response.body);
                              if(datos == 0){
                                MessageWidget.advertencia(
                            context, "Verifique nuevamente los datos a modificar", 3);
                              }else{
                                editarProducto(tipo, controlNombre.text, controlPrecio.text);
                            MessageWidget.confirmacion(
                            context, "Se modificó el producto correctamente", 3);
                              }
                       
                      }else{
                        MessageWidget.advertencia(
                            context, "Hay campos vacios", 3);
                      } 
                  
                }, 
                child: const Text("Modificar Producto")),

            const SizedBox(
              height: 10,
            ),
            
            
          ],
        ),
      ),
    );
  }
    void changedDropDownItem(selectedTipo) {
    setState(() {
      tipo = selectedTipo;
    });
  }

}