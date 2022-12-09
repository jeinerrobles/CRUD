import 'dart:async';
import 'dart:convert';

import 'package:crud/models/producto.dart';
import 'package:crud/models/variables.dart';
import 'package:crud/models/venta.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/cliente.dart';


Future<List<Cliente>> listarPost(http.Client client) async {
 
  final response = await http.get(Uri.parse(
      'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/listarclientes.php'));

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListas, response.body);
}

// Una función que convierte el body de la respuesta en un List<Photo>
List<Cliente> pasaraListas(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Cliente>((json) => Cliente.fromJson(json)).toList();
}

///////////////////////////////////////////

Future<List<Producto>> listarPostt(http.Client client) async {
 
  final response = await http.get(Uri.parse(
      'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/listarproductos.php'));

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListass, response.body);
}

List<Producto> pasaraListass(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Producto>((json) => Producto.fromJson(json)).toList();
}

//////////////////////////////////////////////////

Future<List<Venta>> listarPostv(http.Client client) async {
 
  final response = await http.get(Uri.parse(
      'https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/listarventas.php'));

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListasv, response.body);
}

List<Venta> pasaraListasv(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Venta>((json) => Venta.fromJson(json)).toList();
}
// Una función que convierte el body de la respuesta en un List<Photo>

void adicionarUsuario(
    String usuario,
    String contrasena) async {
  var url = Uri.parse(
      "https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/adicionarusuario.php");

  await http.post(url, body: {
    'usuario': usuario,
    'contrasena': contrasena,
});
}

void adicionarCliente(
    String idCliente,
    String nombre,
    String ocupacion,
    String sisben,) async {
  var url = Uri.parse(
      "https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/adicionarcliente.php");

  await http.post(url, body: {
    'idcliente': idCliente,
    'nombre': nombre,
    'ocupacion': ocupacion,
    'sisben': sisben,
  });
}

void editarCliente(
    String idCliente,
    String nombre,
    String ocupacion,
    String sisben,) async {
  var url = Uri.parse(
      "https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/modificarcliente.php");

  await http.post(url, body: {
    'idcliente': idCliente,
    'nombre': nombre,
    'ocupacion': ocupacion,
    'sisben': sisben,
  });
}

void adicionarProducto(
   // String idproducto,
    String tipo,
    String nombre,
    String precio,) async {
  var url = Uri.parse(
      "https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/adicionarproducto.php");

  await http.post(url, body: {
  //  'idproducto': idproducto,
    'tipo': tipo,
    'nombre': nombre,
    'precio': precio,
  });
}

void editarProducto(
    String tipo,
    String nombre,
    String precio,) async {
  var url = Uri.parse(
      "https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/modificarproducto.php");

  await http.post(url, body: {
    'tipo': tipo,
    'nombre': nombre,
    'precio': precio,
  });
}

void adicionarVenta(
   // String idventa,
    String idcliente,
    String producto,
    String valorpago,
    String descuento,
    String totalpago,) async {
  var url = Uri.parse(
      "https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/adicionarventa.php");

  await http.post(url, body: {
  //  'id': idventa,
    'idcliente': idcliente,
    'producto': producto,
    'valorpago': valorpago,
    'descuento': descuento,
    'totalpago': totalpago,
  });
}

void eliminarCliente(idcliente) async {
  var url = Uri.parse(
      "https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/eliminarcliente.php");

  await http.post(url, body: {
    'idcliente': idcliente,
  });
}

void eliminarProducto(idproducto) async {
  var url = Uri.parse(
      "https://rubcarproheladeria.000webhostapp.com/proyectoheladeria/eliminarproducto.php");

  await http.post(url, body: {
    'idproducto': idproducto,
  });
}





 