import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:traelo_app/src/pages/login/Provider/LoginProvider.dart';
// import 'package:traelo_app/src/pages/vistasCliente/ordenar/models/GetDireccionModel.dart';
// import 'package:traelo_app/src/pages/vistasCliente/ordenAntojos/models/GetDireccionModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

import 'Providers/OrdenarProvider.dart';

class Ordenar extends StatefulWidget {
  @override
  _OrdenarState createState() => _OrdenarState();
}

class _OrdenarState extends State<Ordenar> {
  @override
  void dispose() {
    ordenarProvider.setDireccion = null;
    ordenarProvider.setMetodoDePago = null;
    super.dispose();
  }

  OrdenarProvider ordenarProvider;

  PeticionesHttpProvider peticionesHttpProvider = new PeticionesHttpProvider();
  // DireccionesPage direccionesPage = new DireccionesPage();
  set setDireccion(direccionL) {
    direccion = direccionL;
  }

  PreferenciasUsuario pref = new PreferenciasUsuario();
  final formatter = new NumberFormat("###,###,###", "es-co");
  Funciones funciones = new Funciones();
  dynamic globalRespDirecciones = [];
  // bool ifController=false;
  dynamic element;
  Map direccion;
  List<Widget> carrito = [];

  @override
  Widget build(BuildContext context) {
    ordenarProvider = Provider.of<OrdenarProvider>(context);
    // refrehs(){}
    element = ModalRoute.of(context).settings.arguments;

    if (ordenarProvider.getGlobalRespDirecciones == 'cargando') {
      // ifController=true;
      //  ordenarProvider=[];
      ordenarProvider.pedir(context);
    }
    carrito = [];
    element['Carrito'].forEach((obg) {
      carrito.add(tarjetaPedido(
        context: context,
        cantidad: '${obg['cantidad_pedir']}',
        precio: '${obg['producto'].precio}',
        producto: '${obg['producto'].titulo}',
      ));
    });

    // int variable = 0;
    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[cards(context)],
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
        ));
  }

  Widget cards(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.008,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 19.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.015,
              ),
              Text('Añada la direccion de destino',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  )),
            ],
          ),
        ),
        Divider(),
        tarjetaUbicacion(context),
        Divider(),
        SizedBox(
          height: size.height * 0.015,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 19.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       SizedBox(
        //         width: size.width * 0.015,
        //       ),
        //       Text('Servicio a Domicilio ',
        //           textAlign: TextAlign.start,
        //           style: TextStyle(
        //             color: Colors.grey,
        //             fontSize: 12,
        //           )),
        //     ],
        //   ),
        // ),
        // tarjetaTiempo(context),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 19.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.015,
              ),
              Text('Detalles de la Orden ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  )),
            ],
          ),
        ),
        Column(
          children: carrito,
        ),

        tarjetaDomicilio(context: context, precio: 'Calcular precio'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.015,
              ),
              Text('Agregar un metodo de pago ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: orientation == Orientation.portrait
                        ? size.width * 0.035
                        : size.width * 0.02,
                  )),
            ],
          ),
        ),
        metodoDePago(context),
        tarjetaFormaDePago(context: context, precio: '20.000000'),
        botonFinalizar(context)
      ],
    );
  }

  Widget metodoDePago(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 35,
                width: size.width < 205 ? 80 : 90,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                            color: ordenarProvider.getMetodoDePago == 'Efectivo'
                                ? Colors.white
                                : null,
                            image: AssetImage(
                              'assets/money.png',
                            ),
                            width: size.width < 205 ? 12 : 15),
                        SizedBox(width: size.width < 205 ? 0 : 3),
                        Text(
                          'Efectivo',
                          style: TextStyle(
                              fontSize: 10,
                              color:
                                  ordenarProvider.getMetodoDePago == 'Efectivo'
                                      ? Colors.white
                                      : negro),
                        ),
                      ],
                    ),
                    color: ordenarProvider.getMetodoDePago != 'Efectivo'
                        ? Colors.white
                        : verde,
                    onPressed: () {
                      ordenarProvider.setMetodoDePago = 'Efectivo';
                      // Navigator.of(context).pushNamed('');
                    }),
              ),
              Container(
                height: 35,
                width: size.width < 205 ? 80 : 90,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Image(
                      color: ordenarProvider.getMetodoDePago == 'Payu'
                          ? Colors.white
                          : null,
                      image: AssetImage(
                        'assets/PAYU_LOGO_LIME.png',
                      ),
                      width: size.width * 0.38,
                    ),
                    color: ordenarProvider.getMetodoDePago != 'Payu'
                        ? Colors.white
                        : verde,
                    onPressed: () {
                      ordenarProvider.setMetodoDePago = 'Payu';
                      // Navigator.of(context).pushNamed('');
                    }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 35,
              width: size.width < 207 ? 150 : 230,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          color: ordenarProvider.getMetodoDePago ==
                                  'Transferencia Bancaria Bancolombia'
                              ? Colors.white
                              : null,
                          image: AssetImage(
                            'assets/bancolombia_logo.png',
                          ),
                          width: 25),
                      Text(
                        size.width < 214
                            ? 'Transf. Bancaria'
                            : 'Transferencia Bancaria',
                        style: TextStyle(
                            fontSize: 12,
                            color: ordenarProvider.getMetodoDePago ==
                                    'Transferencia Bancaria Bancolombia'
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                  color: ordenarProvider.getMetodoDePago !=
                          'Transferencia Bancaria Bancolombia'
                      ? Colors.white
                      : verde,
                  onPressed: () {
                    ordenarProvider.setMetodoDePago =
                        'Transferencia Bancaria Bancolombia';
                    // Navigator.of(context).pushNamed('');
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget botonFinalizar(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: size.height < 573 ? 30 : size.height * 0.06,
            width: size.width * 0.9,
            child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  'FINALIZAR',
                  style: TextStyle(
                      fontSize: 18,
                      color: ordenarProvider.getDdireccion == null
                          ? blanco
                          : ordenarProvider.getMetodoDePago == null
                              ? blanco
                              : verde),
                ),
                color: amarillo,
                //0011
                onPressed: ordenarProvider.getDdireccion != null &&
                        ordenarProvider.getMetodoDePago != null
                    ? () async {
                        submitPedido();
                      }
                    : null),
          ),
        ),
        ordenarProvider.getDdireccion == null
            ? FlatButton(
                onPressed: () {
                  mostrarDirecciones(context);
                },
                child: Text('Añada una direccion antes de continuar'))
            : Container()
      ],
    );
  }

  submitPedido() async {
    // Navigator.of(context).pushNamed('');
    load(context);
    List<Map<String, String>> _carritoFinal = [];

    element['Carrito'].forEach((obj) {
      _carritoFinal.add({
        "cantidad": "${obj['cantidad_pedir']}",
        "id_producto": "${obj['producto'].id}"
      });
    });

    String jsonEncode = json.encode(_carritoFinal);

    Map orden = {
      "estado": "generada",
      "generada": "1",
      "autorizada": "",
      "preparada": "",
      "entregada": "",
      "cancelada": "",
      "numero_pedido":
          "${element['sucursal'] + element['aliado_id'] + pref.user_id}",
      "metodo_de_pago": "${ordenarProvider.getMetodoDePago.toString()}",
      "precio_total": "${element['precioTotal'].toString()}",
      "aliado_id": "${element['aliado_id']}",
      "sucursal_id": "${element['sucursal']}",
      "direccion_id": "${ordenarProvider.getDdireccion['id']}",
      "repartidor_id": "",
      "cliente_id": "${pref.user_id}",
      "pedido": jsonEncode
    };

    // var jsonDecode = json.decode(jsonEncode);

    Map _resp = await peticionesHttpProvider.postMethod(
      body: orden,
      table: 'pedido',
      context: context,
      token: pref.token,
    );

    if (_resp['message'] == "expiro") {
      Navigator.of(context).pushReplacementNamed('IniciarSesion');
      alerta(context,
          titulo: 'alerta',
          code: false,
          contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
      await funciones.closeSection(context);
    }

    if (_resp['message'] == 'true') {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, 'MisOrdenes', arguments: {
        "indice": _resp['data']['data']['id'],
        "page": 0,
      });
      return alerta(
        context,
        code: false,
        contenido: 'Su pedido se a creado exitosamente',
      );
    } else {
      return alerta(context, contenido: 'Error al pedir', code: false);
    }
  }

  Widget tarjetaUbicacion(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () {
        mostrarDirecciones(context);
      },
      child: ordenarProvider.getDdireccion == null
          ? Container(
              width: size.width,
              height: size.height < 509
                  ? 50
                  : size.height > 635
                      ? 60
                      : size.height * 0.09,
              color: verde,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //  SizedBox( width: size.width*0.010, ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Añade tu ubicación',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: blanco),
                        ),
                        // Container(
                        //   width: size.width < 195
                        //       ? 88
                        //       : size.width < 245 ? 138 : size.width < 295 ? 188 : 238,
                        //   // color: Colors.grey,
                        //   child: Text('Los Ejecutivos - Mz40 Lt 38',
                        //       overflow: TextOverflow.ellipsis,
                        //       style: TextStyle(
                        //           fontSize: 8, color: Color.fromRGBO(103, 96, 95, 1))),
                        // )
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.010,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add_circle,
                          size: 20,
                          color: blanco,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          : ListTile(
              title: Text(
                ordenarProvider.getDdireccion['nombre'],
              ),
              subtitle: Text(
                ordenarProvider.getDdireccion['direccion'],
              )),
    );
  }

  mostrarDirecciones(context) {
    return alerta(context,
        titulo: 'Direcciones',
        contenido: Column(
          children: [DireccionesPage()],
        ),
        acciones: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(Icons.arrow_back, color: Colors.white),
              width: 55,
              height: 55,
              decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            )));
  }

  Widget tarjetaTiempo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height < 509
          ? 40
          : size.height > 635
              ? 50
              : size.height * 0.08,
      color: Colors.white,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        margin: const EdgeInsets.all(0.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tiempo estimado',
                    style: TextStyle(fontSize: 11),
                  ),
                  Text('40 Min',
                      style: TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tarjetaDomicilio({BuildContext context, String precio}) {
    final size = MediaQuery.of(context).size;

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

  Widget tarjetaPedido(
      {BuildContext context, String producto, String precio, String cantidad}) {
    final size = MediaQuery.of(context).size;
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
                children: <Widget>[
                  //  SizedBox( width: size.width*0.010, ),
                  Expanded(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Cantidad: ' + cantidad,
                      style: TextStyle(fontSize: size.width < 200 ? 10 : 12),
                    ),
                  ),

                  Text(
                    '\$' + formatter.format(int.parse(precio.toString())),
                    // formatter.format(int.parse(precio))
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

  Widget tarjetaFormaDePago({BuildContext context, String precio}) {
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
                      ordenarProvider.getMetodoDePago != null
                          ? Image(
                              image: AssetImage(
                                ordenarProvider.getMetodoDePago == 'Payu'
                                    ? 'assets/PAYU_LOGO_LIME.png'
                                    : ordenarProvider.getMetodoDePago ==
                                            'Transferencia Bancaria Bancolombia'
                                        ? 'assets/bancolombia_logo.png'
                                        : 'assets/money-1.png',
                              ),
                              width: ordenarProvider.getMetodoDePago == 'Payu'
                                  ? 50
                                  : ordenarProvider.getMetodoDePago == 'Transferencia Bancaria Bancolombia'
                                      ? 30
                                      : 17,
                            )
                          : Text(
                              '\$',
                              style: TextStyle(
                                  color: negro, fontWeight: FontWeight.bold),
                            ),
                      SizedBox(width: size.width * 0.005),
                      Text(
                        '${ordenarProvider.getMetodoDePago ?? 'Seleccione una forma de pago'}',
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
                '\$ ' +
                    formatter
                        .format(int.parse(element['precioTotal'].toString())),
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
}

class DireccionesPage extends StatefulWidget {
//  get getDireccionGlobal => direccionesPageState.getDireccion;
  DireccionesPage({Key key}) : super(key: key);

  @override
  _DireccionesPageState createState() => _DireccionesPageState();
}

class _DireccionesPageState extends State<DireccionesPage> {
  _OrdenarState direccionesPageState = new _OrdenarState();
  //  get getDireccion =>_select ;
  // Map _select;

  bool ifController = false;
  PeticionesHttpProvider peticionesHttpProvider = new PeticionesHttpProvider();

  PreferenciasUsuario pref = new PreferenciasUsuario();
  OrdenarProvider ordenarProvider;
  @override
  Widget build(BuildContext context) {
    ordenarProvider = Provider.of<OrdenarProvider>(context);
    return ordenarProvider.getGlobalRespDirecciones == 'cargando'
        ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircularProgressIndicator(
              backgroundColor: amarillo,
              strokeWidth: 1,
            ),
          )
        : ordenarProvider.getGlobalRespDirecciones == 'vacio'
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No tienes direcciones creadas',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: addNewDireccion()),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: addAtualDireccion()),
                ],
              )
            : direcciones();
  }

  direcciones() {
    List<Widget> listWidget = [];
    ordenarProvider.getGlobalRespDirecciones?.forEach((element) {
      listWidget.add(direccionWidget(context,
          direccion: element.direccion,
          nombre: element.nombre,
          referencia: element.referencia,
          id: element.id));
    });

    return SingleChildScrollView(
      child: Column(
        children: listWidget..add(addNewDireccion())..add(addAtualDireccion()),
      ),
    );
  }

  addNewDireccion() {
    return FlatButton(
      onPressed: () {
        Navigator.pop(
          context,
        );
        Navigator.pushNamed(context, 'MisDirecciones',
            arguments: {"data": ordenarProvider.getGlobalRespDirecciones});
      },
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.green,
          shape: RoundedRectangleBorder(
              side: BorderSide(), borderRadius: BorderRadius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 8.0),
          child: Row(
            children: [
              Text(
                'Crear nueva direccion',
                style: TextStyle(color: Colors.white),
              ),
              Flexible(
                child: IconButton(
                    icon: Icon(
                      Icons.add_circle_rounded,
                      color: Colors.white,
                    ),
                    onPressed: null),
              )
            ],
          ),
        ),
      ),
    );
  }

  postAtualDireccion({direccion}){

  }

  addAtualDireccion() {
    return FlatButton(
      onPressed: () {
        Navigator.pop(
          context,
        );
        Navigator.pushNamed(context, 'MisDirecciones',
            arguments: {"data": ordenarProvider.getGlobalRespDirecciones});
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.green,
            shape: RoundedRectangleBorder(
                side: BorderSide(), borderRadius: BorderRadius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 8.0),
            child: Row(
              children: [
                Text(
                  'Usar ubicacion actual',
                  style: TextStyle(color: Colors.white),
                ),
                Flexible(
                  child: IconButton(
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color: Colors.white,
                      ),
                      onPressed: null),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  direccionWidget(context,
      {String nombre, String direccion, String referencia, int id}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          ordenarProvider.setDireccion = null;
          ordenarProvider.setDireccion = {
            "id": "$id",
            "nombre": "$nombre",
            "direccion": "$direccion"
          };
          // direccionesPageState.setDireccion=_select;
          setState(() {});
        },
        child: Container(
          decoration: ShapeDecoration(
            color: ordenarProvider.getDdireccion == null
                ? gris
                : ordenarProvider.getDdireccion['id'] == id.toString()
                    ? amarillo
                    : gris,
            shape: RoundedRectangleBorder(
                side: BorderSide(), borderRadius: BorderRadius.circular(10)),
          ),
          child: ListTile(
            title: Text(
              '${nombre ?? "???"}',
              style: TextStyle(
                  color: ordenarProvider.getDdireccion == null
                      ? negro
                      : ordenarProvider.getDdireccion['id'] == id.toString()
                          ? verde
                          : negro),
            ),
            subtitle: Text(
              '${direccion ?? "???"}',
              style: TextStyle(
                  color: ordenarProvider.getDdireccion == null
                      ? negro
                      : ordenarProvider.getDdireccion['id'] == id.toString()
                          ? verde
                          : negro),
            ),
          ),
        ),
      ),
    );
  }
}
