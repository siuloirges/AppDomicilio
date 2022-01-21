import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// import 'package:traelo_app/src/pages/vistasAliado/misOrdenesAliado/model/respuestaListaPedidosAliado.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

import 'models/detallePedidoRepartidorModel.dart';

class DetallesDeOrdenRepartidor extends StatefulWidget {
  @override
  _DetallesDeOrdenRepartidorState createState() =>
      _DetallesDeOrdenRepartidorState();
}

class _DetallesDeOrdenRepartidorState extends State<DetallesDeOrdenRepartidor> {
  dynamic globalRespPedido = [];
  var formKey = GlobalKey<FormState>();
  TextEditingController motivoController = new TextEditingController();
  Validaciones validar = new Validaciones();
  Funciones funciones = new Funciones();
  PeticionesHttpProvider http = PeticionesHttpProvider();
  PreferenciasUsuario pref = new PreferenciasUsuario();
  dynamic element;
  bool peticion = false;
  String id;
  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("###,###,###", "es-co");
    
    if (peticion == false) {
      peticion = true;
      pedir(context);
    }
  
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: verde),
            backgroundColor: amarillo,
            title: Text(
              "Detalles de la orden",
              style: TextStyle(
                color: Colors.black,
                fontSize: orientacion == Orientation.portrait
                    ? size.width * 0.045
                    : size.width * 0.03,
              ),
            ),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                tarjetaAliado(context,
                    nombreSucursal: element['orden'].sucursal.nombre,
                    direccionSucursal: element['orden'].sucursal.direccion),
                texto(context: context, texto: 'Detalles'),
                tarjetaOrden(context),
                SizedBox(height: size.height * 0.005),
                tarjetaDireccion(context),
                SizedBox(height: size.height * 0.005),
                tarjetaTelefono(
                  context,
                ),
                texto(context: context, texto: 'Pedido Realizado'),
                globalRespPedido.length == 0
                    ? Center(child: CircularProgressIndicator())
                    : globalRespPedido == 'vacio'
                        ? Center(child: Text('No hay productos'))
                        : Column(children: globalRespPedido),
                tarjetaDomicilio(context: context, precio: '5.000'),
                SizedBox(height: size.height * 0.04),
                tarjetaFormaDePago(
                    context: context,
                    precio: '${element['orden'].precioTotal}',
                    formaDePago: '${element['orden'].metodoDePago}'),
                SizedBox(height: size.height * 0.02),
                botones(context),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          )),
    );
  }

  Widget tarjetaAliado(BuildContext context,
      {String nombreSucursal, String direccionSucursal}) {
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            nombreSucursal ?? '',
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
                                            : size.width < 722
                                                ? 400
                                                : 500,
                            // color: Colors.grey,
                            child: Text(direccionSucursal ?? '',
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
                Image(
                    image: AssetImage(
                      'assets/FINAL.png',
                    ),
                    height: size.width < 226 ? 20 : 30),
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

  Widget tarjetaOrden(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height < 509
              ? 50
              : size.height > 635
                  ? 60
                  : size.height * 0.09,
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
                  //  SizedBox( width: size.width*0.010, ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'ID Orden: ${element['orden'].numeroPedido.toString()}',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                            ' ${element['orden'].estado == 'inicial' ? 'nueva' : element['orden'].estado}    ',
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

  Widget tarjetaDireccion(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height < 509
              ? 50
              : size.height > 635
                  ? 60
                  : size.height * 0.09,
          color: Colors.white,
          child: Card(
            margin: EdgeInsets.all(0),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width < 240
                            ? size.width * 0.35
                            : size.width * 0.4,
                        // color: Colors.grey,
                        child: Text(
                          'Direccion',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 13),
                        ),
                      ),
                      Container(
                        // color: Colors.grey,
                        width: size.width < 240
                            ? size.width * 0.35
                            : size.width * 0.4,
                        child: Text('${element['orden'].direccion.direccion}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromRGBO(103, 96, 95, 1),
                                fontSize: 11)),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width < 240
                            ? size.width * 0.35
                            : size.width * 0.4,
                        // color: Colors.grey,
                        child: Text(
                          'Teimpo Estimado',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 13),
                        ),
                      ),
                      Container(
                        width: size.width < 240
                            ? size.width * 0.35
                            : size.width * 0.4,
                        // color: Colors.grey,
                        child: Text('40 Min',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromRGBO(103, 96, 95, 1),
                                fontSize: 11)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 3)
      ],
    );
  }

  Widget texto({BuildContext context, String texto, double arriba}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.015,
          ),
          Text(texto ?? '',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey, fontSize: 15)),
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
          height: size.height < 509
              ? 50
              : size.height > 635
                  ? 60
                  : size.height * 0.09,
          color: Colors.white,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //  SizedBox( width: size.width*0.010, ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: size.width * 0.7,
                          // color:  Colors.grey,
                          child: Text(
                            'Telefono de Cliente',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: Text('${element['orden'].cliente.telefono}',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromRGBO(103, 96, 95, 1))),
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

  Widget tarjetaPedido(
      {BuildContext context, String producto, String precio, String cantidad}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;

    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height < 509
              ? 50
              : size.height > 635
                  ? 60
                  : size.height * 0.09,
          color: Colors.white,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //  SizedBox( width: size.width*0.010, ),
                  Container(
                    width: size.width < 239
                        ? 50
                        : size.width < 275
                            ? 100
                            : size.width < 333
                                ? 150
                                : size.width < 385
                                    ? 180
                                    : size.width < 425
                                        ? 250
                                        : 250,
                    // color: Colors.grey,af
                    child: Text(
                      producto,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: size.width < 200 ? 10 : 12),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.020,
                  ),
                  Text(
                    cantidad,
                    style: TextStyle(fontSize: size.width < 200 ? 10 : 12),
                  ),

                  Text(
                    '\$ ' + precio,
                    style: TextStyle(fontSize: size.width < 200 ? 10 : 12),
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

  Widget tarjetaDomicilio({BuildContext context, String precio}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          height: size.height < 509
              ? 50
              : size.height > 635
                  ? 60
                  : size.height * 0.09,
          color: Colors.white,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.all(0.0),
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
                          image: AssetImage(
                            'assets/delivery-man.png',
                          ),
                          width: size.width < 203
                              ? 30
                              : size.width <= 243
                                  ? 35
                                  : 35),
                      SizedBox(
                        width: size.width * 0.015,
                      ),
                      Text(
                        'Domcilio',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12),
                      ),
                    ],
                  ),

                  Text(
                    '\$ ' + precio,
                    style: TextStyle(
                        fontSize:
                            precio.length >= 9 && size.width < 229 ? 10 : 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tarjetaFormaDePago(
      {BuildContext context, String precio, String formaDePago}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;

    return Container(
      width: size.width,
      height: size.height < 509
          ? 50
          : size.height > 635
              ? 60
              : size.height * 0.09,
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
              //  SizedBox( width: size.width*0.010, ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forma de Pago ',
                    style: TextStyle(fontSize: 8),
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
                        width: 17,
                      ),
                      SizedBox(width: size.width * 0.005),
                      Text(
                        formaDePago ?? '',
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

              Text(
                precio + ' \$',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: precio.length >= 9 && size.width < 207 ? 10 : 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget botones(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
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
                  alerta(
                    context,
                    titulo: "Anular",
                    contenido: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: motivoController,
                        validator: (value) => validar.validateGenerico(value),
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
                            // if (!formKey.currentState.validate()) {
                            //   return null;
                            // }
                            put(context);
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
                      fontSize: size.width < 284
                          ? 10
                          : size.width < 312
                              ? 13
                              : 15,
                      color: blanco),
                ),
                color: verde,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }
//  pedir2(context) async {
//     final size = MediaQuery.of(context).size;
//       List<Widget> widgets = [];

//     //  CircularProgressIndicator();
//     try {
//       // load(context);

//       dynamic resp = await http.getMethod(
//         context: context,
//         table: 'detallePedidos?id_pedido=$id',
//         token: pref.token,
//       );
//       // me salio error asqui

//       if (resp['message'] == "true") {
//         final model =
//             respuestaListaDeProductosFromJson(resp['resp']);

//         //--
//         if (model.data.length == 0) {
//           globalRespPedido = 'vacio';
//           setState(() {});
//         }
//         //--tamos bien dasle otra vex esa vaina no quiere debug
//        else {
//           model.data.forEach((element) {
//             widgets.add(
//               tarjetaPedido(
//                   context: context,
//                   cantidad: '${element.cantidad}',
//                   precio: '${element.producto.precio}',
//                   producto: '${element.producto.titulo}   '),
//             );
//           });
//           globalRespPedido = [];
//           globalRespPedido = widgets;
//           setState(() {});
//         }

//         //  print('---------------------------------------------------------------------ok'); jajaja
//       } else {}
//     } catch (e) {
//       Navigator.pop(context);
//       return alerta(context,
//           // titulo: 'sa',
//           contenido: 'Ha ocurrido un problema, intentelo nuevamente.',
//           code: false);
//     }
//   }

  put(BuildContext context) async {
    try {
      String idPedido = element['orden'].id.toString();
      String idAliado = element['orden'].aliadoId.toString();
      load(context);
      dynamic resp = await http.putArgumentMethod(
          context: context,
          table: 'pedido/$idPedido?aliado_id=$idAliado',
          token: pref.token,
          body: {
            // "numero_pedido": "${element['orden'].numeroPedido.toString()}",
            // "estado": "cancelada",
            // "metodo_de_pago": "${element['orden'].metodoDePago}",
            // "precio_total": "${element['orden'].precioTotal.toString()} ",
            // "direccion_id": "${element['orden'].direccionId.toString()}",
            // "sucursal_id": "${element['orden'].sucursalId.toString()}",
            // "cliente_id": "${element['orden'].clienteId.toString()}",
            // "motivo_anulacion": "${motivoController.text}",
            "numero_pedido": "${element['orden'].numeroPedido.toString()}",
            "estado": "inicial",
            "metodo_de_pago": "${element['orden'].metodoDePago}",
            "precio_total": "${element['orden'].precioTotal.toString()} ",
            "direccion_id": "${element['orden'].direccionId.toString()}",
            "sucursal_id": "${element['orden'].sucursalId.toString()}",
            "cliente_id": "${element['orden'].clienteId.toString()}",
            "motivo_anulacion": "",
            "repartidor_id": "9"
          }

          // id: int.parse(element['orden'].id),
          );
          if (resp['message'] == "expiro") {
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      }

      if (resp['message'] == 'true') {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.of(context).pushNamed('MisOrdenesAliado');
      }
      if (resp['message'] == 'false') {
        Navigator.pop(context);
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'no hay conexion con el servidor');
      }
    } catch (e) {
      Navigator.pop(context);
      alerta(context, titulo: 'alerta', code: false, contenido: 'Hay un error');
    }
  }

  pedir(BuildContext context) async {
    // load(context);
    final size = MediaQuery.of(context).size;

    try {
      List<Widget> widgets = [];
      // load(context);
      dynamic resp = await http.getMethod(
        context: context,
        table: 'detallePedidos?id_pedido=${element['orden'].id}',
        token: pref.token,
      );



if (resp['message'] == "expiro") {
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      }
      if (resp['message'] == "true") {
        final model = respDetallePedioRepartoidorFromJson(resp['resp']);

        // if (model.message != 'Unauthenticated.') {
        if (model.data.length == 0) {
          globalRespPedido = [];
          globalRespPedido = 'vacio';
          setState(() {});
        } else {
          model.data.forEach((obj) {
            widgets.add(
              tarjetaPedido(
                  context: context,
                  cantidad: '${obj.cantidad}',
                  precio: '${obj.producto.precio}',
                  producto: '${obj.producto.titulo}   '),
            );
          });
          globalRespPedido = [];
          globalRespPedido = widgets;
          setState(() {});
        }

        // } else {
        //  Navigator.of(context).pushReplacementNamed('IniciarSesion');
        //   await funciones.closeSection(context);
        // }

        //  print('---------------------------------------------------------------------ok');
      }

      if (resp['message'] == 'false') {
        globalRespPedido = [Text('No hay conexion con el servidor')];
      }
    } catch (e) {
      print("EL ERROR ES:-------------" + e);
      return alerta(context, contenido: 'error', code: false);
    }
  }

  //detallePedidos?id_pedido=$id
}
