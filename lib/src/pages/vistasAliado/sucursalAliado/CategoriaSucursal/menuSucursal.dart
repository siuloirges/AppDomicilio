import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:traelo_app/src/pages/vistasAliado/misOrdenesAliado/model/respuestaOrdenesAliados.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/CategoriaSucursal/models/respExistencia.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/models/resp.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:http/http.dart' as http;
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class MenuSucursal extends StatefulWidget {
  @override
  _MenuSucursalState createState() => _MenuSucursalState();
}

class _MenuSucursalState extends State<MenuSucursal> {
  dynamic _globalResp = [];
  bool peticion = false;
  PeticionesHttpProvider peticionesHttpProvider = new PeticionesHttpProvider();
  var formKey = GlobalKey<FormState>();
  Validaciones validar = Validaciones();
  Funciones funciones = new Funciones();

  TextEditingController nombreController = new TextEditingController();

  PreferenciasUsuario pref = PreferenciasUsuario();

  Map element;

  @override
  void dispose() {
    peticion = false;
    print(peticion);
    super.dispose();
    setState(() {});
  }

  @override
  void initState() {
    // rest();
    peticion = false;
    print(peticion);
    setState(() {});
    //  super.init()
  }

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    element = ModalRoute.of(context).settings.arguments;

    // print(element['sucursal'].id);
    if (peticion == false) {
      peticion = true;
      pedir();
    }

