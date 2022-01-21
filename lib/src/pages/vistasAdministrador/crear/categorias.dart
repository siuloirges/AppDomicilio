import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/pages/vistasAliado/inicioAliado/publicarAliado/models/respAliadoModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
// import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

import 'services/cantidadProvider.dart';

class Categorias extends StatefulWidget {
  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  dynamic globalRespCategoria = [];
  // Funciones funciones = new Funciones();
  Funciones funciones = new Funciones();
  PeticionesHttpProvider http = PeticionesHttpProvider();
  PreferenciasUsuario pref = new PreferenciasUsuario();
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
        print(
            '-------------------------------------fin------------------------------------------------');

        pedir20();
      }
    });
    // print(_scrollController.);
  }

  @override
  Widget build(BuildContext context) {
    if (peticion == false) {
      peticion = true;
      pedir(context);
    }
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: amarillo,
          child: Icon(
            Icons.add,
            color: verde,
          ),
          onPressed: () async {
            // final size = MediaQuery.of(context).size;
            return alerta(context, code: true, titulo: 'Crear nueva categoria',
                contenido: Alerta(
              ontap: () {
                Navigator.pop(context);
                peticion = false;
                setState(() {});
              },
            ));
          },
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.replay_outlined),
              onPressed: () {
                globalRespCategoria = [];
                setState(() {});
                peticion = false;
              },
            )
          ],
          iconTheme: IconThemeData(color: verde),
          elevation: 0,
          backgroundColor: amarillo,
        ),
        body: globalRespCategoria.length == 0
            ? Center(child: CircularProgressIndicator())
            : globalRespCategoria == 'vacio'
                ? Center(child: Text('No hay categorias creadas'))
                : GridView.count(
                    padding: EdgeInsets.all(5),
                    controller: _scrollController,
                    crossAxisCount: 3,
                    children: globalRespCategoria,
                  ));
  }

  pedir20() async {
    if (busqueda == true) {
      current_page++;
      setState(() {
        busqueda2 = 1;
      });
      try {
        List<Widget> widgets = [];
        // load(context);
        dynamic resp = await http.getMethod(
          context: context,
          table: 'categorias?page=${current_page}',
          token: pref.token,
        );
        if (resp['message'] == "expiro") {
          Navigator.of(context).pushReplacementNamed('IniciarSesion');
          alerta(context,
              titulo: 'alerta',
              code: false,
              contenido:
                  'Tiempo de conexion agotado, inicie sesion nuevamente.');
          await funciones.closeSection(context);
        }

        if (resp['message'] == "true") {
          final model = respAliadoCategoriaModelFromJson(resp['resp']);
          print(model.message);
          // if (model.message != 'Unauthenticated.') {
          if (model.data.data == null || model.data.data.length == 0) {
            busqueda = false;

            setState(() {});
          } else {
            model.data.data?.forEach((element) {
              globalRespCategoria.add(Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: ShapeDecoration(
                      // color:estado == false?  Colors.teal[300]:Colors.teal[400],
                      shape: RoundedRectangleBorder(
                          //  side: BorderSide( color:estado ==false  ?Colors.transparent: blanco,width:  8   ),
                          borderRadius: BorderRadius.circular(100))),
                  child: GestureDetector(
                    onTap: () {
                      return alerta(context,
                          code: false,
                          contenido: 'Que desea hacer?',
                          acciones: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    {
                                      final size = MediaQuery.of(context).size;
                                      return alerta(context,
                                          code: true,
                                          titulo: 'Editar categoria',
                                          contenido: Alerta(
                                            foto: element.urlImagen,
                                            id: element.id,
                                            put: true,
                                            editar: true,
                                            nombre: element.titulo,
                                            descripcion: element.descripcion,
                                            ontap: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              peticion = false;
                                              setState(() {});
                                            },
                                          ));
                                    }
                                  },
                                  child: Container(
                                      child: Icon(Icons.edit, color: verde),
                                      decoration: ShapeDecoration(
                                          color: amarillo,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      width: 50,
                                      height: 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    alerta(context,
                                        code: false,
                                        titulo: 'Alerta',
                                        contenido:
                                            'Seguro Que Desea eliminar ${element.titulo}',
                                        acciones: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            RaisedButton(
                                              shape: StadiumBorder(),
                                              color: verde,
                                              child: Text(
                                                'Volver',
                                                style: TextStyle(color: blanco),
                                              ),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                // Navigator.pop(context);
                                                peticion = false;
                                                setState(() {});
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            RaisedButton(
                                              shape: StadiumBorder(),
                                              color: amarillo,
                                              child: Text(
                                                'Seguro!',
                                                style: TextStyle(color: verde),
                                              ),
                                              onPressed: () async {
                                                load(context);
                                                var resp =
                                                    await http.deleteMethod(
                                                  context: context,
                                                  id: element.id,
                                                  table: 'categorias',
                                                  token: pref.token,
                                                );

                                                if (resp['message'] == false) {
                                                  Navigator.pop(context);
                                                  return alerta(context,
                                                      code: false,
                                                      contenido:
                                                          'Algo salio mal intentelo Nuevamente.',
                                                      acciones: RaisedButton(
                                                        color: amarillo,
                                                        child: Text('Volver'),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ));
                                                }
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                peticion = false;
                                                setState(() {});
                                              },
                                            )
                                          ],
                                        ));
                                  },
                                  child: Container(
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                    decoration: ShapeDecoration(
                                        color: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Center(
                            child: element.urlImagen != null
                                ? FadeInImage(
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 300,
                                    image: NetworkImage(
                                        '$storage${element.urlImagen}'),
                                    placeholder: AssetImage(
                                      'assets/logo_mano.png',
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: 300,
                            height: 300,
                            // color:estado==true?Colors.black54:Colors.black45,
                            color: Colors.black45,
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${element.titulo}',
                                style: TextStyle(
                                    color: blanco, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  width: 100,
                  height: 100,
                ),
              ));
            });

            // globalRespCategoria = widgets;
            setState(() {});
          }

          // } else {
          //  Navigator.of(context).pushReplacementNamed('IniciarSesion');
          //   await funciones.closeSection(context);
          // }

          //  print('---------------------------------------------------------------------ok');
        } else {}
      } catch (e) {
        // print("EL ERROR ES:-------------" + e);
        return alerta(context, contenido: 'e', code: false);
      }
    } else {
      return;
    }
  }

  pedir(context) async {
    // load(context);
    final size = MediaQuery.of(context).size;

    try {
      List<Widget> widgets = [];
      // load(context);
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
        print(model.message);
        // if (model.message != 'Unauthenticated.') {
        if (model.data.data.length == 0) {
          globalRespCategoria = 'vacio';
          setState(() {});
        } else {
          model.data.data.forEach((element) {
            widgets.add(Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: ShapeDecoration(
                    // color:estado == false?  Colors.teal[300]:Colors.teal[400],
                    shape: RoundedRectangleBorder(
                        //  side: BorderSide( color:estado ==false  ?Colors.transparent: blanco,width:  8   ),
                        borderRadius: BorderRadius.circular(100))),
                child: GestureDetector(
                  onTap: () {
                    return alerta(context,
                        code: false,
                        contenido: 'Que desea hacer?',
                        acciones: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  {
                                    final size = MediaQuery.of(context).size;
                                    return alerta(context,
                                        code: true,
                                        titulo: 'Editar categoria',
                                        contenido: Alerta(
                                          foto: element.urlImagen,
                                          id: element.id,
                                          put: true,
                                          editar: true,
                                          nombre: element.titulo,
                                          descripcion: element.descripcion,
                                          ontap: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            peticion = false;
                                            setState(() {});
                                          },
                                        ));
                                  }
                                },
                                child: Container(
                                    child: Icon(Icons.edit, color: verde),
                                    decoration: ShapeDecoration(
                                        color: amarillo,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    width: 50,
                                    height: 50),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  alerta(context,
                                      code: false,
                                      titulo: 'Alerta',
                                      contenido:
                                          'Seguro Que Desea eliminar ${element.titulo}',
                                      acciones: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          RaisedButton(
                                            shape: StadiumBorder(),
                                            color: verde,
                                            child: Text(
                                              'Volver',
                                              style: TextStyle(color: blanco),
                                            ),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              // Navigator.pop(context);
                                              peticion = false;
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          RaisedButton(
                                            shape: StadiumBorder(),
                                            color: amarillo,
                                            child: Text(
                                              'Seguro!',
                                              style: TextStyle(color: verde),
                                            ),
                                            onPressed: () async {
                                              load(context);
                                              var resp =
                                                  await http.deleteMethod(
                                                context: context,
                                                id: element.id,
                                                table: 'categorias',
                                                token: pref.token,
                                              );

                                              if (resp['message'] == false) {
                                                Navigator.pop(context);
                                                return alerta(context,
                                                    code: false,
                                                    contenido:
                                                        'Algo salio mal intentelo Nuevamente.',
                                                    acciones: RaisedButton(
                                                      color: amarillo,
                                                      child: Text('Volver'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ));
                                              }
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              peticion = false;
                                              setState(() {});
                                            },
                                          )
                                        ],
                                      ));
                                },
                                child: Container(
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                  decoration: ShapeDecoration(
                                      color: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Center(
                          child: element.urlImagen != null
                              ? FadeInImage(
                                  fit: BoxFit.cover,
                                  width: 300,
                                  height: 300,
                                  image: NetworkImage(
                                      '$storage${element.urlImagen}'),
                                  placeholder: AssetImage(
                                    'assets/logo_mano.png',
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 300,
                          height: 300,
                          // color:estado==true?Colors.black54:Colors.black45,
                          color: Colors.black45,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${element.titulo}',
                              style: TextStyle(
                                  color: blanco, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                width: 100,
                height: 100,
              ),
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
}

class Alerta extends StatefulWidget {
  Function ontap;
  bool put;
  int id;
  String nombre;
  String descripcion;
  String foto;
  bool editar;

  Alerta({
    Key key,
    this.ontap,
    this.put = false,
    this.id,
    this.foto,
    this.nombre,
    this.descripcion,
    this.editar = false,
  }) : super(
          key: key,
        );
  @override
  _AlertaState createState() => _AlertaState();
}

class _AlertaState extends State<Alerta> {
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  File perfilImage;
  Validaciones validar = new Validaciones();
  TextEditingController nombreCategoriaController = new TextEditingController();
  TextEditingController descripcionCategoriaController =
      new TextEditingController();
  TextEditingController nombreEditarCategoriaController =
      new TextEditingController();
  TextEditingController descripcionEditarCategoriaController =
      new TextEditingController();
  Funciones funciones = new Funciones();
  PeticionesHttpProvider peticiones = new PeticionesHttpProvider();
  TotalProvider total;
  @override
  Widget build(BuildContext context) {
    String imagen;
    total = Provider.of<TotalProvider>(context);
    if (widget.editar == true) {
      if (widget.nombre != null) {
        nombreEditarCategoriaController.text = widget.nombre;
      }
      if (widget.descripcion != null) {
        descripcionEditarCategoriaController.text = widget.descripcion;
      }
    }

    return Column(
      children: [
        widget.put == false
            ? TextFormField(
                controller: nombreCategoriaController,
                validator: (value) => validar.validateGenerico(value),
                decoration: InputDecoration(hintText: 'Dijite el nombre'),
              )
            : TextFormField(
                controller: nombreEditarCategoriaController,
                validator: (value) => validar.validateGenerico(value),
                decoration: InputDecoration(hintText: 'Dijite el nombre'),
              ),
        SizedBox(
          height: 2,
        ),
        widget.put == false
            ? TextFormField(
                controller: descripcionCategoriaController,
                validator: (value) => validar.validateGenerico(value),
                maxLines: 3,
                decoration: InputDecoration(hintText: 'Dijite la descripcion'),
              )
            : TextFormField(
                controller: descripcionEditarCategoriaController,
                validator: (value) => validar.validateGenerico(value),
                maxLines: 3,
                decoration: InputDecoration(hintText: 'Dijite la descripcion'),
              ),
        SizedBox(
          height: 12,
        ),
        crearImagen(
          context,
        ),
        widget.put == false
            ? RaisedButton(
                onPressed: () async {
                  if (nombreCategoriaController.text == '') {
                    return alerta(context,
                        code: false,
                        contenido: 'El nombre de categoria es necesario');
                  }
                  if (perfilImage == null) {
                    return alerta(context,
                        code: false, contenido: 'La foto es necesaria');
                  }
                  try {
                    load(context);
                    var resp = await peticiones.postMethod(
                        table: 'categorias',
                        token: prefs.token,
                        body: {
                          "titulo": "${nombreCategoriaController.text}",
                          "descripcion":
                              "${descripcionCategoriaController.text}",
                          "url_imagen": perfilImage != null
                              ? "${base64Encode(perfilImage.readAsBytesSync())}"
                              : "no"
                          //  'url_foto_perfil':perfilImage!=null?'${base64Encode(perfilImage.readAsBytesSync())}':'no'
                        });

                    if (resp['message'] == "expiro") {
                      Navigator.of(context)
                          .pushReplacementNamed('IniciarSesion');
                      await funciones.closeSection(context);
                      return alerta(context,
                          titulo: 'alerta',
                          code: false,
                          contenido:
                              'Tiempo de conexion agotado, inicie sesion nuevamente.');
                    }
                    if (resp['message'] == 'true') {
                      imagen = base64Encode(perfilImage.readAsBytesSync())
                          .toString();
                      print(imagen);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      total.setEstadoGlobal = null;

                      nombreCategoriaController.text = '';
                      setState(() {});
                      return alerta(context,
                          titulo: 'Enhorabuena',
                          code: false,
                          contenido:
                              'La categoria ha sido registrada con exito.',
                          acciones: RaisedButton(
                            onPressed: widget.ontap,
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
                                  style: TextStyle(
                                      color: verde,
                                      fontWeight: FontWeight.bold),
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
                        code: false, titulo: 'alerta', contenido: '$e');
                  }
                },
                color: verde,
                shape: StadiumBorder(),
                child: Text(
                  'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : RaisedButton(
                onPressed: () async {
                  if (nombreCategoriaController.text == '') {
                    return alerta(context,
                        code: false,
                        contenido: 'El nombre de categoria es necesario');
                  }
                  if (perfilImage == null) {
                    return alerta(context,
                        code: false, contenido: 'La foto es necesaria');
                  }

                  try {
                    load(context);
                    var resp = await peticiones.putMethod(
                        table: 'categorias',
                        token: prefs.token,
                        id: widget.id,
                        body: {
                          "id": "${widget.id}",
                          "titulo": "${nombreEditarCategoriaController.text}",
                          "descripcion":
                              "${descripcionEditarCategoriaController.text}",
                          "url_imagen": perfilImage != null
                              ? "${base64Encode(perfilImage.readAsBytesSync())}"
                              : "no"
                        });

                    if (resp['message'] == 'true') {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      nombreCategoriaController.text = '';
                      setState(() {});
                      return alerta(context,
                          titulo: 'Enhorabuena',
                          code: false,
                          contenido:
                              'La categoria ha sido modificada con exito.',
                          acciones: RaisedButton(
                            onPressed: widget.ontap,
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
                                  style: TextStyle(
                                      color: verde,
                                      fontWeight: FontWeight.bold),
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
                        code: false, titulo: 'alerta', contenido: '$e');
                  }
                },
                color: verde,
                shape: StadiumBorder(),
                child: Text(
                  'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
              )
        // crearImagen(context)
      ],
    );
  }

  Widget crearImagen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(3)),
                width: size.width * 0.55,
                height: size.width * 0.25,
                child: perfilImage != null
                    ? Container(
                        width: size.width * 0.55,
                        height: size.width * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                              fit: BoxFit.cover, image: FileImage(perfilImage)),
                        ),
                      )
                    : widget.foto != null
                        ? Container(
                            width: size.width * 0.55,
                            height: size.width * 0.25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(storage + widget.foto)),
                            ),
                          )
                        : Container()),
          ],
        ),
        Container(
          width: size.width * 0.55,
          height: size.width * 0.25,
          child: GestureDetector(
            onTap: () {
              onpressaddImage(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          perfilImage == null
                              ? Text(
                                  'Imagen: ',
                                  style: TextStyle(
                                      fontSize: size.width < 248
                                          ? size.width * 0.04
                                          : 13),
                                )
                              : Container(),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: size.width > 444 ? 22.2 : size.width * 0.05,
                            backgroundColor: verde,
                            child: Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void onpressaddImage(BuildContext context) {
    final tamano = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Seleccione',
                  style: TextStyle(
                      fontSize:
                          tamano.width > 642 ? 24.39 : tamano.width * 0.038,
                      color: Colors.grey),
                ),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.center_focus_strong,
                              color: Colors.grey,
                              size: tamano.width > 642
                                  ? 32.1
                                  : tamano.width * 0.05,
                            ),
                            Text(
                              'tomar',
                              style: TextStyle(
                                  fontSize: tamano.width > 642
                                      ? 24.39
                                      : tamano.width * 0.038,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        onPressed: () {
                          cargarImageCamera();
                          Navigator.pop(context);
                        })),
                SizedBox(
                  width: tamano.height * 0.025,
                ),
                Container(
                    child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add_a_photo,
                              color: Colors.grey,
                              size: tamano.width > 642
                                  ? 32.1
                                  : tamano.width * 0.05,
                            ),
                            Text(
                              'galería',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: tamano.width > 642
                                    ? 24.39
                                    : tamano.width * 0.038,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          cargarImageGalery();
                          Navigator.pop(context);
                        })),
              ],
            ),
          );
        });
  }

  Future cargarImageGalery() async {
    var tempImage = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.gallery);
    setState(() {
      perfilImage = tempImage;
    });
  }

  Future cargarImageCamera() async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.camera);

    setState(() {
      perfilImage = tempImageCamera;
    });
  }
}
