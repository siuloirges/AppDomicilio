import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:traelo_app/src/pages/vistasAliado/inicioAliado/publicarAliado/publicarAliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/CategoriaSucursal/models/respExistencia.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/models/resp.dart';
// import 'package:traelo_app/src/pages/vistasCliente/ordenar/Providers/OrdenarProvider.dart';
import 'package:traelo_app/src/utils/Global.dart';
// import 'package:traelo_app/src/utils/model/respGetProductos.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

import 'ordenar/Providers/OrdenarProvider.dart';
// import 'package:http/http.dart' as http;

class Mostrarproveedor extends StatefulWidget {
  @override
  _MostrarproveedorState createState() => _MostrarproveedorState();
}

class _MostrarproveedorState extends State<Mostrarproveedor> {
  final formatter = new NumberFormat("###,###,###", "es-co");
  int precioTotal = 0;
  List carrito = [];
  PeticionesHttpProvider peticionesHttpProvider = new PeticionesHttpProvider();
  PreferenciasUsuario pref = new PreferenciasUsuario();
  int page = 0;
  Funciones funciones = new Funciones();
  Size size;
  Map element;
  bool peticion = false;
  dynamic _menuGlobalResp = [];
  OrdenarProvider ordenarProvider;
  // dynamic _productosGlobalResp = [];
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   // peticionesHttpProvider.dispose();

