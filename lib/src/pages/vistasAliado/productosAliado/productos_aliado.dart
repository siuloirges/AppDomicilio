import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:traelo_app/src/pages/vistasAliado/misOrdenesAliado/model/respuestaListaPedidosAliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/productosAliado/provider/productoprovider.dart';
// import 'package:traelo_app/src/pages/contactanos_page.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/model/respGetProductos.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

// import 'models/respGetProductos.dart';

class ProductosAliados extends StatefulWidget {
  @override
  _ProductosAliadosState createState() => _ProductosAliadosState();
}

class _ProductosAliadosState extends State<ProductosAliados> {
  final formatter = new NumberFormat("###,###,###", "es-co");
  int page = 0;
  Funciones funciones = new Funciones();
  PreferenciasUsuario pref = new PreferenciasUsuario();
  ProductoProvider productosProvider = new ProductoProvider();

  Size size;
  List<dynamic> productos;
  @override
  Widget build(BuildContext context) {
    productos = ModalRoute.of(context).settings.arguments;
    size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        mini: true,
        onPressed: () {
          Navigator.of(context).pushNamed('EditarProductoAliado', arguments: {'page': 'Nuevo', 'producto': null});
        },
        backgroundColor: amarillo,
        child: Icon(
          Icons.add,
          color: verde,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      appBar: AppBar(
        // actions: [IconButton(icon:Icon(Icons.replay_outlined), onPressed: (){
        //   productosProvider.obtenerProducto();
        // })],
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        title: Text(
          "Productos",
          style: TextStyle(
            color: verde,
            fontSize: 15.0,
          ),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: size.width < 500 ? null : 700,
                  color: size.width > 500 ? gris : Colors.transparent,
                  child: tabBar(context)),
            ),
          ),
        ],
      )),
    );
  }

  Widget contenidoPage0(BuildContext context) {
    List<dynamic> onlyProductos = [];
    // onlyProductos = [];

    productos.forEach((element) {
      if (element.isCombo == 0) {
        print('---------' + 'sdasdasdasdasdasdasdsad');
        onlyProductos.add(element);
      }
    });

    return onlyProductos.length != 0
        ? ListView.builder(
            // itemCount:productosProvider.productos.length,
            itemCount: onlyProductos.length,
            itemBuilder: (c, i) {
              return card(
                  producto: onlyProductos[i],
                  context: context,
                  visible: onlyProductos[i].disponibilidad,
                  precioPromo: onlyProductos[i].precioPromo,
                  isPromo: onlyProductos[i].isPromo,
                  precio: '${onlyProductos[i].precio}',
                  subtitulo: '${onlyProductos[i].descripcion}',
                  titulo: '${onlyProductos[i].titulo}',
                  id: onlyProductos[i].id);
            },
          )
        : thereIsNot(
            color: true,
            imagen: 'assets/no_productos.png',
            texto: 'No hay Productos');
  }

  Widget contenidoPage1(BuildContext context) {
    List<dynamic> onlyCombos = [];
    onlyCombos = [];

    productos.forEach((element) {
      if (element.isCombo == 1) {
        onlyCombos.add(element);
      }
    });

    return onlyCombos.length != 0
        ? ListView.builder(
            // itemCount:productosProvider.productos.length,
            itemCount: onlyCombos.length,
            itemBuilder: (c, i) {
              return card(
                  producto: onlyCombos[i],
                  visible: onlyCombos[i].disponibilidad,
                  precioPromo: "${onlyCombos[i].precioPromo}",
                  context: context,
                  isPromo: onlyCombos[i].isPromo,
                  precio: '${onlyCombos[i].precio}',
                  subtitulo: '${onlyCombos[i].descripcion}',
                  titulo: '${onlyCombos[i].titulo}',
                  // motivo: '${onlyCombos[i].existencia}',
                  id: onlyCombos[i].id);
            },
          )
        : thereIsNot(
            color: true,
            imagen: 'assets/no_productos.png',
            texto: 'No hay Combos');
  }

  Widget contenidoPage2(BuildContext context) {
    List<dynamic> onlyPromo = [];
    onlyPromo = [];

    productos.forEach((element) {
      if (element.isPromo == 1) {
        onlyPromo.add(element);
      }
    });

    return onlyPromo.length != 0
        ? ListView.builder(
            // itemCount:productosProvider.productos.length,
            itemCount: onlyPromo.length,
            itemBuilder: (c, i) {
              return card(
                  producto: onlyPromo[i],
                  visible: onlyPromo[i].disponibilidad,
                  precioPromo: onlyPromo[i].precioPromo,
                  isPromo: onlyPromo[i].isPromo,
                  context: context,
                  precio: '${onlyPromo[i].precio}',
                  subtitulo: '${onlyPromo[i].descripcion}',
                  titulo: '${onlyPromo[i].titulo}',
                  id: onlyPromo[i].id);
            },
          )
        : thereIsNot(
            color: true,
            imagen: 'assets/no_productos.png',
            texto: 'No hay Promociones');
  }

  Widget card({
    dynamic producto,
    int visible,
    BuildContext context,
    String precioPromo,
    int id,
    String precio,
    String titulo,
    String subtitulo,
    String motivo,
    int isPromo,
  }) {
    return Stack(children: [
      Column(
        children: [
          Column(children: [
            Container(
              width: size.width,
              height: 60,
              // color: Colors.white,
              child: Card(
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        // color: Colors.grey,
                        width: size.width > 500 ? 500 : size.width,
                        child: Text(
                          titulo,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: size.width < 436
                                ? 13.08
                                : size.width > 540
                                    ? 16.2
                                    : size.width * 0.03,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width > 500 ? 500 : size.width,
                        child: Text(subtitulo,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: size.width < 436
                                    ? 12.2
                                    : size.width > 540
                                        ? 15.12
                                        : size.width * 0.028,
                                color: Color.fromRGBO(103, 96, 95, 1))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: size.width,
                  height: size.width < 400 ? size.height * 0.040 : 30,
                  color: gris,
                  child: Card(
                    color: Color.fromRGBO(251, 251, 251, 1),
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: Container(
                      color: isPromo == 1
                          ? Color.fromRGBO(255, 216, 102, 0.2)
                          : Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 20.0),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //  color: Colors.amber,
                              width: size.width < 279
                                  ? size.width * 0.6
                                  : size.width > 500
                                      ? 330
                                      : size.width * 0.5,
                              // color: Colors.green,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      '\$${formatter.format(int.parse('${precio.toString()}'))}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        decoration: isPromo != 0
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: isPromo == 0 ? verde : rojo,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      child: isPromo != 0
                                          ? Text(
                                              '\$${formatter.format(int.parse('${precioPromo.toString()}'))}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: verde),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                    child: visible == 0
                                        ? CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 10,
                                          child: Icon(
                                            Icons.visibility_off,
                                            size: 12,
                                            color: blanco,
                                          ),
                                        )
                                        : Container()),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        'EditarProductoAliado',
                                        arguments: {
                                          'page': 'Editar',
                                          'producto': producto
                                        });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: amarillo,
                                    radius: 10,
                                    child: Icon(
                                      Icons.edit,
                                      size: 12,
                                      color: verde,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    eliminar(
                                      id: id,
                                      titulo: titulo,
                                      precio: precio,
                                      subtitulo: subtitulo,
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: rojo,
                                    radius: 10,
                                    child: Icon(
                                      Icons.delete,
                                      size: 12,
                                      color: blanco,
                                    ),
                                  ),
                                ),
                              ],
                            )

                            // SizedBox(
                            //   width: size.width * 0.70,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ]),
        ],
      ),
    ]);
  }

  eliminar({
    int id,
    String titulo,
    String precio,
    String subtitulo,
  }) {
    return mostrar(
        context: context,
        id: id,
        precio: precio,
        titulo: titulo,
        subtitulo: subtitulo);
  }

  Widget tabBar(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,

      children: [
        // SizedBox(
        //     height:  size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  page = 0;
                });
              },
              child: Container(
                color: Colors.transparent,
                width: size.width < 400 ? size.width * 0.29 : 100,
                height: size.width < 400 ? size.width * 0.1 : 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Text(
                        page == 0 ? 'Productos' : 'productos',
                        style: TextStyle(
                            color: page == 0 ? verde : Colors.grey,
                            fontSize:
                                size.width < 300 ? size.width * 0.05 : 15),
                      ),
                    ),
                    Center(
                      child: page == 0
                          ? indicador(
                              context: context,
                            )
                          : indicadorDes(),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.015,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  page = 1;
                });
              },
              child: Container(
                color: Colors.transparent,
                width: size.width < 400 ? size.width * 0.29 : 100,
                height: size.width < 400 ? size.width * 0.1 : 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Text(
                        page == 1 ? 'Combos' : 'combos',
                        style: TextStyle(
                            color: page == 1 ? verde : Colors.grey,
                            fontSize:
                                size.width < 300 ? size.width * 0.05 : 15),
                      ),
                    ),
                    Center(
                      child: page == 1
                          ? indicador(
                              context: context,
                            )
                          : indicadorDes(),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.015,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  page = 2;
                });
              },
              child: Container(
                color: Colors.transparent,
                width: size.width < 400 ? size.width * 0.29 : 100,
                height: size.width < 400 ? size.width * 0.1 : 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Text(
                        page == 2 ? 'Promociones' : 'promociones',
                        style: TextStyle(
                            color: page == 2 ? verde : Colors.grey,
                            fontSize:
                                size.width < 300 ? size.width * 0.05 : 15),
                      ),
                    ),
                    Center(
                      child: page == 2
                          ? indicador(
                              context: context,
                            )
                          : indicadorDes(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          // color: Colors.amber,
          height: size.height / 1.3,
          width: double.infinity,
          child: page == 0
              ? page0(context)
              : page == 1
                  ? page1(context)
                  : page == 2
                      ? page2(context)
                      : Container(),
        )
      ],
    );
  }

  page0(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      body: contenidoPage0(context),
    );
  }

  page1(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: contenidoPage1(context),
    );
  }

  page2(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange,
      body: contenidoPage2(context),
    );
  }

  Widget indicador({
    BuildContext context,
  }) {
    return AnimatedContainer(
      color: verde,
      duration: Duration(microseconds: 500),
      width: size.width / 5,
      height: size.height / 450,
    );
  }

  Widget indicadorDes({
    BuildContext context,
  }) {
    return AnimatedContainer(
      color: Colors.grey,
      duration: Duration(microseconds: 500),
      width: size.width / 5,
      height: size.height / 450,
    );
  }

  mostrar(
      {BuildContext context,
      int id,
      String titulo,
      String precio,
      String subtitulo}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(246, 245, 250, 1),
            title: Container(
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              // width: size.width/2,zx
                              child: Text(
                            '¿ Quieres borrar ?',
                            style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.clip,
                          )),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Text('${precio??'???'}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.redAccent),),
                      //   ],
                      // ),
                    ],
                  )),
                )),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Container(
                        // height: size.width>450?200: size.height * 0.3,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Center(
                                    child: Text(
                                  '${titulo ?? "???"}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w500),
                                )),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, right: 5),
                          child: Container(
                            width: 57,
                            height: 57,
                            child: RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.black26,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 5),
                          child: Container(
                            width: 57,
                            height: 57,
                            child: RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.redAccent,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.restore_from_trash_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                              onPressed: () async {
                                load(context);
                                await productosProvider.deleteProducto(id);

                                try {
                                  var resp = await productosProvider
                                      .obtenerProducto(context)
                                      .timeout(Duration(seconds: 10),
                                          onTimeout: () {
                                    throw {
                                      Navigator.pop(context),
                                      alerta(context,
                                          contenido: Text(
                                              "No hay conexion con el servidor."),
                                          acciones: Container()),
                                    };
                                  });

                                  Map<dynamic, dynamic> decodedResp =
                                      jsonDecode(resp);
                                  if (decodedResp['message'] == 'Unauthenticated.') {
                                    // Navigator.of(context).pushReplacementNamed('IniciarSesion');
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.of(context)
                                        .pushReplacementNamed('IniciarSesion');
                                    alerta(context,
                                        titulo: 'alerta',
                                        code: false,
                                        contenido:
                                            'Tiempo de conexion agotado, inicie sesion nuevamente.');
                                    await funciones.closeSection(context);
                                  }
                                  if (decodedResp['success'] == true) {
                                    var respModel = respProductoFromJson(resp);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.of(context).pushNamed(
                                        'ProductosAliados',
                                        arguments: respModel.data);
                                  }
                                } catch (e) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  alerta(context,
                                      contenido: Text(e),
                                      acciones: Container());
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
