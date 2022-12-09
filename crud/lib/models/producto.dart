class Producto {
  final String idproducto;
  final String tipo;
  final String nombre;
  final String precio;

  Producto(
      { this.idproducto,
       this.tipo,
       this.nombre,
       this.precio});

  factory Producto.fromJson(Map<String, dynamic> json)  {
    return Producto(
      idproducto: json['idproducto'] ,
      tipo: json['tipo'] ,
      nombre: json['nombre'] ,
      precio: json['precio'] ,
    );
  }


}