  // }
  @override
  Widget build(BuildContext context) {
    ordenarProvider = Provider.of<OrdenarProvider>(context);
    element = ModalRoute.of(context).settings.arguments;

    print(element['sucursal']);
    if (peticion == false) {
      peticion = true;
      setState(() {});
      pedir();
    }

    size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: gris,
        body: Stack(
          children: [
            Column(
              children: [
                imagen(context),
              ],
            ),
            Column(
              children: [
                appBar(context),
              ],
            ),
            _menuGlobalResp.length != 0
                ? _menuGlobalResp == 'vacio'
                    ? Center(child: Text('Esta sucursal no tiene productos'))
                    : tabBar(context)
                : Center(
                    child: CircularProgressIndicator(
                    backgroundColor: amarillo,
                    strokeWidth: 1,
                  )),
          ],
        ));
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      // title: Text('TraelooAliados'),
      iconTheme: IconThemeData(color: blanco),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  Widget imagen(BuildContext context) {
    return Container(
      height: size.width < 294 ? size.width * 0.72 : 221.68,
      width: size.width,
      child: Stack(
        children: [
          Image(
            height: size.width < 294 ? size.width * 0.72 : 221.68,
            fit: BoxFit.cover,
            width: double.infinity,
            image: NetworkImage(element['sucursal']['imagenPerfil']),
          ),
          Image(
              height: size.width < 294 ? size.width * 0.72 : 221.68,
              fit: BoxFit.cover,
              width: double.infinity,
              image: AssetImage('assets/negro.png')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.width < 294 ? size.width * 0.15 : 44.1,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image(
                        image:
                            NetworkImage(element['sucursal']['imagenPortada']),
                        width: 40),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${element['sucursal']['nombre']}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: blanco),
                    ),
                  ),
                  Container(
                    width: size.width * 0.5,
                    child: Text(
                      '${element['sucursal']['direccion']}',
                      maxLines: 2,
                      style: TextStyle(
                          fontSize:
                              size.width < 300 ? size.width * 0.035 : 10.5,
                          color: blanco),
                    ),
                  ),
                  SizedBox(
                    height: size.width < 300 ? size.width * 0.01 : 3,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: amarillo,
                    ),
                    height: size.width < 388 ? size.width * 0.05 : 19.4,
                    width: size.width < 388 ? size.width * 0.16 : 62.08,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'id: ${element['sucursal']['id']}',
                          style: TextStyle(
                              fontSize: 10,
                              color: verde,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width < 300 ? size.width * 0.01 : 3,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabBar(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,

      children: [
        SizedBox(height: size.width < 294 ? size.width * 0.72 : 221.68),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  page = 0;
                });
              },
              child: Container(
                color: Colors.transparent,
                width: size.width < 400 ? size.width * 0.2 : 100,
                //  height:size.width<400? size.width*0.1:60,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Center(
                        child: Text(
                          page == 0 ? 'Menu' : 'menu',
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: page == 0 ? verde : Colors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: page == 0 ? indicador() : indicadorDes(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  page = 1;
                });
              },
              child: Container(
                color: Colors.transparent,
                width: size.width < 400 ? size.width * 0.2 : 100,
                //  height:size.width<400? size.width*0.1:60,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Center(
                        child: Text(
                          page == 1 ? 'Combos' : 'combos',
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: page == 1 ? verde : Colors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: page == 1 ? indicador() : indicadorDes(),
                      ),
                    )
                  ],
                ),
              ),
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
                //  height:size.width<400? size.width*0.1:60,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Center(
                        child: Text(
                          page == 2 ? 'Promociones' : 'promociones',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: page == 2 ? verde : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: page == 2 ? indicador() : indicadorDes(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  page = 3;
                });
              },
              child: Container(
                color: Colors.transparent,
                width: size.width < 400 ? size.width * 0.12 : 100,
                //  height:size.width<400? size.width*0.1:60,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Center(
                        child: Text(
                          page == 3 ? 'Info' : 'info',
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: page == 3 ? verde : Colors.grey),
                        ),
                      ),
                    ),
                    // SizedBox(height: size.height/0.05,),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: page == 3 ? indicador() : indicadorDes(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        _menuGlobalResp.length == 0
            ? Container()
            : Expanded(
                // height: size.height / 1.8,
                // width: double.infinity,
                child: page == 0
                    ? page0(
                        categorias: _menuGlobalResp,
                      )
                    : page == 1
                        ? page1(categorias: _menuGlobalResp)
                        : page == 2
                            ? page2(categorias: _menuGlobalResp)
                            : page == 3
                                ? page3()
                                : Container(),
              ),
        carrito.length != 0
            ? FadeIn(
                duration: Duration(milliseconds: 500),
                child: element['sucursal']['estado'] == 'abierto'
                    ? Container(
                        decoration: ShapeDecoration(
                          color: verde,
                          shape: RoundedRectangleBorder(
                              //  side: BorderSide(),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, bottom: 20, right: 20, top: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Precio Total',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: blanco),
                                  ),
                                  Text(
                                    'COP ${formatter.format(int.parse(precioTotal.toString()))}',
                                    style: TextStyle(color: amarillo),
                                  ),
                                ],
                              ),
                              Container(
                                // height: size.width*0.2,
                                // color: Colors.amber,
                                //  width: size.width/1.8,

                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                              decoration: ShapeDecoration(
                                                color: Colors.redAccent,
                                                shape: RoundedRectangleBorder(
                                                    //  side: BorderSide(width:3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              width: 120,
                                              height: 45,
                                              child: RaisedButton(
                                                highlightElevation: 0,
                                                elevation: 0,
                                                color: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    //  side: BorderSide(width:3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                onPressed: () {
                                                  ordenar();
                                                },
                                                child: Center(
                                                    child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Ordenar',
                                                      style: TextStyle(
                                                          color: blanco,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Container(
                                                          decoration:
                                                              ShapeDecoration(
                                                            // gradient: RadialGradient(
                                                            //       radius: 1.4,
                                                            //       List: [
                                                            //         verdeClaro,
                                                            //         amarillo,
                                                            //       ]),
                                                            //  color: Colors.redAccent,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          // radius: 13,
                                                          // backgroundColor: amarillo,
                                                          // backgroundColor: ,
                                                          width: 20,
                                                          height: 20,
                                                          // decoration: BoxDecoration(

                                                          // ),
                                                          child: Center(
                                                              child: Text(
                                                            '${carrito.length}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: blanco,
                                                                fontSize: 12),
                                                          )),
                                                        )),
                                                  ],
                                                )),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        width: size.width,
                        child: Center(
                            child: Text(
                          'Cerrado',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                        height: 50,
                        decoration: ShapeDecoration(
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              //  side: BorderSide(),

                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                        ),
                      ),
              )
            : Container(),
      ],
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

  page0({dynamic categorias}) {
    List<Widget> listWidget = [];
    int index = 1;
    categorias.forEach((element) {
      index += 1;
      listWidget.add(categoria(categoria: element, index: index));
    });

    return categorias.length != 0
        ? Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: listWidget,
              ),
            ),
          )
        : Center(
            child: Container(
              child: Text(
                'No hay productos en esta sucursal',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
          );
  }

  page1({dynamic categorias}) {
    List<Widget> listWidget = [];
    int index = 1;
    categorias.forEach((element) {
      index += 1;
      listWidget.add(categoria(categoria: element, filtro: 'C', index: index));
    });

    return categorias.length != 0
        ? Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: listWidget,
              ),
            ),
          )
        : Center(
            child: Container(
              child: Text(
                'No hay productos en esta sucursal',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
          );
  }

  page2({dynamic categorias}) {
    List<Widget> listWidget = [];
    int index = 1;
    categorias.forEach((element) {
      index += 1;
      listWidget.add(categoria(categoria: element, filtro: 'P', index: index));
    });

    return categorias.length != 0
        ? Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: listWidget,
              ),
            ),
          )
        : Center(
            child: Container(
              child: Text(
                'No hay productos en esta sucursal',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
          );
  }

  page3() {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sucursal: ${element['sucursal']['nombre']}',
              style: TextStyle(shadows: [BoxShadow(color: Colors.black)]),
            ),
            SizedBox(
              height: 5,
            ),
            Text('Direccion:  ${element['sucursal']['direccion']}'),
            SizedBox(
              height: 5,
            ),
            Text('Telefono:  ${element['sucursal']['telefono']}'),
            SizedBox(
              height: 5,
            ),
            Text('Estado:  ${element['sucursal']['estado']}'),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      )),
    );
  }

  Widget categoria({
    dynamic categoria,
    String filtro,
    int index,
  }) {
    List<Widget> productos = [];
    if (filtro == null) {
      categoria['productos']?.forEach((element) {
        // if(element['producto'].isCombo==1){
        productos.add(producto(producto: element, index: index));
        // }
      });
    }
    if (filtro == 'C') {
      categoria['productos']?.forEach((element) {
        if (element['producto'].isCombo == 1) {
          productos.add(producto(producto: element, index: index));
        }
      });
    }
    if (filtro == 'P') {
      categoria['productos']?.forEach((element) {
        if (element['producto'].isPromo == 1) {
          productos.add(producto(producto: element, index: index));
        }
      });
    }

    return productos.length != 0
        ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: ShapeDecoration(
                    color: verde,
                    shape: RoundedRectangleBorder(
                        //  side: BorderSide(),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${categoria['nombre'] ?? 'Nombre Categoria'}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: blanco),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: ShapeDecoration(
                    color: blanco,
                    shape: RoundedRectangleBorder(
                        //  side: BorderSide(),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: productos),
                )
              ],
            ),
          )
        : Container();
  }

  pedir() async {
    peticion = true;
    _menuGlobalResp = [];
    Map _resp = await peticionesHttpProvider.getMethod(
        context: context,
        table:
            'categoria_sucursales?user=${element['aliado']['id']}&id_sucursal=${element['sucursal']['id']}',
        token: pref.token);

    var model = respCategoriaSucursalesFromJson(_resp['resp']);

    if (model.data == null || model.data.length == 0) {
      _menuGlobalResp = 'vacio';
    } else {
      print(model.data);

      model.data?.forEach((obg) async {
        Map _respuesta = await peticionesHttpProvider.getMethod(
          context: context,
          table: 'existencia?id_categoria=${obg.id}',
          token: pref.token,
        );
        if (_respuesta['message'] == "expiro") {
          Navigator.of(context).pushReplacementNamed('IniciarSesion');
          alerta(context,
              titulo: 'alerta',
              code: false,
              contenido:
                  'Tiempo de conexion agotado, inicie sesion nuevamente.');
          await funciones.closeSection(context);
        }

        if (_respuesta['message'] == 'true') {
          dynamic lista = [];
          final respCategoriaExistencia =
              respCategoriaExistenciaFromJson(_respuesta['resp']);

          respCategoriaExistencia.data.forEach((element) {
            lista.add({
              "cantidad_pedir": 0,
              "producto": element.producto,
              "existencia": "${element.existencia}"
            });
          });

          _menuGlobalResp.add({
            "id": "${obg.id}",
            "nombre": "${obg.nombre}",
            "productos": lista
          });
          setState(() {});
          // print(obg.id);
        }
      });
    }
    setState(() {});
  }

  producto({dynamic producto, int index}) {
    size = MediaQuery.of(context).size;
    return FadeIn(
      delay: Duration(milliseconds: 200 * index),
      duration: Duration(milliseconds: 700),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: producto['producto'].isPromo == 1
              ? ShapeDecoration(
                  color: Color.fromRGBO(255, 206, 69, 0.1),
                  shape: RoundedRectangleBorder(
                      //  side: BorderSide(),
                      borderRadius: BorderRadius.circular(10)),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.5,
                              child: Text(
                                '${producto['producto'].titulo}',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: size.width / 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width / 40,
                            ),
                            producto['producto'].isPromo == 1
                                ? Column(
                                    children: [
                                      Text(
                                        '\$${formatter.format(int.parse(producto['producto'].precio.toString()))}',
                                        style: TextStyle(
                                          decoration:
                                              producto['producto'].isPromo == 1
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                          fontSize: size.width / 35,
                                        ),
                                      ),
                                      Text(
                                        '\$${formatter.format(int.parse(producto['producto'].precioPromo.toString()))}',
                                        style: TextStyle(
                                          //  decoration:producto['producto'].isPromo==1? TextDecoration.lineThrough:TextDecoration.none,
                                          fontWeight: FontWeight.bold,
                                          color: verde,
                                          fontSize: size.width / 35,
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    '\$${formatter.format(int.parse(producto['producto'].precio.toString()))}',
                                    style: TextStyle(
                                      decoration:
                                          producto['producto'].isPromo == 1
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                      fontSize: size.width / 35,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Container(
                          // color: Colors.green,
                          width: size.width * 0.5,
                          child: Text(
                            '${producto['producto'].descripcion}',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: size.width / 35, color: Colors.grey),
                          )),
                      producto['existencia'] != 'indefinido'
                          ? Container(

                              // color: Colors.greenAccent,
                              width: size.width * 0.5,
                              child: Text(
                                'Unidades: ${formatter.format(int.parse(producto['existencia'].toString()))}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width / 35,
                                    color: Colors.blueGrey),
                              ))
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // numero -= 1;
                                if (producto['cantidad_pedir'] > 0) {
                                  producto['cantidad_pedir'] -= 1;
                                }
                                ordenarCarrito();
                              });
                            },
                            child: Image(
                                width: size.width / 17,
                                image: AssetImage('assets/Min.png')),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 2.0, left: 2.0),
                            child: Text(
                                '${producto['cantidad_pedir'].toString()}'),
                            // cantidad_pedir
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // numero += 1;
                                if (producto['existencia'] == 'indefinido') {
                                  producto['cantidad_pedir'] += 1;
                                } else {
                                  if (producto['cantidad_pedir'] <
                                      int.parse(producto['existencia'])) {
                                    producto['cantidad_pedir'] += 1;
                                  }
                                }
                                ordenarCarrito();
                              });
                            },
                            child: Image(
                              width: size.width / 17,
                              image: AssetImage('assets/Add.png'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ordenarCarrito() {
    precioTotal = 0;
    carrito = [];

    _menuGlobalResp?.forEach((element) {
      element['productos']?.forEach((obg) {
        if (obg['cantidad_pedir'] != 0 && obg['producto'].isPromo == 0) {
          carrito.add(obg);
          int precio = int.parse(obg['producto'].precio.toString());
          int cantidad = obg['cantidad_pedir'];
          int total = precio * cantidad;
          precioTotal += total;
        }

        if (obg['cantidad_pedir'] != 0 && obg['producto'].isPromo == 1) {
          carrito.add(obg);
          int precio = int.parse(obg['producto'].precioPromo.toString());
          int cantidad = obg['cantidad_pedir'];
          int total = precio * cantidad;
          precioTotal += total;
        }

        // producto
        // cantidad_pedir
      });
    });
    setState(() {});
  }

  ordenar() {
    Navigator.pushNamed(context, 'Ordenar', arguments: {
      "precioTotal": "$precioTotal",
      "Carrito": carrito,
      "sucursal": element['sucursal']['id'],
      "aliado_id": element['aliado']['id'],
    });
  }
}

// class Producto extends StatefulWidget {
//   dynamic producto;
//   Producto({Key key, this.producto,}) : super(key: key);

//   @override
//   _ProductoState createState() => _ProductoState();
// }

// class _ProductoState extends State<Producto> {

//   final formatter = new NumberFormat("###,###,###", "es-co");
//   // int numero = 0;
//   Size size;
//   @override
//   Widget build(BuildContext context) {
//     // categoriaResp= widget.categoria;
//     size = MediaQuery.of(context).size;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(
//             top: 20,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: size.width*0.5,
//                       child: Text(
//                         '${widget.producto['producto'].titulo}',
//                         overflow: TextOverflow.clip,
//                         style: TextStyle(
//                           fontSize: size.width / 30,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: size.width / 40,
//                     ),
//                     Text(
//                       '\$${formatter.format(int.parse(widget.producto['producto'].precio.toString()))}',
//                       style: TextStyle(
//                         fontSize: size.width / 35,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                   width: size.width *0.5,
//                   child: Text(
//                     '${widget.producto['producto'].descripcion}',
//                      overflow: TextOverflow.clip,
//                     style: TextStyle(
//                       fontSize: size.width / 35, color: Colors.grey),
//                   )),
//               widget.producto['existencia'] != 'indefinido'
//                   ? Container(
//                       width: size.width / 1.5,
//                       child: Text(
//                         'Unidades: ${formatter.format(int.parse(widget.producto['existencia'].toString()))}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                             fontSize: size.width / 35, color: Colors.blueGrey),
//                       ))
//                   : Container(),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(3.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         // numero -= 1;
//                         if(widget.producto['cantidad_pedir']>0){
//                           widget.producto['cantidad_pedir'] -= 1;
//                         }
//                       });
//                     },
//                     child: Image(
//                         width: size.width / 15,
//                         image: AssetImage('assets/Min.png')),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8.0, left: 8.0),
//                     child: Text('${widget.producto['cantidad_pedir'].toString()}'),
//                     // cantidad_pedir
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {

//                         // numero += 1;
//                         if(widget.producto['existencia']=='indefinido'){
//                            widget.producto['cantidad_pedir'] += 1;
//                         }else{

//                           if(widget.producto['cantidad_pedir'] < int.parse(widget.producto['existencia'])){
//                           widget.producto['cantidad_pedir'] += 1;
//                         }

//                         }

//                       });
//                     },
//                     child: Image(
//                       width: size.width / 15,
//                       image: AssetImage('assets/Add.png'),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
