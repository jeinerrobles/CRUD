class Cliente {
  final String idCliente;
  final String nombre;
  final String ocupacion;
  final String sisben;

  Cliente(
      { this.idCliente,
       this.nombre,
       this.ocupacion,
       this.sisben});

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      idCliente: json['idcliente'],
      nombre: json['nombre'],
      ocupacion: json['ocupacion'],
      sisben: json['sisben'],
    );
  }
}
