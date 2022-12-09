import 'package:flutter/material.dart';


class DatosUsuario extends StatelessWidget {
  final ingresos;
  final numeroventas;
  final masvendido;

  DatosUsuario( this.ingresos, this.numeroventas, this.masvendido);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
        appBar: AppBar(
          title: Text('Totales'),
          backgroundColor: Colors.redAccent,
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            height: 460,
            width: double.maxFinite,
            child: Card(
              color: Colors.redAccent,
              elevation: 5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    left: (MediaQuery.of(context).size.width / 2) - 55,
                    child: Container(
                      height: 100,
                      width: 100,
                      //color: Colors.blue,
                      child: Card(
                        color: Colors.redAccent,
                        elevation: 2,
                        child: Image.asset('assets/cheque.png'),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text('TOTAL INGRESO',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                              Text('COP:'+ this.ingresos,style: TextStyle(color: Colors.white)),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('PRODUCTO MAS VENDIDO',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      Text(this.masvendido,style: TextStyle(color: Colors.white)),
                                      
                                    ],
                                  ),
                                  
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                             Column(
                              children: [
                                Text('VENTAS REALIZADAS',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                CircleAvatar(
                                  child: Text(this.numeroventas,
                                      style: TextStyle(color: Colors.white)),
                                  backgroundColor: int.parse(this.numeroventas)< 1
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ],
                            ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      );
  }
}


