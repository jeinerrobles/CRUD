
import 'dart:convert';

import 'package:crud/models/variables.dart';
import 'package:crud/peticiones/peticioneshttp.dart';
import 'package:crud/widget/messagewidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class AdicionarClientes extends StatefulWidget {
  const AdicionarClientes({Key key}) : super(key: key);

  @override
  State<AdicionarClientes> createState() => _AdicionarClientesState();
}

 String tipo;
  var _tipo = ["Estudiante", "Docente"];
   String sisben;
  var _sisben = ["a", "b", "c", "d", "Ninguno"];

 
class _AdicionarClientesState extends State<AdicionarClientes> {
  TextEditingController controlIdCliente = TextEditingController();
  TextEditingController controlNombre = TextEditingController();
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Clientes"),
        //automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
              controller: controlIdCliente,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Ingrese el Id del Cliente'),
            ),
            TextField(
              controller: controlNombre,
              decoration: const InputDecoration(labelText: 'Ingrese el Nombre del Cliente'),
            ),
            SizedBox(
                      height: 10,
                    ),
             Text(
                      'Ocupación',
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

                    Text(
                      'Sisben',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.black),
                    ),
            DropdownButton(
                      isExpanded: true,
                      value: sisben,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconDisabledColor: Colors.red,
                      iconEnabledColor: Colors.red,
                      items: _sisben.map((String items) {
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
                      onChanged: changedDropDownItem2,
                    ),
            
           
            
            const SizedBox(height: 40,),

            ElevatedButton(
              onPressed: () async {
                if (controlIdCliente.text.isNotEmpty && controlNombre.text.isNotEmpty ) {
                             var url = Uri.parse(
                            'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/consultarcliente.php');
                              var response = await http.post(url, body: {'idcliente': controlIdCliente.text});

                              var datos = jsonDecode(response.body);
                              if(datos == 0){
                                adicionarCliente(controlIdCliente.text, controlNombre.text, tipo, sisben);
                            MessageWidget.confirmacion(
                            context, "Se guardo el cliente correctamente", 3);
                              }else{
                                MessageWidget.advertencia(
                            context, "Este cliente ya existe", 3);
                              }
                        
                      }else{
                        MessageWidget.advertencia(
                            context, "Hay campos vacios", 3);
                      } 
                
                
              },
              child: const Text("Guardar Cliente")
            ),

            const SizedBox(height: 10,),

            ElevatedButton(
              onPressed: () async {
                if (controlIdCliente.text.isNotEmpty && controlNombre.text.isNotEmpty ) {
                             var url = Uri.parse(
                            'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/consultarcliente.php');
                              var response = await http.post(url, body: {'idcliente': controlIdCliente.text});

                              var datos = jsonDecode(response.body);
                              if(datos == 0){
                                MessageWidget.advertencia(
                            context, "Verifique nuevamente los datos a modificar", 3);
                              }else{
                               editarCliente(controlIdCliente.text, controlNombre.text, tipo, sisben);
                            MessageWidget.confirmacion(
                            context, "Se modificó el cliente correctamente", 3);
                              }
                        
                      }else{
                        MessageWidget.advertencia(
                            context, "Hay campos vacios", 3);
                      } 
              },
              child: const Text("Modificar Cliente")
            ),

            const SizedBox(height: 10,),

            
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
  void changedDropDownItem2(selectedTipo) {
    setState(() {
      sisben = selectedTipo;
    });
  }
}
