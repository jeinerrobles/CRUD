class Venta {
  final int idventa;
  final String idcliente;
  final String producto;
  final String valorpago;
  final String descuento;
  final String totalpago;

  Venta(
      {
        this.idventa,
         this.idcliente,
       this.producto,
       this.valorpago,
       this.descuento,
       this.totalpago});

  factory Venta.fromJson(Map<String, dynamic> json) {
    return Venta(
      idventa: json['idventa'] ,
      idcliente: json['idcliente'] ,
      producto: json['producto'] ,
      valorpago: json['valorpago'] ,
      descuento: json['descuento'] ,
      totalpago: json['totalpago'] ,
    );
  }



}
