import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traelo_app/src/pages/login/Model/loginRespModel.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/models/SucursalModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class EditarPerfirlPage extends StatefulWidget {
  @override
  _EditarPerfirlPageState createState() => _EditarPerfirlPageState();
}

class _EditarPerfirlPageState extends State<EditarPerfirlPage> {
  Map element;
  PeticionesHttpProvider http = PeticionesHttpProvider();
  var formKey = GlobalKey<FormState>();

  PreferenciasUsuario pref = PreferenciasUsuario();

  Funciones funciones = new Funciones();
  Validaciones validar = new Validaciones();

  TextEditingController nombreController = new TextEditingController();

  TextEditingController correoController = new TextEditingController();

  TextEditingController telefonoController = new TextEditingController();

  TextEditingController contrasenaController = new TextEditingController();

  FocusNode nombreFocus = new FocusNode();

  FocusNode correoFocus = new FocusNode();

  FocusNode telefonoFocus = new FocusNode();

  FocusNode contrasenaFocus = new FocusNode();

  File perfilFoto;

  Size size;
  bool ifController = false;
  // Orientation orientation = MediaQuery.of(context).orientation;
  @override
  Widget build(BuildContext context) {
    element = ModalRoute.of(context).settings.arguments;
    if (element['data'] != null && ifController == false) {
      if (element['data']['nombre'] != '' ||
          element['data']['nombre'] != null) {
        nombreController.text = element['data']['nombre'];
      }
      if (element['data']['email'] != '' || element['data']['email'] != null) {
        correoController.text = element['data']['email'];
      }
      if (element['data']['telefono'] != '' ||
          element['data']['telefono'] != null) {
        telefonoController.text = element['data']['telefono'];
      }
      // if(element['data'].latitude!=null&&element['data'].longitude!=null){;}

      ifController = true;
    }
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                image(context),
                contenido(context),
              ],
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: size.height / 8,
          //   decoration: BoxDecoration(color: Colors.transparent),
          // ),
          pop(context),
        ],
      ),
    );
  }

  Widget pop(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: amarillo),
          backgroundColor: Colors.transparent,
          title: Text(
            'Perfil',
            style: TextStyle(color: amarillo),
          ),
        )
      ],
    );
  }

  Widget image(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  child: perfilFoto != null
                      ? Image(
                          fit: BoxFit.cover,
                          height: size.height * 0.3,
                          width: double.infinity,
                          image: FileImage(perfilFoto))
                      : Image(
                          fit: BoxFit.cover,
                          height: size.height * 0.3,
                          width: double.infinity,
                          image: NetworkImage(
                              storage + pref.url_foto_perfil ?? '')),
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/Rectangle.png',
                      height: size.height * 0.3,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ],
                )
              ],
            ),
            Container(
              color: Colors.transparent,
              height: size.height * 0.05,
            )
          ],
        ),
        Container(
          height: size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  "Nombre: ${element['data']['nombre']}",
                  style:
                      TextStyle(color: amarillo, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Telefono: ${element['data']['telefono']}',
                  style: TextStyle(color: blanco),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.277,
            ),
            Center(
              child: Container(
                height: size.height * 0.04,
                width: size.width * 0.4,
                child: RaisedButton(
                  color: verde,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.file_upload,
                        color: Colors.white,
                        size: size.height * 0.03,
                      ),
                      Text("Subir Foto",
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.white)),
                    ],
                  ),
                  onPressed: () {
                    onpressaddImage(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget contenido(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Datos',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * 0.035)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: crearNombre(context),
            ),
            crearCorreo(context),
            crearTelefono(context),
            // crearContrasena(context),
            Padding(
              padding: const EdgeInsets.only(bottom: 25, top: 50.0),
              child: crearBoton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardPequena(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //  SizedBox( width: size.width*0.010, ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Delicones',
                        style: TextStyle(fontSize: size.height * 0.020),
                      ),
                      Text('Crespo Mz 8 Lt12',
                          style: TextStyle(
                              fontSize: size.height * 0.015,
                              color: Color.fromRGBO(103, 96, 95, 1)))
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.010,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget crearNombre(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nombre'),
          TextFormField(
            focusNode: nombreFocus,
            controller: nombreController,
            validator: (value) {
              return validar.validateName(value);
            },
            decoration: InputDecoration(
              hintText: 'Nombre',
            ),
            onFieldSubmitted: (value) {
              correoFocus.requestFocus();
            },
          ),
        ],
      ),
    );
  }

  Widget crearCorreo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Correo'),
              TextFormField(
                focusNode: correoFocus,
                controller: correoController,
                validator: (value) {
                  return validar.validateEmail(value);
                },
                decoration: InputDecoration(
                  hintText: 'Tucorreo@ejemplo.com',
                ),
                onFieldSubmitted: (value) {
                  telefonoFocus.requestFocus();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget crearTelefono(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Telefono'),
          TextFormField(
            focusNode: telefonoFocus,
            controller: telefonoController,
            validator: (value) {
              return validar.validateNumerico(value);
            },
            decoration: InputDecoration(
              hintText: '30234097',
            ),
            onFieldSubmitted: (value) {
              contrasenaFocus.requestFocus();
            },
          ),
        ],
      ),
    );
  }

  Widget crearContrasena(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contraseña'),
          TextFormField(
            focusNode: contrasenaFocus,
            controller: contrasenaController,
            validator: (value) {
              return validar.validateName(value);
            },
            decoration: InputDecoration(
              hintText: '*****************',
              // labelText: 'Contraseña',
            ),
          ),
        ],
      ),
    );
  }

  Widget crearBoton() {
    return Container(
      height: size.height * 0.06,
      width: size.width * 0.50,
      child: RaisedButton(
        elevation: 8,
        color: amarillo,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Text("GUARDAR",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.04,
                color: verde)),
        onPressed: () async {
          dynamic imagen;

          // if (perfilFoto != null) {
          //   imagen = null;
          //   imagen = base64Encode(perfilFoto.readAsBytesSync());
          // }
          if (!formKey.currentState.validate()) {
            return null;
          }
          load(context);
          try {
            Map _respuesta = await http.putMethod(
              body: {
                'nombre': '${nombreController.text}',
                'email': '${correoController.text}',
                'telefono': '${int.parse(telefonoController.text)}',
                "url_foto_perfil":perfilFoto!=null?"${base64Encode(perfilFoto.readAsBytesSync())}":"no",
                'rol': 'cliente'
              },
              id: int.parse(pref.user_id),
              table: 'user',
              token: pref.token,
              context: context,
            );
            if (_respuesta['message'] == "expiro") {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('IniciarSesion');
              alerta(context,
                  titulo: 'alerta',
                  code: false,
                  contenido:
                      'Tiempo de conexion agotado, inicie sesion nuevamente.');
              await funciones.closeSection(context);
            }

            if (_respuesta['message'] == "false") {
              //  Navigator.pop(context);
              print(_respuesta.toString() +
                  '---------------------------------Bad');
              dynamic res = json.encode(_respuesta);

              print(res);
              var respModel = errorsFormModelFromJson(res);
              List<Widget> errors = [];
              respModel.errors.forEach((key, value) {
                var index = errors.length / 2;
                errors
                  ..add(Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: amarillo,
                        child: Center(
                          child: Text(
                            '${index.toString().replaceAll(new RegExp(r'.0'), '')}',
                            style: TextStyle(
                                color: verde, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            value.join(),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                    ],
                  ))
                  ..add(Divider());
              });
              Navigator.pop(context);
              return alerta(
                context,
                contenido: Column(
                  children: errors,
                ),
                acciones: Padding(
                  padding: const EdgeInsets.only(top: 25.0, right: 5),
                  child: Container(
                    width: 56,
                    height: 56,
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
              );
            }

            //  Map _respuesta = await http.getMethod(context: context,table: 'sucursales',token: pref.token);

            print(_respuesta);

            if (_respuesta['message'] == "true") {
              try {
                dynamic user = await http.getMethod(
                  context: context,
                  table: 'get_user',
                  token: pref.token,
                );
                final usuarioModel = respUserModelFromJson(user['resp']);

                if (element['data']['email'].toString() !=
                    usuarioModel.data.email.toString()) {
                  //TODO BORRAR PREFERENCAS

                  await funciones.closeSection(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('IniciarSesion');

                  return alerta(
                    context,
                    code: false,
                    contenido:
                        'Usted cambio su correo electronico, tendra que iniciar nueva mente',
                  );
                } else {
                  pref.id_aliado = usuarioModel.data.idAliado;
                  pref.user_id = usuarioModel.data.id.toString();
                  pref.nombre = usuarioModel.data.nombre;
                  pref.url_foto_perfil = usuarioModel.data.urlFotoPerfil;
                  pref.tipo_documento = usuarioModel.data.tipoDocumentoId;
                  pref.numero_documento =
                      usuarioModel.data.numeroDocumento.toString();
                  pref.telefono = usuarioModel.data.telefono.toString();
                  pref.email = usuarioModel.data.email;
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'Perfil');
                  return alerta(
                    context,
                    code: false,
                    contenido: 'Su usuario se actualizo correctamente',
                  );
                }
              } catch (e) {
                return alerta(context,
                    contenido: Text('$e'), acciones: Container());
              }
            } else {
              return alerta(context,
                  contenido: Text('Error'), acciones: Container());
            }

            // print(_respuesta['data']);
          } catch (e) {
            return alerta(context, contenido: '$e', code: false);
          }
        },
      ),
    );
  }

  void onpressaddImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Seleccione',
                  style: TextStyle(fontSize: size.width * 0.038, color: verde),
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
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: verde, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.center_focus_strong,
                              color: verde,
                              size: size.width * 0.05,
                            ),
                            Text(
                              'tomar',
                              style: TextStyle(
                                  fontSize: size.width * 0.038, color: verde),
                            ),
                          ],
                        ),
                        onPressed: () {
                          cargarImageCamera();
                          Navigator.pop(context);
                        })),
                SizedBox(
                  width: size.height * 0.025,
                ),
                Container(
                    child: RaisedButton(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: verde, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add_a_photo,
                              color: verde,
                              size: size.width * 0.040,
                            ),
                            Text(
                              'galería',
                              style: TextStyle(color: verde),
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
      perfilFoto = tempImage;
    });
  }

  Future cargarImageCamera() async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.camera);

    setState(() {
      perfilFoto = tempImageCamera;
    });
  }
}