    return Scaffold(
        // backgroundColor: gris,

        // floatingActionButtonLocation:FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          onPressed: () {
            alerta(context,
                contenido: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) =>
                                validar.validateGenerico(value),
                            controller: nombreController,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Nombre categoria',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                acciones: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: verde,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Guardar',
                      style: TextStyle(color: blanco),
                    ),
                  ),
                  onPressed: () async {
                    await submit(context);
                  },
                ));
          },
          child: Icon(Icons.add),
          backgroundColor: verde,
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                rest();
              },
            )
          ],
          // actions: [
          //   IconButton(icon: Icon(Icons.replay_outlined), onPressed: (){
          //     peticion = false;
          //     setState(() {

          //     });
          //     print(peticion);
          //   })
          // ],
          title: Text(
            'Menu ${element != null ? element['sucursal'].nombre : 'nombre sucursal'}',
            style: TextStyle(
              color: negro,
            ),
          ),
          backgroundColor: amarillo,
          elevation: 0,
          iconTheme: IconThemeData(color: verde),
        ),
        body: _globalResp.length == 0
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: amarillo,
                strokeWidth: 1,
              ))
            : _globalResp == 'vacio'
                ? Center(
                    child: Text('No hay categorias',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)))
                : body());
  }

  Widget categoria({
    Map<String, dynamic> categoria,
  }) {
    List<Widget> productos = [];
    categoria['productos'].forEach((element) {
      productos.add(Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
            width: size.width * 0.8,
            child: Text(
              '${element['nombre'] ?? '???'}: ${element['existencia'].toString() ?? '???'}',
              maxLines: 2,
              overflow: TextOverflow.clip,
            )),
      ));
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0),
          child: Container(
            // decoration: ShapeDecoration(

            //   // shadows: [BoxShadow(color: Colors.black,blurRadius: 1),BoxShadow(color: Colors.white,),BoxShadow(color: Colors.white,),BoxShadow(color: Colors.white,)],
            //   // shape: RoundedRectangleBorder(),
            //   // color: Colors.white,

            // ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${categoria['categoria'] ?? 'Nombre Categoria'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: productos)
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
                                peticion = false;
                                Navigator.pushNamed(context, 'FormularioMenu',
                                    arguments: {
                                      "ruta": "nuevo",
                                      "id_categoria": categoria['id'],
                                      'categoria': categoria['categoria'],
                                      'sucursal': element['sucursal'],
                                    });
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
                                        '${categoria['categoria'].toString()}'),
                                    acciones: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                                child: Icon(Icons.arrow_back,
                                                    color: Colors.white),
                                                decoration: ShapeDecoration(
                                                    color: Colors.grey,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                width: 50,
                                                height: 50),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              await peticionesHttpProvider
                                                  .deleteMethod(
                                                context: context,
                                                id: int.parse(categoria['id']),
                                                table: 'categoria_sucursales',
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
                                                          BorderRadius.circular(
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
        ),
        Divider()
      ],
    );
  }

  pedir() async {
    peticion = true;
    _globalResp = [];
    dynamic resp = await http.get(
        url + "/categoria_sucursales?id_sucursal=${element['sucursal'].id}",
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${pref.token}'
        });

    var model = respCategoriaSucursalesFromJson(resp.body);

    print(model.data);
    if (model.data == null || model.data?.length == 0) {
      _globalResp = 'vacio';
    } else {
      model?.data?.forEach((element) async {
        Map _respuesta = await peticionesHttpProvider.getMethod(
          context: context,
          table: 'existencia?id_categoria=${element.id}',
          token: pref.token,
        );
        if (_respuesta['message'] == "expiro") {
          funciones.closeSection(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed('IniciarSesion');
          alerta(context,
              titulo: 'alerta',
              code: false,
              contenido:
                  'Tiempo de conexion agotado, inicie sesion nuevamente.');
        }

        if (_respuesta['message'] == 'true') {
          dynamic lista = [];
          final respCategoriaExistencia =
              respCategoriaExistenciaFromJson(_respuesta['resp']);

          respCategoriaExistencia?.data?.forEach((element) {
            lista.add({
              "nombre": "${element.producto.titulo}",
              "existencia": "${element.existencia}"
            });
          });
          // _globalRespExistencia = respCategoriaExistencia.data.data;
          // print(_respuesta['data']);
          setState(() {});

          _globalResp.add({
            "id": "${element.id}",
            "nombre": "${element.nombre}",
            "productos": lista
          });
          print(element.id);
        }
        //   if(_respuesta['message'] == 'fasle'){
        //   return  alerta(context,contenido: Text(_respuesta['data']));
        //  }
      });
    }

    setState(() {});
  }

  body() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _globalResp.length,
            itemBuilder: (c, i) {
              return categoria(categoria: {
                "id": "${_globalResp[i]['id']}",
                "categoria": "${_globalResp[i]['nombre']}",
                "productos": _globalResp[i]['productos']
              });
            },
          ),
        ),
        Container(
          //00110011
          color: gris,
          width: size.width,
          height: 85,
          child: FlatButton(
            onPressed: () {
              return alerta(context,
                  titulo: 'Cambiar estado A',
                  contenido: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            print("------------" +
                                element['sucursal'].toString());
                            if (element['sucursal'].idAsistente == null) {
                              return alerta(context,
                                  code: false,
                                  contenido:
                                      'No puedes cambiar el estado a una sucursal sin asistente.',
                                  acciones: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, 'UsuariosAliado');
                                    },
                                    elevation: 0,
                                    color: verde,
                                    child: Text(
                                      'Añadir asistente',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ));
                            }
                            if (element['sucursal'].estado == 'abierto') {
                              return alerta(context,
                                  code: false,
                                  contenido: 'El estado ya es "abierto"');
                            } else {
                              _cambiar_estado('abierto');
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: verde,
                                borderRadius: BorderRadius.circular(10)),
                            width: 200,
                            height: 40,
                            child: Center(
                                child: Text(
                              'Abierto',
                              style: TextStyle(
                                  color: blanco, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            if (element['sucursal'].idAsistente == null) {
                              return alerta(context,
                                  code: false,
                                  contenido:
                                      'No puedes cambiar el estado a una sucursal sin asistente.',
                                  acciones: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, 'UsuariosAliado');
                                    },
                                    elevation: 0,
                                    color: verde,
                                    child: Text(
                                      'Añadir asistente',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ));
                            }
                            if (element['sucursal'].estado == 'cerrado') {
                              return alerta(context,
                                  code: false,
                                  contenido: 'El estado ya es "cerrado"');
                            }
                            _cambiar_estado('cerrado');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: rojo,
                                borderRadius: BorderRadius.circular(10)),
                            width: 200,
                            height: 40,
                            child: Center(
                                child: Text(
                              'Cerrado',
                              style: TextStyle(
                                  color: blanco, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            if (element['sucursal'].estado == 'no_disponible') {
                              return alerta(context,
                                  code: false,
                                  contenido: 'El estado ya es "No visible"');
                            }
                            _cambiar_estado('no_disponible');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10)),
                            width: 200,
                            height: 40,
                            child: Center(
                                child: Text('No visible',
                                    style: TextStyle(
                                        color: blanco,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                    ],
                  ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    'Estado: ${element['sucursal'].estado}',
                    style: TextStyle(
                        color: element['sucursal']?.estado == 'cerrado'
                            ? rojo
                            : element['sucursal']?.estado == 'abierto'
                                ? verde
                                : Colors.blueGrey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Cambiar estado'),
                      Icon(Icons.cached_rounded)
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _cambiar_estado(String estado) async {
    load(context);

    Map _resp = await peticionesHttpProvider.putMethod(
        body: {
          "estado": "$estado",
          "id_sucursal": "${element['sucursal'].id}",
          "id_aliado": "${pref.id_aliado}",
          "nombre": "${element['sucursal'].nombre}",
          "direccion": "${element['sucursal'].direccion}",
          "url_foto_perfil": "no",
          "url_foto_portada": "no",
        },
        table: 'sucursales',
        context: context,
        token: pref.token,
        id: element['sucursal'].id);
    Navigator.pop(context);

    if (_resp['message'] == 'expiro') {
      funciones.closeSection(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('IniciarSesion');
      return alerta(context,
          titulo: 'alerta',
          code: false,
          contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
    }
    if (_resp['message'] == 'true') {
      // Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      // Navigator.of(context).pushNamed('MenuSucursal',arguments: {"sucursal":Sucursal(

      //   direccion:  _resp['data']['direccion'],
      //   estado:  _resp['data']['estado'],
      //   id:_resp['data']['id'],
      //   nombre:_resp['data']['nombre'],
      //   telefono:_resp['data']['telefono'],
      //   urlFotoPerfil:_resp['data']['url_foto_perfil'],
      //   urlFotoPortada:_resp['data']['url_foto_portada'],
      //   idAliado: _resp['data']['id_aliado'],

      // )});

    }
  }

  submit(context) async {
    print('ok');
    if (!formKey.currentState.validate()) {
      return null;
    }
    dynamic _respuesta = await http.post(
      url + '/categoria_sucursales',
      body: {
        "nombre": "${nombreController.text}",
        "id_sucursal": "${element['sucursal'].id}",
        "id_aliado": "${pref.id_aliado}"
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${pref.token.toString()}'
      },
    ).timeout(Duration(seconds: 10), onTimeout: () {
      throw {
        Navigator.pop(context),
        alerta(
          context,
          contenido: Text(
            "No hay conexion con el servidor.",
          ),
        ),
      };
    });

    Map<String, dynamic> decodeResp = json.decode(_respuesta.body);

    if (_respuesta.statusCode == 200) {
      peticion = false;
      Navigator.pop(context);
      setState(() {});

      nombreController.text = '';
    } else {
      return alerta(
        context,
        contenido: Text(
          "error",
        ),
      );
    }
  }

  rest() {
    peticion = false;
    setState(() {});
  }
}
