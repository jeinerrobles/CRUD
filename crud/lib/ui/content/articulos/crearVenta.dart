
import 'package:crud/models/variables.dart';
import 'package:crud/widget/messagewidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../peticiones/peticioneshttp.dart';

class AdicionarVentas extends StatefulWidget {
  const AdicionarVentas({Key key}) : super(key: key);

  @override
  State<AdicionarVentas> createState() => _AdicionarVentasState();
}

class _AdicionarVentasState extends State<AdicionarVentas> {
  TextEditingController controlIdCliente = TextEditingController(text: idcliente);
  TextEditingController controlProducto = TextEditingController(text: nombreproducto);
  TextEditingController controlValorPago = TextEditingController(text: valorpagar);
  TextEditingController controlDescuento = TextEditingController(text: descuento);
  TextEditingController controlTotalPago = TextEditingController(text: totalpagar);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Ventas"),
        //automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
              controller: controlIdCliente,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Id del Cliente'),
            ),
            TextField(
              controller: controlProducto,
              decoration: const InputDecoration(labelText: 'Nombre del Producto'),
            ),
            TextField(
              controller: controlValorPago,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor del Pago'),
            ),
            TextField(
              controller: controlDescuento,
              decoration: const InputDecoration(labelText: 'Descuento'),
            ),
            TextField(
              controller: controlTotalPago,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Total del Pago'),
            ),
            
            const SizedBox(height: 40,),
            
            ElevatedButton(
              onPressed: () {
                if (controlIdCliente.text.isNotEmpty &&
                          controlProducto.text.isNotEmpty &&
                          controlValorPago.text.isNotEmpty &&
                          controlDescuento.text.isNotEmpty &&
                          controlTotalPago.text.isNotEmpty) {
                        adicionarVenta(controlIdCliente.text, controlProducto.text, controlValorPago.text, controlDescuento.text, controlTotalPago.text);
                            MessageWidget.confirmacion(
                            context, "Se guardo la venta correctamente", 3);
                      }else{
                        MessageWidget.advertencia(
                            context, "Hay campos vacios", 3);
                      } 
                
              },
              child: const Text("Guardar Venta")
            ),

            const SizedBox(height: 10,),
            
            
          ],
        ),
      ),
    );
  }
}
