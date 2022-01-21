import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:traelo_app/src/pages/vistasAliado/inicioAliado/publicarAliado/models/respAliadoModel.dart';
// import 'package:traelo_app/src/pages/vistasCliente/inicio/model/respAliadoCategoriaModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/drawer/drawer.dart';
import 'package:traelo_app/src/utils/model/respAliadoCategoriaModel.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

import 'model/sucursalMode.dart';

// import 'model/respCategoriaModel.dart';
class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  PeticionesHttpProvider http = PeticionesHttpProvider();
  PreferenciasUsuario pref = new PreferenciasUsuario();
  FocusNode buscarFocus = new FocusNode();
  TextEditingController buscarController = new TextEditingController();
  dynamic globalRespCategoria;
  Funciones funciones = new Funciones();
  dynamic globalRespAliados = [];
  bool buscador = false;
  bool peticiones = false;
  int selectCategoria = 0;
  Size size;
  @override
  Widget build(BuildContext context) {
    if (pref.ultima_pagina != 'iniciocliente') {
      pref.ultima_pagina = 'iniciocliente';
    }
    size = MediaQuery.of(context).size;
    print(pref.token);
    if (peticiones == false) {
      peticiones = true;

      pedir(context);
    }
    // int variable = 0;
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(height: 20),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 20.0, bottom: 20),
          //       child: Container(
          //         width: size.width * 0.9,
          //         child: Card(
          //           child: TextFormField(
          //             decoration: InputDecoration(
          //                 prefixIcon: Icon(Icons.search),
          //                 hintText: "Buscar Sucursales",
          //                 border: InputBorder.none),
          //             focusNode: buscarFocus,
          //             controller: buscarController,
          //             onFieldSubmitted: (value) async {
          //               buscador = false;
          //               setState(() {});
          //               await Future.delayed(Duration(milliseconds: 500));
          //               buscarFocus.requestFocus();
          //               buscador = true;
          //               setState(() {});
          //             },
          //             onChanged: (value) {
          //               if (buscador == false) {
          //                 buscador = true;
          //                 setState(() {});
          //               }
          //               print("Focus Activado wey");
          //             },
          //           ),
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          // Buscador(),
          // proveedor()

          buscador == false
              ? Container(
                  // decoration: ShapeDecoration(color: verdeClaro,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)))),
                  width: size.width,

                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: globalRespCategoria == null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: amarillo,
                                strokeWidth: 1,
                              )),
                            )
                          : globalRespCategoria == 'vacio'
                              ? Center(
                                  child: Text(
                                    'No hay Categoria',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: globalRespCategoria,
                                  ))),
                )
              : Container(),

          // Divider(),
          buscador == false
              ? selectCategoria == 0
                  ? Container()
                  : Expanded(
                      child: Body(
                      selectCategoria: selectCategoria,
                      gobalContext: context,
                      peticion: false,
                    ))
              : Expanded(
                  child: Buscador(
                  nombre: buscarController.text,
                ))
        ],
      ),
      drawer: MenuDesplegable(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                globalRespCategoria = null;
                peticiones = false;
                selectCategoria = 0;
                setState(() {});
              })
        ],
        leading: buscador == false
            ? Builder(builder: (context) {
                return IconButton(
                    icon: Image(
                        // width: _size.width / 80,
                        image: AssetImage('assets/menu.png')),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    });
              })
            : IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  if (buscarFocus.hasFocus) {
                    buscarFocus.previousFocus();
                  }
                  buscador = false;
                  buscarController.text = '';
                  setState(() {});
                }),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(19, 166, 7, 1)),
        backgroundColor: Color.fromRGBO(255, 241, 1, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                '${pref.nombre}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: verde,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
    );
  }

  Widget categoria(BuildContext context,
      {nombre, String imagen, int id, int index}) {
    // Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return FadeIn(
      delay: Duration(milliseconds: 100 * index),
      duration: Duration(milliseconds: 1000),
      child: GestureDetector(
        onTap: () {
          selectCategoria = id;
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10.5),
          child: Column(
            children: [
              Container(
                width: 67,
                // width: 120,

                height: 66,
                // height: 120,

                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                child: Card(
                  margin: const EdgeInsets.all(0),
                  // color: Colors.white,
                  child: Stack(
                    children: [
                      Image(
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        image: AssetImage('assets/logo_mano.png'),

                        // placeholder: ,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('${storage + imagen ?? ""}'),
                            )),
                      ),
                    ],
                  ),
                  shadowColor: Colors.grey,
                  elevation: 2.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  nombre ?? '???',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 9,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  pedir(context) async {
    try {
      List<Widget> widgets = [];
      dynamic resp = await http.getMethod(
        context: context,
        table: 'categorias',
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
        final model = respAliadoCategoriaModelFromJson(resp['resp']);
        // selectCategoria = null;
        if (model.data.data.length == 0) {
          globalRespCategoria = 'vacio';
          setState(() {});
        } else {
          selectCategoria = model.data.data[0].id;
          // setState(() {

          // });
          int index = 1;
          index = 1;
          model.data.data.forEach((element) {
            index += 1;

            widgets.add(categoria(context,
                nombre: element.titulo,
                imagen: element.urlImagen,
                id: element.id,
                index: index));
          });
          globalRespCategoria = [];
          globalRespCategoria = widgets;
          setState(() {});
        }

        //  print('---------------------------------------------------------------------ok');
      } else {
        if (resp['message'] == "expiro") {
          Navigator.of(context).pushReplacementNamed('IniciarSesion');
          alerta(context,
              titulo: 'alerta',
              code: false,
              contenido:
                  'Tiempo de conexion agotado, inicie sesion nuevamente.');
          await funciones.closeSection(context);
        }
      }
    } catch (e) {
      return alerta(context, contenido: 'error', code: false);
    }
  }
}

class Body extends StatefulWidget {
  bool peticion;
  int selectCategoria;
  BuildContext gobalContext;

  // int page = 0;
  int current_page = 1;
  Body({
    Key key,
    this.selectCategoria,
    this.gobalContext,
    this.peticion,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Widget> respGlobal;
  PeticionesHttpProvider http = PeticionesHttpProvider();
  PreferenciasUsuario pref = PreferenciasUsuario();
  // bool peticion;
  Size size;
  Funciones funciones = new Funciones();
  bool busqueda = true;
  int busqueda2 = 0;
  bool peticion = false;
  String finScroll = '';
  int current_page = 1;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('--------------------------fin---------------------------');

        pedir20();
      }
    });
    // print(_scrollController.);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectCategoria == 0) {
      setState(() {});
      respGlobal = null;
    }
    size = MediaQuery.of(context).size;

//  peticion = widget.peticion;
    if (widget.peticion == false) {
      widget.peticion = true;
      pedir();
    }
    return widget.selectCategoria == 0
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: amarillo,
            strokeWidth: 1,
          ))
        : respGlobal == null
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: amarillo,
                strokeWidth: 1,
              ))
            : SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    Column(
                      children: respGlobal,
                    ),
                    busqueda2 == 0
                        ? Container()
                        : busqueda2 == 1
                            ? Center(
                                child: CircularProgressIndicator(
                                  //center mirra pa ve

                                  backgroundColor: amarillo,
                                  strokeWidth: 1,
                                ),
                              )
                            : busqueda2 == 2
                                ? Center(child: Text(finScroll))
                                : Container(),
                  ]),
                ),
              );
  }

  Widget ordenarProveedores(BuildContext context,
      {bool reverso = false,
      String nombre,
      List listaSucursales,
      String idAliado,
      int index}) {
    // Orientation orientation = MediaQuery.of(context).orientation;
    List<Widget> sucursales = [];
    if (listaSucursales.length == 0) {
      sucursales.add(Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
            child: Text(
          'No hay Sucursales aqui',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        )),
      ));
    } else {
      listaSucursales.forEach((element) {
        sucursales.add(proveedor(
          context: context,
          direccion: '${element.direccion}',
          nombre: '${element.nombre}',
          telefono: '${element.telefono}',
          estado: '${element.estado}',
          idcursal: element.id.toString(),
          idAliado: idAliado,
          index: index,
          imagenPerfil: element.urlFotoPerfil,
          imagenPortada: element.urlFotoPortada,
        ));
      });
    }
    var widget = FadeIn(
      delay: Duration(milliseconds: 100 * index),
      duration: Duration(milliseconds: 1000),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                        width: size.width < 187
                            ? 50
                            : size.width < 228
                                ? 80
                                : size.width < 304
                                    ? 120
                                    : 180,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '${nombre ?? '??? '}',
                            // textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: sucursales,
              ),
            )
            // Aliado(listaSucursales:listaSucursales,)
          ],
        ),
      ),
    );
    return listaSucursales.length != 0 ? widget : Container();
  }

  Widget proveedor(
      {BuildContext context,
      String estado,
      String imagenPortada,
      String imagenPerfil,
      String nombre,
      String direccion,
      String idcursal,
      String idAliado,
      String telefono,
      int index}) {
    bool tap = false;
    // Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return FadeIn(
      delay: Duration(milliseconds: 100 * index),
      duration: Duration(milliseconds: 1000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              tap = true;
              Navigator.of(context).pushNamed('proovedor', arguments: {
                'sucursal': {
                  'id': idcursal,
                  'imagenPortada': "${storage + imagenPortada}",
                  "imagenPerfil": "${storage + imagenPerfil}",
                  'direccion': '$direccion',
                  'nombre': '$nombre',
                  'telefono': '$telefono',
                  'estado': "$estado",
                },
                'aliado': {'id': idAliado}
              });
              //  tap = false;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 140,
                        height: 160,
                        child: Stack(
                          children: [
                            imagenPerfil != null
                                ? Container(
                                    width: 140,
                                    child: Image.network(
                                      storage + imagenPerfil,
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    ))
                                : Container(),
                            estado == 'cerrado'
                                ? Transform.rotate(
                                    angle: -18,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0,
                                          bottom: 130,
                                          left: 0,
                                          right: 15),
                                      child: Container(
                                        child: Center(
                                            child: Text(
                                          'Cerrado',
                                          style: TextStyle(
                                              color: blanco,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        color: rojo,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),

                        // color: Colors.white,
                        // width: size.width > 310
                        //     ? 160
                        //     : size.width < 298 ? 150 : 150,

                        decoration: BoxDecoration(
                            color: gris,
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Container(
                          width: 38,
                          // height: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 3.0, bottom: 3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(
                                      '$idcursal',
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: verde),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: amarillo,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(40),
                                  right: Radius.circular(40)))),
                    ),
                    Positioned(
                      left: 5,
                      bottom: 0.0,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: size.width < 250
                                      ? 100
                                      : size.width > 450
                                          ? 108
                                          : 108,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: imagenPortada != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image(
                                              image: NetworkImage(
                                                  storage + imagenPortada),
                                              // fit: BoxFit.cover,

                                              // fit: BoxFit.cover,
                                              width: size.width < 250
                                                  ? 100
                                                  : size.width > 450
                                                      ? 108
                                                      : 108,
                                              height: 30,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      borderRadius: BorderRadius.only())),
                              Text('${nombre ?? '???'}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Text(
                                  '${direccion ?? '???'}',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                        width: 130,
                        // height: 60,
                        decoration: BoxDecoration(
                            color:
                                tap == true ? Colors.amberAccent : Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2.5),
                                topRight: Radius.circular(2.5))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pedir20() async {
    if (busqueda == true) {
      current_page++;
      setState(() {
        busqueda2 = 1;
      });
      Map _resp = await http.getMethod(
          table:
              'AliadoCategorias?id_categoria=${widget.selectCategoria}&page=$current_page',
          context: context,
          token: pref.token);
      // _resp[''];
      if (_resp['message'] == "expiro") {
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        await funciones.closeSection(context);
        return alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
      }
      if (_resp['message'] == 'true') {
        var respAliadoCategoria = respAliadoCategoriaFromMap(_resp['resp']);

        if (respAliadoCategoria.data.data.length == 0) {
          busqueda = false;
          busqueda2 = 2;
          setState(() {});
          respGlobal.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No mas Aliados Aqui',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )
            ],
          ));
        } else {
          if (busqueda == false) {
            setState(() {
              busqueda = true;
            });
          }
          int index = 1;
          index = 1;

          busqueda2 = 0;
          respAliadoCategoria.data.data.forEach((element) {
            index += 1;
            respGlobal.add(ordenarProveedores(widget.gobalContext,
                nombre: element.aliado.nombre,
                listaSucursales: element.aliado.sucursales,
                idAliado: element.aliado.id.toString(),
                index: index));
          });
        }
        setState(() {});
      } else {}
    } else {
      // return ;
    }
  }

  pedir() async {
    Map _resp = await http.getMethod(
        table: 'AliadoCategorias?id_categoria=${widget.selectCategoria}',
        context: context,
        token: pref.token);
    // _resp[''];
    if (_resp['message'] == "expiro") {
      Navigator.of(context).pushReplacementNamed('IniciarSesion');
      await funciones.closeSection(context);
      return alerta(context,
          titulo: 'alerta',
          code: false,
          contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
    }
    if (_resp['message'] == 'true') {
      var respAliadoCategoria = respAliadoCategoriaFromMap(_resp['resp']);
      respGlobal = [];
      if (respAliadoCategoria.data.data.length == 0) {
        respGlobal.add(Center(
            child: Text(
          'No hay Aliados Aqui',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        )));
      } else {
        int index = 1;
        index = 1;
        respAliadoCategoria.data.data.forEach((element) {
          index += 1;

          respGlobal.add(ordenarProveedores(widget.gobalContext,
              nombre: element.aliado.nombre,
              listaSucursales: element.aliado.sucursales,
              idAliado: element.aliado.id.toString(),
              index: index));
        });
      }
      setState(() {});
    }
  }
}

class Buscador extends StatefulWidget {
  final String nombre;
  const Buscador({Key key, this.nombre})
      : super(
          key: key,
        );

  @override
  _BuscadorState createState() => _BuscadorState();
}

Size size;
PreferenciasUsuario pref = new PreferenciasUsuario();
PeticionesHttpProvider http = new PeticionesHttpProvider();
Funciones funciones = new Funciones();

class _BuscadorState extends State<Buscador> {
  @override
  void dispose() {
    super.dispose();
  }

  dynamic globalRespCategoria;
  bool peticion = false;
  @override
  Widget build(BuildContext context) {
    if (peticion == false) {
      peticion = true;
      pedir(context);
    }
    size = MediaQuery.of(context).size;

    return Container(
      child: GridView.count(
          crossAxisCount:
              globalRespCategoria == "vacio" || globalRespCategoria == null
                  ? 1
                  : 2,
          children: globalRespCategoria == null
              ? [Center(child: CircularProgressIndicator())]
              : globalRespCategoria == "vacio"
                  ? [
                      Center(
                        child: Text(
                          'Vacio',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]
                  : globalRespCategoria),
    );
  }

  pedir(context) async {
    int i = 0;
    // final size = MediaQuery.of(context).size;

    try {
      List<Widget> widgets = [];
      // load(context);
      dynamic resp = await http.getMethod(
        context: context,
        table: 'consultas?rol=cliente&filtro=sucursal&dato=${widget.nombre}',
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
        final model = respSucursalesFromJson(resp['resp']);
        print(model.message);
        // if (model.message != 'Unauthenticated.') {
        if (model.data.data.length == 0) {
          globalRespCategoria = 'vacio';
          setState(() {});
        } else {
          model.data.data.forEach((element) {
            i++;
            widgets.add(proveedor(
              context: context,
              direccion: '${element.direccion}',
              nombre: '${element.nombre}',
              telefono: '${element.telefono}',
              estado: '${element.estado}',
              idcursal: element.id.toString(),
              idAliado: '${element.idAliado}',
              index: i,
              imagenPerfil: element.urlFotoPerfil,
              imagenPortada: element.urlFotoPortada,
            ));
          });
          globalRespCategoria = [];
          globalRespCategoria = widgets;
          setState(() {});
        }

        // } else {
        //  Navigator.of(context).pushReplacementNamed('IniciarSesion');
        //   await funciones.closeSection(context);
        // }

        //  print('---------------------------------------------------------------------ok');
      }
    } catch (e) {
      // print("EL ERROR ES:-------------" + e);
      return alerta(context, contenido: 'e', code: false);
    }
  }

  Widget proveedor(
      {BuildContext context,
      String estado,
      String imagenPortada,
      String imagenPerfil,
      String nombre,
      String direccion,
      String idcursal,
      String idAliado,
      String telefono,
      int index}) {
    bool tap = false;
    // Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return FadeIn(
      delay: Duration(milliseconds: 100 * index),
      duration: Duration(milliseconds: 1000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              tap = true;
              Navigator.of(context).pushNamed('proovedor', arguments: {
                'sucursal': {
                  'id': idcursal,
                  'imagenPortada': "${storage + imagenPortada}",
                  "imagenPerfil": "${storage + imagenPerfil}",
                  'direccion': '$direccion',
                  'nombre': '$nombre',
                  'telefono': '$telefono',
                  'estado': "$estado",
                },
                'aliado': {'id': idAliado}
              });
              //  tap = false;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 140,
                        height: 160,
                        child: Stack(
                          children: [
                            imagenPerfil != null
                                ? Container(
                                    width: 140,
                                    child: Image.network(
                                      storage + imagenPerfil,
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    ))
                                : Container(),
                            estado == 'cerrado'
                                ? Transform.rotate(
                                    angle: -18,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0,
                                          bottom: 130,
                                          left: 0,
                                          right: 15),
                                      child: Container(
                                        child: Center(
                                            child: Text(
                                          'Cerrado',
                                          style: TextStyle(
                                              color: blanco,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        color: rojo,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),

                        // color: Colors.white,
                        // width: size.width > 310
                        //     ? 160
                        //     : size.width < 298 ? 150 : 150,

                        decoration: BoxDecoration(
                            color: gris,
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Container(
                          width: 38,
                          // height: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 3.0, bottom: 3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(
                                      '$idcursal',
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: verde),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: amarillo,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(40),
                                  right: Radius.circular(40)))),
                    ),
                    Positioned( 
                      left: 5,
                      bottom: 0.0,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: size.width < 250
                                      ? 100
                                      : size.width > 450
                                          ? 108
                                          : 108,
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: imagenPortada != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image(
                                              image: NetworkImage(
                                                  storage + imagenPortada),
                                              // fit: BoxFit.cover,

                                              // fit: BoxFit.cover,
                                              width: size.width < 250
                                                  ? 100
                                                  : size.width > 450
                                                      ? 108
                                                      : 108,
                                              height: 30,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      borderRadius: BorderRadius.only())),
                              Text('${nombre ?? '???'}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Text(
                                  '${direccion ?? '???'}',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // width: 130,
                        // height: 60,
                        decoration: BoxDecoration(
                            color:
                                tap == true ? Colors.amberAccent : Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2.5),
                                topRight: Radius.circular(2.5))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
