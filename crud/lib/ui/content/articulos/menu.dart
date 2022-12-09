import 'dart:convert';


import 'package:crud/login/loginF.dart';
import 'package:crud/ui/content/articulos/consultar_clientes.dart';
import 'package:crud/ui/content/articulos/listarCliente.dart';
import 'package:crud/ui/content/articulos/listarInforme.dart';
import 'package:crud/ui/content/articulos/listarProducto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class MenuH extends StatelessWidget {
  const MenuH({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'RubCar Pro Heladeria',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Colors.purple
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              const CircleAvatar(
                radius: 90,
                backgroundImage: NetworkImage(
                    "https://mir-s3-cdn-cf.behance.net/projects/404/17829191.548d0824c4592.png"),
              ),

              const SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.people)),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListaCliente(),)); 
                      },
                      child: const Text("Gestion de Clientes")),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_bag_outlined)),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListaProducto(),)); 
                      },
                      child: const Text("Gestion de Productos")),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConsultarUsuarios(),)); 
                      },
                      child: const Text("Registrar Venta")),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.report)),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                         var url = Uri.parse(
                              'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/ingresos.php');
                          var response =
                              await http.post(url, body: {'ingresos': ''});

                          var datos = jsonDecode(response.body);

                          var url2 = Uri.parse(
                              'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/numeroventas.php');
                          var response2 =
                              await http.post(url2, body: {'ventas': ''});

                          var datos2 = jsonDecode(response2.body);

                          var url3 = Uri.parse(
                              'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/masvendido.php');
                          var response3 =
                              await http.post(url3, body: {'ventas': ''});

                          var datos3 = jsonDecode(response3.body);
                          print(datos3[0]["producto"]);
                          
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => DatosUsuario(datos[0]["SUM(totalpago)"],datos2[0]["COUNT(*)"],datos3[0]["producto"]),)); 
                      },
                      child: const Text("Informe de Ventas")),
                  ),
                ],
              ),

              const SizedBox(
                height: 40,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => LoginF()));
                      },
                      child: const Text("Cerrar Sesion/Salir")),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
