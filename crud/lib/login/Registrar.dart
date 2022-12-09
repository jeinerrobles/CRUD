import 'dart:convert';

import 'package:crud/peticiones/peticioneshttp.dart';
import 'package:crud/ui/content/articulos/menu.dart';
import 'package:crud/widget/messagewidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; 

import 'package:http/http.dart' as http;

class Registrar extends StatefulWidget {
  const Registrar({key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  TextEditingController controlUser = TextEditingController();
  TextEditingController controlPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(//dentro de un center con ctrl + punto --^
          padding: const EdgeInsets.all(8.0),
          child: Column(//dentro de un padding con ctrl + punto --^
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Registro',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Colors.purple
                ),
              ),

              const SizedBox(height: 30,),
              
              const CircleAvatar(
                radius: 90,
                backgroundImage: NetworkImage("https://mir-s3-cdn-cf.behance.net/projects/404/17829191.548d0824c4592.png"),
              ),

              const SizedBox(height: 30,),
              
              TextField(
                controller: controlUser,
                decoration: const InputDecoration(labelText: 'Ingrese el Correo/Usuario'),
              ),
              TextField(
                controller: controlPassword,
                obscureText: true,//para no visualizar los datos
                decoration: const InputDecoration(labelText: 'Ingrese la Contraseña'),
              ),

              const SizedBox(height: 20,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  const SizedBox(width: 20,),//para colocar un espacio entre widgets
                  
                  IconButton(onPressed: () {
                      if (controlUser.text.isNotEmpty &&
                            controlPassword.text.isNotEmpty) {
                        
                            verificarLogueo(controlUser.text,controlPassword.text);
                           } else {
                            MessageWidget.advertencia(
                            context, "Complete los campos usuario y contraseña para registrar", 4);
                      }
                       
                    //capturar error (usuario existente?) --> en proceso!
                    }, 
                    icon: const Icon(Icons.app_registration_rounded)
                  ),
                  const SizedBox(width: 1,),
                  const Text("Registrarse"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void verificarLogueo(usuario,contrasena) async {
  var url = Uri.parse(
      "https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/verificarregistro.php");

var response =  await http.post(url, body: {
    'usuario': usuario
  });
var datos = jsonDecode(response.body);
if(datos!= 0){

                   MessageWidget.advertencia(
                            context, "Este usuario o correo ya existe", 4);
}else{
  adicionarUsuario(usuario, contrasena);
  MessageWidget.confirmacion(
                            context, "Registrado correctamente", 4);
}
 
}
}
