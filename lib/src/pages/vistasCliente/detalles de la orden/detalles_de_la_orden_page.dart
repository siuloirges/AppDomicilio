// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:traelo_app/src/pages/vistasAliado/perfilAliado/editarUsuario.dart';
// import 'package:traelo_app/src/pages/vistasCliente/misOrdenes/models/respMisOrdenesModels.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

import 'models/respDetallePedido.dart';

// import 'models/respDetallePedido.dart';

class DetallesDeLaOrden extends StatefulWidget {
  @override
  _DetallesDeLaOrdenState createState() => _DetallesDeLaOrdenState();
}

class _DetallesDeLaOrdenState extends State<DetallesDeLaOrden> {
  TextEditingController motivoController =new TextEditingController();
  Funciones funciones = new Funciones();
  Map<String, dynamic> element;
  PeticionesHttpProvider _http = PeticionesHttpProvider();
  PreferenciasUsuario pref = PreferenciasUsuario();

  List globalresp = [];
  var formatter;
  bool peticion = false;

  @override
  Widget build(BuildContext context) {
    element = ModalRoute.of(context).settings.arguments;
    formatter = new NumberFormat("###,###,###", "es-co");

    if (peticion == false) {
      peticion = true;
      pedir(context);
    }

    // int variable = 0;
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[tarjetaAliado(context), cards(context)],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(19, 166, 7, 1)),
        backgroundColor: Color.fromRGBO(255, 241, 1, 1),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mi Orden",
              style: TextStyle(
                color: Color.fromRGBO(19, 166, 7, 1),
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
    );
  }

  Widget cards(BuildContext context) {
    List<Widget> widgets = [];
    globalresp.forEach((obj) {
      widgets.add(tarjetaMisOrdenes(
          context: context,
          nombre: obj.producto.titulo,
          cantidad: obj.cantidad.toString(),
          precio: obj.producto.isPromo == 0
              ? obj.producto.precio
              : obj.producto.precioPromo));
      // print("Promo?: ${ obj.producto.isPromo} & precio: ${ obj.producto.precio} & PrecioPromo:${ obj.producto.precioPromo} nombre:${ obj.producto.titulo}");
    });
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.015,
              ),
              Text('Mi orden',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  )),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: widgets,
          ),
        ),

        // tarjetaPedido(
        //     context: context,
        //     cantidad: '2',
        //     precio: '7.000',
        //     producto: 'Postobon Manzana'),
        // tarjetaPedido(
        //     context: context,
        //     cantidad: '2',
        //     precio: '7.000',
        //     producto: 'Postobon Manzana'),
        // tarjetaDomicilio(context: context, precio: '5000'),
        SizedBox(height: size.height * 0.05),
        tarjetaFormaDePago(
            context: context,
            precio:
                '${element != null ? element['orden'].precioTotal.toString() ?? 'Sin forma de pago' : ""}'),
        botones(context)
      ],
    );
  }

  // Widget tarjetaDomicilio({BuildContext context, String precio}) {
  //   final size = MediaQuery.of(context).size;
  //   final orientacion = MediaQuery.of(context).orientation;

  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: 10,
  //       ),
  //       Container(
  //         width: size.width,
  //         height: size.height < 509
  //             ? 50
  //             : size.height > 635 ? 60 : size.height * 0.09,
  //         color: Colors.white,
  //         child: Card(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  //           margin: const EdgeInsets.all(0.0),
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 20.0, right: 20.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               // crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: <Widget>[
  //                 // SizedBox( width: size.width*0.010, ),
  //                 Row(
  //                   children: [
  //                     Image(
  //                         image: AssetImage(
  //                           'assets/delivery-man.png',
  //                         ),
  //                         width: size.width < 203
  //                             ? 30
  //                             : size.width <= 243 ? 35 : 35),
  //                     SizedBox(
  //                       width: size.width * 0.015,
  //                     ),
  //                     Text(
  //                       'Domcilio',
  //                       style: TextStyle(
  //                           // fontWeight: FontWeight.bold,
  //                           color: Colors.black,
  //                           fontSize: 12),
  //                     ),
  //                   ],
  //                 ),

  //                 Text(
  //                   '\$ ' + precio,
  //                   style: TextStyle(
  //                       fontSize:
  //                           precio.length >= 9 && size.width < 229 ? 10 : 12),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget tarjetaGesture({BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;

    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height < 509
              ? 50
              : size.height > 635 ? 60 : size.height * 0.09,
          color: Colors.white,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // SizedBox( width: size.width*0.010, ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'ID Orden: D-001',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text('En Camino',
                            style: TextStyle(fontSize: 11, color: verde)),
                        SizedBox(
                          height: size.height * 0.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.010,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: size.height * 0.015,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        )
      ],
    );
  }

  Widget tarjetaMisOrdenes(
      {BuildContext context, String nombre, String cantidad, String precio}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;

    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height < 509
              ? 50
              : size.height > 635 ? 60 : size.height * 0.09,
          color: Colors.white,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // SizedBox( width: size.width*0.010, ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${nombre ?? ''}',
                          style: TextStyle(fontSize: 13),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              formatter.format(int.parse('${precio ?? ''}')),
                              //

                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromRGBO(103, 96, 95, 1))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'cantidad: ${element != null ? formatter.format(int.parse(cantidad.toString())) : ""}',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        )
      ],
    );
  }

  Widget tarjetaAliado(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        Container(
          height: size.height < 453 ? 60 : 75,
          width: size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // ClipRRect(
                    //    borderRadius: BorderRadius.circular(2000),
                    //    child: Image(
                    //     fit: BoxFit.cover,
                    //    width: 40,

                    //         image: NetworkImage(
                    //           '${storage+element['orden'].fotoSucursal}',
                    //         ),
                    //         height: 40
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${element != null ? element['orden'].sucursal ?? 'sin sucursal' : ''}',
                            style: TextStyle(fontSize: 13),
                          ),
                          Container(
                            width: size.width < 250
                                ? 50
                                : size.width < 352
                                    ? 100
                                    : size.width < 446
                                        ? 200
                                        : size.width < 566
                                            ? 300
                                            : size.width < 722 ? 400 : 500,
                            // color: Colors.grey,
                            child: Text(
                                '${element != null ? element['orden'].direccionSucursal ?? 'sin direccion' : ''}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(103, 96, 95, 1))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2000),
                      child: element != null
                          ? Image(
                              width: 40,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${element != null ? storage + element['orden'].fotoAliado : ""}',
                              ),
                              height: 40)
                          : Container(),
                    ),
                    element != null
                        ? Text(
                            '${element != null ? element['orden'].aliado : ""}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(103, 96, 95, 1)))
                        : Container()
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              height: size.height < 453 ? 25 : 30,
              width: size.width,
              color: verde,
              child: Center(
                  child: Text(
                'Información del Mandado',
                style: TextStyle(
                    fontSize: size.height < 453 ? 12 : 13, color: Colors.white),
              )),
            )
          ],
        ),
      ],
    );
  }

  Widget botones(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: size.height * 0.050,
            width: size.width * 0.4,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  size.width < 236 ? 'Anular' : 'Anular Orden',
                  style: TextStyle(
                      fontSize: size.width < 284
                          ? 10
                          : size.width < 312
                              ? 13
                              : 15,
                      color: Colors.white),
                ),
                color: rojo,
                onPressed: () {
                return  alerta(
                    context,
                    titulo: "Anular",
                    contenido: Form(
                      // key: formKey,
                      child: TextFormField(
                        controller: motivoController,
                        // validator: (value) => validar.validateGenerico(value),
                        decoration:
                            InputDecoration(hintText: 'Escriba el motivo'),
                      ),
                    ),
                    acciones: Row(
                      children: [
                        RaisedButton(
                            onPressed: () {},
                            color: verde,
                            shape: StadiumBorder(),
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: blanco),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        RaisedButton(
                          onPressed: () {
                 return alerta(context,
                      code: false,
                      contenido: '¿ Seguro que ya no quieres el pedido?',
                      acciones: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                                color: amarillo,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'No',
                                  style: TextStyle(color: verde),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                                color: rojo,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child:
                                    Text('Si', style: TextStyle(color: blanco)),
                                onPressed: () {
                                  anular();
                                }),
                          ),
                        ],
                      ));
                  // Navigator.of(context).popAndPushNamed('Inicio');
                },
                          color: rojo,
                          shape: StadiumBorder(),
                          child: Text(
                            'Anular',
                            style: TextStyle(color: blanco),
                          ),
                        ),
                      ],
                    ),
                  );
                  // put(context);
                  // print(
                  //     element['orden'].aliadoId.toString() + '***************');
                }),
          ),
          Container(
            height: size.height * 0.050,
            width: size.width * 0.4,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Cerrar',
                  style: TextStyle(
                      fontSize:
                          size.width < 284 ? 10 : size.width < 312 ? 13 : 15,
                      color: verde),
                ),
                color: amarillo,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }

  // Widget tarjetaPedido(
  //     {BuildContext context, String producto, String precio, String cantidad}) {
  //   final size = MediaQuery.of(context).size;
  //   final orientacion = MediaQuery.of(context).orientation;

  //   return Column(
  //     children: [
  //       Container(
  //         width: size.width,
  //         height: size.height < 509
  //             ? 50
  //             : size.height > 635 ? 60 : size.height * 0.09,
  //         color: Colors.white,
  //         child: Card(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  //           margin: const EdgeInsets.all(0),
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 20.0, right: 20.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               // crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: <Widget>[
  //                 // SizedBox( width: size.width*0.010, ),
  //                 Container(
  //                   width: size.width < 239
  //                       ? 50
  //                       : size.width < 275
  //                           ? 100
  //                           : size.width < 333
  //                               ? 150
  //                               : size.width < 385
  //                                   ? 180
  //                                   : size.width < 425 ? 250 : 250,
  //                   // color: Colors.grey,af
  //                   child: Text(
  //                     producto,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(
  //                         // fontWeight: FontWeight.bold,
  //                         color: Colors.black,
  //                         fontSize: size.width < 200 ? 10 : 12),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: size.width * 0.020,
  //                 ),
  //                 Text(
  //                   cantidad,
  //                   style: TextStyle(fontSize: size.width < 200 ? 10 : 12),
  //                 ),

  //                 Text(
  //                   '\$ ' + precio,
  //                   style: TextStyle(fontSize: size.width < 200 ? 10 : 12),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 3,
  //       )
  //     ],
  //   );
  // }

  Widget tarjetaFormaDePago({BuildContext context, String precio}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;

    return Container(
      width: size.width,
      height:
          size.height < 509 ? 50 : size.height > 635 ? 60 : size.height * 0.09,
      color: Colors.white,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // SizedBox( width: size.width*0.010, ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forma de Pago',
                    style: TextStyle(fontSize: 8),
                  ),
                  SizedBox(
                      height: orientacion == Orientation.portrait
                          ? size.height * 0.008
                          : size.height * 0.015),
                  Row(
                    children: [
                      element != null
                          ? Image(
                              image: AssetImage(
                                element['orden'].metodoDePago == 'Payu'
                                    ? 'assets/PAYU_LOGO_LIME.png'
                                    : element['orden'].metodoDePago ==
                                            'Transferencia Bancaria Bancolombia'
                                        ? 'assets/bancolombia_logo.png'
                                        : 'assets/money-1.png',
                              ),
                              width: element['orden'].metodoDePago == 'Payu'
                                  ? 50
                                  : element['orden'].metodoDePago ==
                                          'Transferencia Bancaria Bancolombia'
                                      ? 30
                                      : 17,
                            )
                          : Container(),
                      SizedBox(width: size.width * 0.005),
                      Text(
                        '${element != null ? element['orden'].metodoDePago : null}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.020,
              ),

              element != null
                  ? Text(
                      '\$${formatter.format(int.parse(precio.toString()))}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              precio.length >= 9 && size.width < 207 ? 10 : 14),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  pedir(BuildContext context) async {
    Map resp = await _http.getMethod(
        context: context,
        table:
            'detallePedidos?id_pedido=${element != null ? element['orden'].id : ""}',
        token: pref.token);

    if (resp['message'] == 'true') {
      var respModelDetallePedido = respModelDetallePedidoFromJson(resp['resp']);
      globalresp = respModelDetallePedido.data;
      // print(globalresp);
      setState(() {});
    } else {}
  }

  anular()async {
   load(context);
    Map _resp= await _http.putMethod(
      
        body: {"estado": "cancelada", "cancelada": "1","motivo_anulacion":"${motivoController.text}"},
        table: 'pedido',
        id:element['orden'].id,
        token: pref.token);
        motivoController.text='';
        Navigator.pop(context);

        if(_resp['message']=='expiro'){
          await funciones.closeSection(context);
           Navigator.pop(context);
           Navigator.pop(context);
           Navigator.pop(context);
           Navigator.pop(context);
           Navigator.pushReplacementNamed(context, 'IniciarSesion');
           return alerta(context,code: false,contenido: 'Tiempo fuera de conexion agotado, inicie sesion nuevamente.'); 
        }
        if(_resp['message']=='false'){
            Navigator.pop(context);
            Navigator.pop(context);
            return alerta(context,code: false,contenido: 'Error con el servidor'); 
            
        }
        if(_resp['message']=='true'){
          
          Navigator.pop(context);
          Navigator.pop(context);
          return alerta(context,code: false,contenido: 'El pedido se cancelo correctamente'); 
            
        }

  }
}
