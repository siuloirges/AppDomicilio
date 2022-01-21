import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/crear/services/cantidadProvider.dart';
// import 'package:traelo_app/src/pages/vistasCliente/inicio/model/respCategoriaModel.dart';

import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/cardPequenna/cardPequenna.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

import 'models/TipoIdModel.dart';
import 'models/tipoVehiculoModel.dart';

class Crear extends StatefulWidget {
  // const Crear({Key key}) : super(key: key);
  @override
  _CrearState createState() => _CrearState();
}

class _CrearState extends State<Crear> {
  dynamic globalRespTipoId = [];
  dynamic globalRespTipoVehiculos = [];
  Funciones funciones = new Funciones();
  TotalProvider total;
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  PeticionesHttpProvider http = new PeticionesHttpProvider();
  TextEditingController nombreTipoIdController = new TextEditingController();
  TextEditingController nombreEditarTipoIdController =
      new TextEditingController();
  TextEditingController nombreTipoVehiculoController =
      new TextEditingController();
  TextEditingController nombreEditarTipoVehiculoController =
      new TextEditingController();
  String titulo;

  Validaciones validar = new Validaciones();
  bool peticiones = false;
  bool recargaCantidad = false;
  @override
  Widget build(BuildContext context) {
    if (peticiones == false) {
      globalRespTipoId = [];
      globalRespTipoVehiculos = [];
      setState(() {});
      peticiones = true;
      pedir(context);
      pedir2(context);
    }

    total = Provider.of<TotalProvider>(context);
    if (total.getEstadoGlobal == null) {
      total.funcion(context);
    }
    //  if (recargaCantidad== false) {
    //       total.getEstadoGlobal = null
    // }
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.replay_outlined,
              color: verde,
            ),
            onPressed: () {
              peticiones = false;
              setState(() {});
              globalRespTipoId = [];
              globalRespTipoVehiculos = [];

              total.funcion(context);
            },
          )
        ],
        iconTheme: IconThemeData(color: verde),
        elevation: 0,
        backgroundColor: amarillo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CardPequenna(
                          ontap: () {
                            Navigator.of(context).pushNamed('Categorias');
                          },
                          heroTag: 'bt1',
                          cantidad: total.getEstadoGlobal,
                          titulo: 'Categorias',
                          colorCard: amarillo,
                          colorNumero: verde,
                          colorTitulo: verde,
                          image: 'assets/company.png'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  width: _size.width * 0.95,
                  child: Card(
                    elevation: 1,
                    margin: EdgeInsets.all(0),
                    color: Color.fromRGBO(255, 255, 255, 1),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Tipos de documentos'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  crear(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor: verde,
                                  radius: 15,
                                  child: Icon(
                                    Icons.add,
                                    color: blanco,
                                  ),
                                ),
                              ),
                            )
                            //crearTipiId(context);
                          ],
                        ),
                        Column(
                            children: globalRespTipoId.length == 0
                                ? [
                                    Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        backgroundColor: amarillo,
                                        strokeWidth: 1,
                                      ),
                                    ))
                                  ]
                                : globalRespTipoId == 'vacio'
                                    ? [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Text('No hay tipos de documento'),
                                        )
                                      ]
                                    : globalRespTipoId)
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                      width: _size.width * 0.95,
                      child: Card(
                        elevation: 1,
                        margin: EdgeInsets.all(0),
                        color: Color.fromRGBO(255, 255, 255, 1),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text('Tipos de vehiculos'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      crear(context, vehiculo: true);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: verde,
                                      radius: 15,
                                      child: Icon(
                                        Icons.add,
                                        color: blanco,
                                      ),
                                    ),
                                  ),
                                )
                                //crearTipiId(context);
                              ],
                            ),
                            Column(
                                children: globalRespTipoVehiculos.length == 0
                                    ? [
                                        Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            backgroundColor: amarillo,
                                            strokeWidth: 1,
                                          ),
                                        ))
                                      ]
                                    : globalRespTipoVehiculos == 'vacio'
                                        ? [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  'No hay tipos de vehiculos'),
                                            )
                                          ]
                                        : globalRespTipoVehiculos),
                          ],
                        ),
                      )),
                  SizedBox(height: 4)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  post({bool vehiculo = false}) async {
    try {
      load(context);
      var resp = await http.postMethod(
          table: vehiculo == false ? 'tipo_documentos' : 'tipo_vehiculo',
          token: prefs.token,
          body: {
            "nombre":
                "${vehiculo == false ? nombreTipoIdController.text : nombreTipoVehiculoController.text}",
          });
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

        setState(() {
          peticiones = false;
        });
        nombreTipoIdController.text = '';
        return alerta(context,
            titulo: 'Enhorabuena',
            code: false,
            contenido: vehiculo == false
                ? 'El tipo de documento ha sido registrada con exito.'
                : 'El tipo de vehiculo ha sido registrado con exito.',
            acciones: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: verde,
              child: Text(
                'Volver',
                style: TextStyle(color: Colors.white),
              ),
              shape: StadiumBorder(),
            ));
      }

      if (resp['message'] == 'false') {
        // List<dynamic> errors = [];
        // print(resp.body);
        Navigator.pop(context);
        final errorsModel = errorsFormModelFromJson(resp['resp']);
        // Navigator.pop(context);
        List<Widget> errors = [];
        errorsModel.errors?.forEach((key, value) {
          var index = errors.length / 2;
          errors
            ..add(Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: amarillo,
                  child: Text(
                    '${index.toString().replaceAll(new RegExp(r'.0'), '')}',
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: verde, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  value.join(),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ))
            ..add(Divider());
        });

        return alerta(
          context,
          contenido: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: errors,
            ),
          ),
        );

        // return alerta(context,contenido: Text('${errorsModel.errors}'));

      }
    } catch (e) {
      print(e);
      return alerta(context,
          code: false, titulo: 'alerta', contenido: '${e.toString}');
    }
  }

  crear(BuildContext context, {vehiculo = false}) {
    return alerta(context,
        titulo: vehiculo == false
            ? 'Crear tipo de documento'
            : 'Crear tipo de vehiculo',
        contenido: vehiculo == false
            ? TextFormField(
                controller: nombreTipoIdController,
                validator: (value) => validar.validateGenerico(value),
                decoration: InputDecoration(hintText: 'Escriba el nombre'),
              )
            : TextFormField(
                controller: nombreTipoVehiculoController,
                validator: (value) => validar.validateGenerico(value),
                decoration: InputDecoration(hintText: 'Escriba el nombre'),
              ),
        acciones: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(
              onPressed: () {
                vehiculo == false ? post() : post(vehiculo: true);
              },
              color: verde,
              child: Text(
                'Guardar',
                style: TextStyle(color: blanco),
              ),
              shape: StadiumBorder(),
            ),
            SizedBox(
              width: 5,
            ),
            // RaisedButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //     alerta(context,
            //         titulo: 'editar',
            //         contenido: Column(
            //           children: globalRespTipoId,
            //         ));
            //   },
            //   color: amarillo,
            //   child: Text(
            //     'Editar',
            //     style: TextStyle(color: verde),
            //   ),
            //   shape: StadiumBorder(),
            // )
          ],
        ));
  }

  put(int id, {bool vehiculo = false}) async {
    try {
      load(context);

      var resp = await http.putMethod(
          table: vehiculo == false ? 'tipo_documentos' : 'tipo_vehiculo',
          token: prefs.token,
          id: id,
          body: {
            "nombre":
                "${vehiculo == false ? nombreEditarTipoIdController.text : nombreEditarTipoVehiculoController.text}",
          });

      if (resp['message'] == 'true') {
        Navigator.pop(context);
        // Navigator.pop(context);
        peticiones = false;
        vehiculo == false
            ? nombreEditarTipoIdController.text = ''
            : nombreEditarTipoVehiculoController.text = '';
        return alerta(context,
            titulo: 'Enhorabuena',
            code: false,
            contenido:
                'El tipo de identificacion ha sido modificada con exito.',
            acciones: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              color: verde,
              child: Text(
                'Volver',
                style: TextStyle(color: Colors.white),
              ),
              shape: StadiumBorder(),
            ));
      }

      if (resp['message'] == 'false') {
        // List<dynamic> errors = [];
        // print(resp.body);
        Navigator.pop(context);
        final errorsModel = errorsFormModelFromJson(resp['resp']);
        // Navigator.pop(context);
        List<Widget> errors = [];
        errorsModel.errors?.forEach((key, value) {
          var index = errors.length / 2;
          errors
            ..add(Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: amarillo,
                  child: Text(
                    '${index.toString().replaceAll(new RegExp(r'.0'), '')}',
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: verde, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  value.join(),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ))
            ..add(Divider());
        });

        return alerta(
          context,
          contenido: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: errors,
            ),
          ),
        );

        // return alerta(context,contenido: Text('${errorsModel.errors}'));

      }
    } catch (e) {
      print(e);
      return alerta(context,
          code: false, titulo: 'alerta', contenido: '${e.toString}');
    }
  }

  pedir(context, {bool vehiculo = false}) async {
    final size = MediaQuery.of(context).size; //  CircularProgressIndicator();
    try {
      // load(context);

      List<Widget> widgets = [];
      dynamic resp = await http.getMethod(
        context: context,
        table: 'tipo_documentos',
        token: prefs.token,
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
        final tipoIdModel = tipoDocumentoModelFromJson(resp['resp']);
        if (tipoIdModel.data.length == 0) {
          globalRespTipoId = 'vacio';
          setState(() {});
        } else {
          tipoIdModel.data?.forEach((element) {
            widgets.add(Column(
              children: [
                Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Container(
                    // color: Colors.grey,
                    width: size.width * 0.95,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, bottom: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          nombreEditarTipoIdController.text = element.nombre;

                          alerta(context,
                              titulo: 'editar',
                              contenido: Column(
                                children: [
                                  TextFormField(
                                    controller: nombreEditarTipoIdController,
                                    decoration: InputDecoration(
                                        hintText: 'Escriba el nombre'),
                                  )
                                ],
                              ),
                              acciones: RaisedButton(
                                shape: StadiumBorder(),
                                color: verde,
                                child: Text(
                                  'Guardar',
                                  style: TextStyle(color: blanco),
                                ),
                                onPressed: () {
                                  if (nombreEditarTipoIdController.text ==
                                      element.nombre) {
                                    alerta(context,
                                        titulo: 'Alerta',
                                        code: false,
                                        contenido:
                                            'el nombre no puede ser el mismo ');
                                  } else {
                                    if (nombreEditarTipoIdController.text ==
                                        '') {
                                      alerta(context,
                                          titulo: 'Alerta',
                                          code: false,
                                          contenido:
                                              'El nombre no puede estar vacio');
                                    } else {
                                      put(element.id);
                                    }
                                  }
                                },
                              ));
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(element.nombre),
                              GestureDetector(
                                  onTap: () {
                                    nombreEditarTipoIdController.text =
                                        element.nombre;
                                    alerta(context,
                                        titulo: 'editar',
                                        contenido: Column(
                                          children: [
                                            TextFormField(
                                              controller:
                                                  nombreEditarTipoIdController,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'Escriba el nombre'),
                                            )
                                          ],
                                        ),
                                        acciones: RaisedButton(
                                          shape: StadiumBorder(),
                                          color: verde,
                                          child: Text(
                                            'Guardar',
                                            style: TextStyle(color: blanco),
                                          ),
                                          onPressed: () {
                                            if (nombreEditarTipoIdController
                                                    .text ==
                                                element.nombre) {
                                              alerta(context,
                                                  titulo: 'Alerta',
                                                  code: false,
                                                  contenido:
                                                      'el nombre no puede ser el mismo ');
                                            } else {
                                              if (nombreEditarTipoIdController
                                                      .text ==
                                                  '') {
                                                alerta(context,
                                                    titulo: 'Alerta',
                                                    code: false,
                                                    contenido:
                                                        'El nombre no puede estar vacio');
                                              } else {
                                                put(element.id);
                                              }
                                            }
                                          },
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: amarillo,
                                      child: Icon(
                                        Icons.edit,
                                        color: verde,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Divider()
              ],
            ));
          });
          globalRespTipoId = [];
          globalRespTipoId = widgets;
          setState(() {});
        }

        //  print('---------------------------------------------------------------------ok');
      } else {}
    } catch (e) {
      Navigator.pop(context);
      return alerta(context,
          // titulo: 'sa',
          contenido: 'Ha ocurrido un problema, intentelo nuevamente.',
          code: false);
    }
  }

  pedir2(context) async {
    final size = MediaQuery.of(context).size;
    //  CircularProgressIndicator();
    try {
      // load(context);

      List<Widget> widgets = [];
      dynamic resp = await http.getMethod(
        context: context,
        table: 'tipo_vehiculo',
        token: prefs.token,
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
        final tipoVehiculoModel = tipoVehiculoModelFromJson(resp['resp']);
        if (tipoVehiculoModel.data.length == 0) {
          globalRespTipoVehiculos = 'vacio';
          setState(() {});
        } else {
          tipoVehiculoModel.data.forEach((element) {
            nombreEditarTipoVehiculoController.text = element.nombre;
            widgets.add(Column(
              children: [
                Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Container(
                    // color: Colors.grey,
                    width: size.width * 0.95,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, bottom: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          alerta(context,
                              titulo: 'editar',
                              contenido: Column(
                                children: [
                                  TextFormField(
                                    controller:
                                        nombreEditarTipoVehiculoController,
                                    decoration: InputDecoration(
                                        hintText: 'Escriba el nombre'),
                                  )
                                ],
                              ),
                              acciones: RaisedButton(
                                shape: StadiumBorder(),
                                color: verde,
                                child: Text(
                                  'Guardar',
                                  style: TextStyle(color: blanco),
                                ),
                                onPressed: () {
                                  if (nombreEditarTipoVehiculoController.text ==
                                      element.nombre) {
                                    alerta(context,
                                        titulo: 'Alerta',
                                        code: false,
                                        contenido:
                                            'el nombre no puede ser el mismo ');
                                  } else {
                                    if (nombreEditarTipoVehiculoController
                                            .text ==
                                        '') {
                                      alerta(context,
                                          titulo: 'Alerta',
                                          code: false,
                                          contenido:
                                              'El nombre no puede estar vacio');
                                    } else {
                                      put(element.id, vehiculo: true);
                                    }
                                  }
                                },
                              ));
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(element.nombre),
                              GestureDetector(
                                  onTap: () {
                                    nombreEditarTipoIdController.text =
                                        element.nombre;
                                    alerta(context,
                                        titulo: 'editar',
                                        contenido: Column(
                                          children: [
                                            TextFormField(
                                              controller:
                                                  nombreEditarTipoVehiculoController,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'Escriba el nombre'),
                                            )
                                          ],
                                        ),
                                        acciones: RaisedButton(
                                          shape: StadiumBorder(),
                                          color: verde,
                                          child: Text(
                                            'Guardar',
                                            style: TextStyle(color: blanco),
                                          ),
                                          onPressed: () {
                                            if (nombreEditarTipoVehiculoController
                                                    .text ==
                                                element.nombre) {
                                              alerta(context,
                                                  titulo: 'Alerta',
                                                  code: false,
                                                  contenido:
                                                      'el nombre no puede ser el mismo ');
                                            } else {
                                              if (nombreEditarTipoVehiculoController
                                                      .text ==
                                                  '') {
                                                alerta(context,
                                                    titulo: 'Alerta',
                                                    code: false,
                                                    contenido:
                                                        'El nombre no puede estar vacio');
                                              } else {
                                                put(element.id, vehiculo: true);
                                              }
                                            }
                                          },
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: amarillo,
                                      child: Icon(
                                        Icons.edit,
                                        color: verde,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Divider()
              ],
            ));
          });
          globalRespTipoVehiculos = [];
          globalRespTipoVehiculos = widgets;
          setState(() {});
        }

        //  print('---------------------------------------------------------------------ok');
      } else {}
    } catch (e) {
      Navigator.pop(context);
      return alerta(context,
          // titulo: 'sa',
          contenido: 'Ha ocurrido un problema, intentelo nuevamente.',
          code: false);
    }
  }
}
