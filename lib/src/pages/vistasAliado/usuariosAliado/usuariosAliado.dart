import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

import 'model/AliadoUsuarioModel.dart';

class UsuariosAliado extends StatefulWidget {
  @override
  _UsuariosAliadoState createState() => _UsuariosAliadoState();
}

class _UsuariosAliadoState extends State<UsuariosAliado> {
  UsuarioProvider usuarioProvider;
  bool peticion = false;
  dynamic globalRespUsuarios = [];
  var formKey = GlobalKey<FormState>();
  // TextEditingController nombreController = new TextEditingController();
  // TextEditingController correoController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  Validaciones validar = new Validaciones();
  PreferenciasUsuario pref = new PreferenciasUsuario();
  PeticionesHttpProvider http = new PeticionesHttpProvider();
  Funciones funciones = new Funciones();
  @override
  Widget build(BuildContext context) {
    if (peticion == false) {
      peticion = true;
      pedir(context);
    }
    usuarioProvider = Provider.of<UsuarioProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      floatingActionButton: FloatingActionButton(
        onPressed: pref.rol == 'aliado'
            ? () {
                Navigator.of(context).pushNamed('SucursalesCrearUsuarioAliado');
              }
            : () {},
        child: Icon(
          Icons.add,
          color: blanco,
        ),
        backgroundColor: pref.rol == 'aliado' ? verde : Colors.green[100],
      ),
      appBar: AppBar(
        backgroundColor: amarillo,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.replay_outlined),
              onPressed: () {
                globalRespUsuarios = [];
                peticion = false;
                setState(() {});
              })
        ],
        iconTheme: IconThemeData(color: verde),
        title: Text(
          'Usuarios',
          style: TextStyle(color: verde),
        ),
      ),
      body: globalRespUsuarios.length == 0
          ? Center(child: CircularProgressIndicator())
          : globalRespUsuarios == 'vacio'
              ? Center(child: Text('No hay usuarios creados'))
              : Column(children: globalRespUsuarios),
    );
  }

  pedir(context) async {
    // load(context);
    final size = MediaQuery.of(context).size;
    try {
      List<Widget> widgets = [];
      // load(context);
      dynamic resp = await http.getMethod(
        context: context,
        table: 'user?id_aliado=${pref.id_aliado}',
        token: pref.token,
      );
      if (resp['message'] == "expiro") {
        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      }

      if (resp['message'] == "true") {
        final usuariosAliadoModel = usuariosAliadoModelFromJson(resp['resp']);
        if (usuariosAliadoModel.data.data.length == 1) {
          globalRespUsuarios = 'vacio';
          setState(() {});
        } else {
          usuariosAliadoModel.data.data.forEach((element) {
            // if (element.id.toString() != pref.user_id) {
            if (element.rol == 'asistente') {
              widgets.add(usuarios(
                context,
                correo: element.email,
                nombre: element.nombre,
                cedula: element.numeroDocumento,
                id: element.id,
              ));
            }
          });
          globalRespUsuarios = [];
          globalRespUsuarios = widgets;
          setState(() {});
        }
        //  print('---------------------------------------------------------------------ok');
      }

      if (resp['message'] == "false") {
        return alerta(context,
            contenido: 'hay un problema intentelo nuevamente', code: false);
      }
    } catch (e) {
      return alerta(context, contenido: '$e', code: false);
    }
  }

  Widget usuarios(BuildContext context,
      {String nombre, int cedula, String correo, int id}) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                alerta(context, code: false, contenido: id.toString());
              },
              child: Container(
                  color: gris,
                  width: size.width * 0.99,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: blanco,
                              radius: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nombre ?? '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(correo ?? ''),
                                    Text('cc:$cedula' ?? '')
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            pref.rol == 'aliado'
                                ? GestureDetector(
                                    onTap: () {
                                      alerta(context,
                                          titulo: "alerta",
                                          code: false,
                                          contenido:
                                              "Al eliminar al asistente la sucursal relacionada a el se pondra no disponible automaticamente!!",
                                          weight: true,
                                          colorContenido: rojo,
                                          acciones: Container(
                                            width: size.width * 0.5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                RaisedButton(
                                                  onPressed: () {},
                                                  color: verde,
                                                  shape: StadiumBorder(),
                                                  child: Text('Cancelar',
                                                      style: TextStyle(
                                                          color: blanco)),
                                                ),
                                                RaisedButton(
                                                  onPressed: () async {
                                                    try {
                                                      load(context);
                                                      dynamic resp = await http
                                                          .deleteMethod(
                                                              context: context,
                                                              id: id,
                                                              table: 'user',
                                                              token:
                                                                  pref.token);
                                                      if (resp['message'] ==
                                                          'true') {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        alerta(context,
                                                            titulo:
                                                                'Enhorabuena!',
                                                            contenido: Text(
                                                              'Se ha liminado el usuario.',
                                                              style: TextStyle(
                                                                  color: verde),
                                                            ),
                                                            acciones:
                                                                RaisedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                peticion =
                                                                    false;
                                                                setState(() {});
                                                              },
                                                              color: verde,
                                                              child: Text(
                                                                'Volver',
                                                                style: TextStyle(
                                                                    color:
                                                                        blanco),
                                                              ),
                                                              shape:
                                                                  StadiumBorder(),
                                                            ));
                                                      }
                                                      if (resp['message'] ==
                                                          'false') {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        alerta(context,
                                                            titulo: 'Alreta',
                                                            contenido: Text(
                                                              'No se ha podido realizar la accion , intentelo nuevamente.',
                                                              style: TextStyle(
                                                                  color: rojo),
                                                            ),
                                                            acciones:
                                                                RaisedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              color: verde,
                                                              child: Text(
                                                                'Volver',
                                                                style: TextStyle(
                                                                    color:
                                                                        blanco),
                                                              ),
                                                              shape:
                                                                  StadiumBorder(),
                                                            ));
                                                      }
                                                    } catch (e) {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      alerta(context,
                                                          titulo: 'alerta',
                                                          contenido:
                                                              'Algo salio mal intentelo nuevamente.',
                                                          code: false,
                                                          acciones:
                                                              RaisedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            color: verde,
                                                            child: Text(
                                                              'Volver',
                                                              style: TextStyle(
                                                                  color:
                                                                      blanco),
                                                            ),
                                                            shape:
                                                                StadiumBorder(),
                                                          ));
                                                    }
                                                  },
                                                  color: rojo,
                                                  shape: StadiumBorder(),
                                                  child: Text('Eliminar',
                                                      style: TextStyle(
                                                          color: blanco)),
                                                )
                                              ],
                                            ),
                                          ));
                                    },
                                    child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor: rojo,
                                        child: Icon(
                                          Icons.clear,
                                          color: blanco,
                                          size: 17,
                                        )),
                                  )
                                : CircleAvatar(
                                    radius: 13,
                                    backgroundColor: Colors.red[100],
                                    child: Icon(
                                      Icons.clear,
                                      color: blanco,
                                      size: 17,
                                    )),
                          ],
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ],
    );
  }

  // usuariosAliadoModelFromJsonFromJson(resp) {}
}
