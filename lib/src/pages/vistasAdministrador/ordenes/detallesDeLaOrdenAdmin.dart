import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/elevacion_container.dart';

class DetallesDeLaOrdenAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: verde),
          backgroundColor: amarillo,
          title: Text(
            "Detalles de la orden",
            style: TextStyle(
              color: Colors.black,
              fontSize: orientacion == Orientation.portrait
                  ? size.width * 0.045
                  : size.width * 0.023,
            ),
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              tarjetaAliado(context),
              texto(context: context, texto: 'Detalles'),
              tarjetaOrden(context),
              SizedBox(height: size.height * 0.005),
              tarjetaDireccion(context),
              SizedBox(height: size.height * 0.005),
              tarjetaTelefono(context),
              texto(context: context, texto: 'Pedido Realizado'),
              tarjetaPedido(
                  context: context,
                  cantidad: '2',
                  precio: '20.000',
                  producto: 'Mc Burguer'),
              SizedBox(height: size.height * 0.003),
              tarjetaPedido(
                  context: context,
                  cantidad: '2',
                  precio: '7.000',
                  producto: 'Postobon Manzana'),
              SizedBox(height: size.height * 0.02),
              tarjetaDomicilio(context: context, precio: '5.000'),
              SizedBox(height: size.height * 0.04),
              tarjetaFormaDePago(context: context, precio: '32.000'),
              SizedBox(height: size.height * 0.02),
              botones(context),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ));
  }

  Widget tarjetaAliado(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        Container(
          height: orientation == Orientation.portrait
              ? size.height * 0.12
              : size.height * 0.21,
          width: size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'cliente:',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: orientation == Orientation.portrait
                                    ? size.height * 0.022
                                    : size.height * 0.038),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Container(
                            width: orientation == Orientation.portrait
                                ? size.width * 0.5
                                : size.width * 0.7,
                            height: orientation == Orientation.portrait
                                ? size.height * 0.03
                                : size.height * 0.05,
                            child: Text('Cielo Rojas',
                                style: TextStyle(
                                    fontSize:
                                        orientation == Orientation.portrait
                                            ? size.height * 0.023
                                            : size.height * 0.039,
                                    color: Color.fromRGBO(103, 96, 95, 1))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                FadeInImage(
                    placeholder: NetworkImage(
                        'https://www.parservicios.com/images_home/ajax-loader.gif'),
                    image: NetworkImage(
                        'https://logos-marcas.com/wp-content/uploads/2020/04/McDonalds-Logo.png',
                        scale: 40))
              ],
            ),
          ),
        ),
        Container(
          height: orientation == Orientation.portrait
              ? size.width * 0.090
              : size.width * 0.058,
          width: size.width,
          color: verde,
          child: Center(
              child: Text(
            'Información del Pedido',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: orientation == Orientation.portrait
                    ? size.height * 0.015
                    : size.height * 0.035,
                color: Colors.white),
          )),
        )
      ],
    );
  }

  Widget tarjetaOrden(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Container(
      width: size.width,
      height: orientacion == Orientation.portrait
          ? size.height * 0.11
          : size.height * 0.22,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID Orden: D002',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: orientacion == Orientation.portrait
                        ? size.height * 0.020
                        : size.height * 0.036,
                  ),
                ),
                Text('Nueva',
                    style: TextStyle(
                        color: verde,
                        fontSize: orientacion == Orientation.portrait
                            ? size.height * 0.018
                            : size.height * 0.038))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: orientacion == Orientation.portrait
                      ? size.width * 0.35
                      : size.width * 0.20,
                  height: orientacion == Orientation.portrait
                      ? size.height * 0.045
                      : size.height * 0.080,
                  child: RaisedButton(
                      child: Text(
                        'VER MOTIVO',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: orientacion == Orientation.portrait
                              ? size.width * 0.035
                              : size.width * 0.025,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text('MOTIVO DE SOLICITUD'),
                                content: Text(
                                  'El Producto es Incorrecto ',
                                  style: TextStyle(color: rojo),
                                ),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Ok'))
                                ],
                              );
                            });
                      },
                      color: rojo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget tarjetaDireccion(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Container(
      width: size.width,
      height: orientacion == Orientation.portrait
          ? size.height * 0.11
          : size.height * 0.22,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Direccion',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: orientacion == Orientation.portrait
                          ? size.height * 0.020
                          : size.height * 0.036),
                ),
                Container(
                  width: orientacion == Orientation.portrait
                      ? size.width * 0.5
                      : size.width * 0.7,
                  height: orientacion == Orientation.portrait
                      ? size.height * 0.03
                      : size.height * 0.05,
                  child: Text('Los Ejecutivos - Mz40 Lt 38',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color.fromRGBO(103, 96, 95, 1),
                          fontSize: orientacion == Orientation.portrait
                              ? size.height * 0.018
                              : size.height * 0.038)),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Teimpo Estimado',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: orientacion == Orientation.portrait
                          ? size.height * 0.020
                          : size.height * 0.036),
                ),
                Text('40 Min',
                    style: TextStyle(
                        color: Color.fromRGBO(103, 96, 95, 1),
                        fontSize: orientacion == Orientation.portrait
                            ? size.height * 0.018
                            : size.height * 0.038))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget texto({BuildContext context, String texto, double arriba}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.015,
          ),
          Text(texto,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.grey,
                fontSize: orientacion == Orientation.portrait
                    ? size.width * 0.035
                    : size.width * 0.02,
              )),
        ],
      ),
    );
  }

  Widget tarjetaTelefono(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Container(
          width: size.width,
          height: orientacion == Orientation.portrait
              ? size.height * 0.11
              : size.height * 0.22,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telefono del Cliente',
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: orientacion == Orientation.portrait
                              ? size.height * 0.020
                              : size.height * 0.036),
                    ),
                    Text('310 6404303',
                        style: TextStyle(
                            color: Color.fromRGBO(103, 96, 95, 1),
                            fontSize: orientacion == Orientation.portrait
                                ? size.height * 0.018
                                : size.height * 0.028))
                  ],
                ),
              ],
            ),
          ),
        ),
        Elevacion()
      ],
    );
  }

  Widget tarjetaPedido(
      {BuildContext context, String producto, String precio, String cantidad}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;

    return Column(
      children: [
        Container(
          width: size.width,
          height: orientacion == Orientation.portrait
              ? size.height * 0.08
              : size.height * 0.18,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //  SizedBox( width: size.width*0.010, ),
                Text(
                  producto,
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: orientacion == Orientation.portrait
                          ? size.height * 0.020
                          : size.height * 0.036),
                ),
                SizedBox(
                  width: size.width * 0.020,
                ),
                Text(
                  cantidad,
                  style: TextStyle(
                      fontSize: orientacion == Orientation.portrait
                          ? size.height * 0.017
                          : size.height * 0.033),
                ),

                Text(
                  '\$ ' + precio,
                  style: TextStyle(
                      fontSize: orientacion == Orientation.portrait
                          ? size.height * 0.017
                          : size.height * 0.033),
                ),
              ],
            ),
          ),
        ),
        Elevacion()
      ],
    );
  }

  Widget tarjetaDomicilio({BuildContext context, String precio}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;

    return Column(
      children: [
        Container(
          width: size.width,
          height: orientacion == Orientation.portrait
              ? size.height * 0.08
              : size.height * 0.18,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //  SizedBox( width: size.width*0.010, ),
                Row(
                  children: [
                    Image(
                      image: AssetImage('assets/delivery-man.png'),
                      width: orientacion == Orientation.portrait
                          ? size.height * 0.05
                          : size.height * 0.08,
                    ),
                    SizedBox(
                      width: size.width * 0.015,
                    ),
                    Text(
                      'Domcilio',
                      style: TextStyle(
                          fontSize: orientacion == Orientation.portrait
                              ? size.height * 0.020
                              : size.height * 0.036),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width * 0.020,
                ),

                Text(
                  '\$ ' + precio,
                  style: TextStyle(
                      fontSize: orientacion == Orientation.portrait
                          ? size.height * 0.017
                          : size.height * 0.033),
                ),
              ],
            ),
          ),
        ),
        Elevacion(),
      ],
    );
  }

  Widget tarjetaFormaDePago({BuildContext context, String precio}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: size.width,
              height: orientacion == Orientation.portrait
                  ? size.height * 0.1
                  : size.height * 0.18,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //  SizedBox( width: size.width*0.010, ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forma de Pago ',
                          style: TextStyle(
                              fontSize: orientacion == Orientation.portrait
                                  ? size.height * 0.020
                                  : size.height * 0.036),
                        ),
                        SizedBox(
                            height: orientacion == Orientation.portrait
                                ? size.height * 0.008
                                : size.height * 0.015),
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                'assets/money-1.png',
                              ),
                              width: orientacion == Orientation.portrait
                                  ? size.height * 0.025
                                  : size.height * 0.042,
                            ),
                            SizedBox(
                                width: orientacion == Orientation.portrait
                                    ? size.width * 0.005
                                    : size.width * 0.005),
                            Text(
                              'Efectivo',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: orientacion == Orientation.portrait
                                      ? size.height * 0.018
                                      : size.height * 0.035),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.020,
                    ),

                    Text(
                      precio + ' \$',
                      style: TextStyle(
                          fontSize: orientacion == Orientation.portrait
                              ? size.height * 0.03
                              : size.height * 0.060),
                    ),
                  ],
                ),
              ),
            ),
            Elevacion()
          ],
        ),
      ],
    );
  }

  Widget botones(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: orientacion == Orientation.portrait
                  ? size.width * 0.8
                  : size.width * 0.5,
              height: orientacion == Orientation.portrait
                  ? size.height * 0.045
                  : size.height * 0.080,
              child: RaisedButton(
                child: Text(
                  'ACEPTAR SOLICITUD DE CANCELACIÓN',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: orientacion == Orientation.portrait
                        ? size.width * 0.035
                        : size.width * 0.025,
                  ),
                ),
                onPressed: () {},
                color: verde,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.width * 0.025,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: orientacion == Orientation.portrait
                  ? size.width * 0.45
                  : size.width * 0.30,
              height: orientacion == Orientation.portrait
                  ? size.height * 0.045
                  : size.height * 0.080,
              child: RaisedButton(
                child: Text(
                  'CANCELAR SOLICITUD',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: orientacion == Orientation.portrait
                        ? size.width * 0.035
                        : size.width * 0.025,
                  ),
                ),
                onPressed: () {},
                color: rojo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            Container(
              width: orientacion == Orientation.portrait
                  ? size.width * 0.35
                  : size.width * 0.20,
              height: orientacion == Orientation.portrait
                  ? size.height * 0.045
                  : size.height * 0.080,
              child: RaisedButton(
                  child: Text(
                    'REGRESAR',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: orientacion == Orientation.portrait
                          ? size.width * 0.035
                          : size.width * 0.025,
                    ),
                  ),
                  onPressed: () {},
                  color: negro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
