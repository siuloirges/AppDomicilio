// import 'dart:js';

// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/models/respGetProductos.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/CategoriaSucursal/models/respExistencia.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/model/respGetProductos.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';
import 'package:http/http.dart' as http;

class FormularioMenu extends StatefulWidget {
  // const FormularioMenu({Key key}) : super(key: key);

  @override
  _FormularioMenuState createState() => _FormularioMenuState();
}

class _FormularioMenuState extends State<FormularioMenu> {
  dynamic _globalRespProductos = [];
  dynamic _globalRespExistencia = [];
  Funciones funciones = new Funciones();
  Size size;

  PeticionesHttpProvider peticiones = new PeticionesHttpProvider();

  TextEditingController existenciaController = new TextEditingController();

  PreferenciasUsuario pref = PreferenciasUsuario();

  Validaciones validar = new Validaciones();
  var formKey = GlobalKey<FormState>();

  Map element;

  bool peticion = false;

//   @override
//  void dispose() {

//   peticion=false;
//   print(peticion);
//  }

//   @override
//   void initState() {

//    peticion=true;
//   //   pedir();
//   //   pedirExistecia();
//   //   print(peticion);
//   }
  @override
  void initState() {
    super.initState();
  }

  dynamic formatter;
  @override
  Widget build(BuildContext context) {
    print(pref.token);
    element = ModalRoute.of(context).settings.arguments;
    formatter = new NumberFormat("###,###,###", "es-co");
    // double top = size.width;
    if (peticion == false) {
      peticion = true;
      pedir();
      pedirExistecia();
    }

    size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: verde,
        // mini: true,
        child: Icon(Icons.add, color: blanco),
        onPressed: _globalRespProductos != []
            ? () {
                Navigator.of(context)
                    .pushNamed('FormularioAnadirProducto', arguments: {
                  'productos': _globalRespProductos,
                  'id_categoria': '${element['id_categoria']}',
                  'id_sucursal': '${element['sucursal'].id}'
                });
              }
            : null,
      ),
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Editar Categoria",
          style: TextStyle(color: negro),
        ),
        actions: [
          element['ruta'] != "crear"
              ? IconButton(
                  icon: Icon(Icons.replay_outlined),
                  onPressed: peticion == true
                      ? () {
                          print(pref.token);
                          _globalRespProductos = null;
                          peticion = false;
                          setState(() {});
                        }
                      : null)
              : Container()
        ],
        backgroundColor: amarillo,
        iconTheme: IconThemeData(color: verde),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width,
                color: verde,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        '${element['categoria']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: blanco),
                      )),
                    ),
                    Center(
                        child: IconButton(
                            onPressed: () {
                              String nombre;
                              return alerta(context,
                                  contenido: Column(
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                            hintText: element['categoria']),
                                        onSaved: (newValue) =>
                                            nombre = newValue,
                                        onChanged: (newValue) =>
                                            nombre = newValue,
                                        validator: (value) =>
                                            validar.validateName(value),
                                      )
                                    ],
                                  ),
                                  acciones: GestureDetector(
                                      onTap: () async {
                                        Map _resp = await peticiones.putMethod(
                                            body: {
                                              "nombre": "$nombre",
                                              "id_sucursal":
                                                  "${element['sucursal'].id}",
                                              "id_aliado": "${pref.id_aliado}"
                                            },
                                            table: 'categoria_sucursales',
                                            context: context,
                                            token: pref.token,
                                            id: int.parse(
                                                element['id_categoria']));
//00110011
                                        if (_resp['message'] == 'true') {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          setState(() {
                                            peticion = false;
                                          });
                                        }
                                      },
                                      child: Container(
                                        child: Icon(Icons.done,
                                            color: Colors.white),
                                        width: 55,
                                        height: 55,
                                        decoration: ShapeDecoration(
                                            color: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      )));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ))),
                  ],
                ),
              ),

              _globalRespExistencia.length != 0
                  ? _globalRespExistencia == 'vacio'
                      ? Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Center(
                                  child: Text(
                                'No hay productos en esta Categoria',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                        )
                      : Flexible(
                          child: Container(
                              height: size.height, child: existencia(context)),
                        )
                  : Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(
                              child: CircularProgressIndicator(
                            backgroundColor: amarillo,
                            strokeWidth: 1,
                          )),
                        ],
                      ),
                    ),
              // guardar(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget existencia(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: _globalRespExistencia.length,
            itemBuilder: (BuildContext context, int i) {
              return GestureDetector(
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: ShapeDecoration(
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              height: 100,
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _globalRespExistencia[i].producto.isPromo == 1
                                      ? Container(
                                          decoration: ShapeDecoration(
                                              color: Colors.redAccent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(17),
                                                bottomLeft: Radius.circular(17),
                                              ))),
                                          child: Center(
                                            child: Text(
                                              'Promo',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          // color: Colors.white,
                                          height: 25,
                                          width: 100,
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: size.width / 1.8,
                                        child: Text(
                                          'producto: ${_globalRespExistencia[i].producto.titulo}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        _globalRespExistencia[i]
                                                    .producto
                                                    .isPromo ==
                                                1
                                            ? 'Precio promo: \$${_globalRespExistencia[i].producto.precioPromo}'
                                            : 'Precio: \$${_globalRespExistencia[i].producto.precio}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Cantidad: ${_globalRespExistencia[i].existencia.toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    // Text('${_globalResp[i].descripcion}'),
                                  ]),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            decoration: ShapeDecoration(
                                color: amarillo,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            width: 35,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      return alerta(
                                        context,
                                        titulo:
                                            '${_globalRespExistencia[i].producto.titulo.toString()}',
                                        contenido: Column(
                                          children: [
                                            Form(
                                              key: formKey,
                                              child: TextFormField(
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          _globalRespExistencia[
                                                                  i]
                                                              .existencia),
                                                  controller:
                                                      existenciaController,
                                                  validator: (value) => validar
                                                      .validateNumerico(value)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text(
                                                'Digite la nueva cantidad',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          ],
                                        ),
                                        // acciones:
                                        done: true,

                                        onpress: GestureDetector(
                                            onTap: () async {
                                              if (!formKey.currentState
                                                  .validate()) {
                                                return null;
                                              }
                                              load(context);
                                              try {
                                                Map resp = await peticiones
                                                    .putMethod(
                                                        id:
                                                            _globalRespExistencia[
                                                                    i]
                                                                .id,
                                                        table: 'existencia',
                                                        token: pref.token,
                                                        body: {
                                                      'existencia':
                                                          '${existenciaController.text}'
                                                    });
                                                if (resp['message'] == 'true') {
                                                  existenciaController.text =
                                                      '';
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    peticion = false;
                                                  });
                                                } else {
                                                  return alerta(context,
                                                      titulo: 'Enhorabuena',
                                                      code: false,
                                                      contenido:
                                                          '${resp['data']} ');
                                                }
                                              } catch (e) {
                                                alerta(context,
                                                    titulo: 'Sergio',
                                                    code: false,
                                                    contenido: '$e  ');
                                              }
                                            },
                                            child: Container(
                                              child: Icon(Icons.done,
                                                  color: Colors.white),
                                              width: 50,
                                              height: 50,
                                              decoration: ShapeDecoration(
                                                  color: verde,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                            )),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 13,
                                      backgroundColor: verde,
                                      child: Center(
                                        child: Icon(Icons.edit,
                                            color: Colors.white, size: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // print(categoria['id']);
                                      return alerta(context,
                                          titulo: 'Quieres eliminar',
                                          contenido: Text(
                                              '${_globalRespExistencia[i].producto.titulo.toString()}'),
                                          acciones: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      child: Icon(
                                                          Icons.arrow_back,
                                                          color: Colors.white),
                                                      decoration: ShapeDecoration(
                                                          color: Colors.grey,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      width: 50,
                                                      height: 50),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await peticiones
                                                        .deleteMethod(
                                                      context: context,
                                                      table: 'existencia',
                                                      id: int.parse(
                                                          '${_globalRespExistencia[i].id.toString()}'),
                                                      token: pref.token,
                                                    );
                                                    Navigator.pop(context);
                                                    peticion = false;
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    child: Icon(Icons.delete,
                                                        color: Colors.white),
                                                    decoration: ShapeDecoration(
                                                        color: Colors.redAccent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    },
                                    child: CircleAvatar(
                                      radius: 13,
                                      backgroundColor: verde,
                                      child: Center(
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  // Widget guardar(context) {
  //   return Row(
  //     // mainAxisSize: MainAxisSize.max,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Column(
  //         children: [
  //           Container(
  //             width: size.width,
  //             height: size.height / 10,
  //             color: Colors.teal,
  //             child: RaisedButton(
  //                 elevation: 0,
  //                 // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //                 color: verde,
  //                 child: Text(
  //                   'Atras',
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //                 onPressed: () {
  //                   submit(context);
  //                 }),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget crearCampoNombre(){
  //   return  Padding(
  //     padding: const EdgeInsets.all(30.0),
  //     child: Container(

  //       child: Column(
  //         children: [
  //           TextFormField(
  //              controller: nombreController,
  //              validator:(value){return validar.validateName(value);},
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: Center(child: Text('Nombre Categoria',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54),),),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  submit(context) async {
    Navigator.pop(context);
  }

  pedir() async {
    dynamic resp = await http.get(
      url + "/producto",
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${pref.token}',
      },
    );
    if (resp.statusCode != 200) {
      return alerta(context, contenido: '${resp.body}', code: false);
    } else {
      var respModel = respProductoFromJson(resp.body);

      _globalRespProductos = [];

      if (respModel.data == null || respModel.data?.length == 0) {
        _globalRespProductos = 'vacio';
      } else {
        _globalRespProductos = respModel.data;
        print(respModel.data);
      }
    }
    setState(() {});
  }

  pedirExistecia() async {
    //  peticion=true;

    Map _respuesta = await peticiones.getMethod(
      context: context,
      table: 'existencia?id_categoria=${element['id_categoria']}',
      token: pref.token,
    );
    if (_respuesta['message'] == "expiro") {
      Navigator.of(context).pushReplacementNamed('IniciarSesion');
      alerta(context,
          titulo: 'alerta',
          code: false,
          contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
      await funciones.closeSection(context);
    }

    if (_respuesta['message'] == 'true') {
      _globalRespExistencia = [];
      final respCategoriaExistencia =
          respCategoriaExistenciaFromJson(_respuesta['resp']);
      if (respCategoriaExistencia.data == null ||
          respCategoriaExistencia.data?.length == 0) {
        _globalRespExistencia = 'vacio';
        setState(() {});
      } else {
        respCategoriaExistencia.data.forEach((element) {
          _globalRespExistencia.add(element);
        });
        // _globalRespExistencia = respCategoriaExistencia.data.data;
        print(_respuesta['data']);
        setState(() {});
      }
    }

    if (_respuesta['message'] == 'fasle') {
      return alerta(context,
          contenido: Text('No hay conexion con el servidor'));
    }
  }
}
