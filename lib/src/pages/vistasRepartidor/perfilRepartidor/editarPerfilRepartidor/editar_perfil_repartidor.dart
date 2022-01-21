import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class EditarPerfilRepartidor extends StatefulWidget {
  @override
  _EditarPerfilRepartidorState createState() => _EditarPerfilRepartidorState();
}

TextEditingController nombreController = new TextEditingController();
TextEditingController apellidoController = new TextEditingController();
TextEditingController correoController = new TextEditingController();
TextEditingController telefonoController = new TextEditingController();
Funciones funciones = new Funciones();
PreferenciasUsuario _prefs = new PreferenciasUsuario();
PeticionesHttpProvider _http = new PeticionesHttpProvider();
Validaciones validar = new Validaciones();
bool datos = false;
var formKey = GlobalKey<FormState>();

class _EditarPerfilRepartidorState extends State<EditarPerfilRepartidor> {
  File perfilImage;
  @override
  Widget build(BuildContext context) {
    if (datos == false) {
      nombreController.text = _prefs.nombre;
      telefonoController.text = _prefs.telefono;
      correoController.text = _prefs.email;
      datos = true;
    }
    final size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.account_balance_wallet_rounded), onPressed: (){
            Navigator.of(context).pushNamed('DocumentosPageRepartidor');
          })
        ],
          iconTheme: IconThemeData(color: verde),
          title: Text(
            'Perfil',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Color.fromRGBO(251, 251, 251, 1)),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      crearImagen(context),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              crearNombreYapellido(context),
              SizedBox(height: size.height * 0.03),
              crearCorreo(context),
              SizedBox(height: size.height * 0.03),
              // crearTelefono(context),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  crearBoton(
                      onpressed: () {
                        Navigator.pop(context);
                      },
                      colorBoton: rojo,
                      colorTexto: Colors.white,
                      context: context,
                      texto: 'CANCELAR'),
                  SizedBox(width: size.width * 0.08),
                  crearBoton(
                      colorBoton: amarillo,
                      colorTexto: verde,
                      context: context,
                      texto: 'ACTUALIZAR',
                      onpressed: () async {
                        if (!formKey.currentState.validate()) return null;
                        // load(context);
                        await put();
                      })
                ],
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget crearImagen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Column(
      children: [
        CircleAvatar(
            backgroundColor: verde,
            child: perfilImage != null
                ? CircleAvatar(
                    backgroundImage: FileImage(perfilImage),
                    radius: orientacion == Orientation.portrait
                        ? size.width * 0.205
                        : size.width * 0.105,
                    backgroundColor: Colors.white)
                : _prefs.url_foto_perfil!=null? CircleAvatar(
                    backgroundImage: NetworkImage(storage+_prefs.url_foto_perfil),
                    radius: orientacion == Orientation.portrait
                        ? size.width * 0.205
                        : size.width * 0.105,
                    backgroundColor: Colors.white):Container(),
            radius: orientacion == Orientation.portrait
                ? size.width * 0.21
                : size.width * 0.107),
        SizedBox(
            height: orientacion == Orientation.portrait
                ? size.height * 0.03
                : size.height * 0.06),
        Column(
          children: [
            RaisedButton(
              elevation: 0,
              color: verde,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                onpressaddImage(context);
              },
              child: Container(
                width: orientacion == Orientation.portrait
                    ? size.width * 0.39
                    : size.width * 0.22,
                height: orientacion == Orientation.portrait
                    ? size.height * 0.053
                    : size.height * 0.105,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.cloud_upload, color: Colors.white),
                    Text('Subir Foto',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                  ],
                ),
              ),
            ),
          ],
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
                  style:
                      TextStyle(fontSize: tamano.width * 0.038, color: verde),
                ),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Row(
              children: <Widget>[
                Container(
                    child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: verde, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.center_focus_strong,
                              color: verde,
                              size: tamano.width * 0.05,
                            ),
                            Text(
                              'tomar',
                              style: TextStyle(
                                  fontSize: tamano.width * 0.038, color: verde),
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
                            side: BorderSide(color: verde, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add_a_photo,
                              color: verde,
                              size: tamano.width * 0.040,
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

  Widget crearNombreYapellido(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width * 0.39,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre'),
              TextFormField(
                // focusNode: nombreFocus,
                controller: nombreController,
                validator: (value) => validar.validateGenerico(value),
                decoration: InputDecoration(hintText: 'Yohan'),
                // onFieldSubmitted: (value) {
                //   // documentFocus.requestFocus();
                // },
              ),
            ],
          ),
        ),
        SizedBox(
            width: orientacion == Orientation.portrait
                ? size.width * 0.07
                : size.width * 0.12),
        Container(
          width: size.width * 0.39,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Telefono'),
              TextFormField(
                  validator: (value) => validar.validateNumerico(value),
                  controller: telefonoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: '310 6404303')
                  // onFieldSubmitted: (value) {
                  //   // documentFocus.requestFocus();
                  // },
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Widget crearCorreo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: orientacion == Orientation.portrait
                ? size.width * 0.85
                : size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('correo'),
                TextFormField(
                    validator: (value) => validar.validateEmail(value),
                    controller: correoController,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        InputDecoration(hintText: 'yohanblaro18@gmail.com')),
              ],
            )),
      ],
    );
  }

  // Widget crearTelefono(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   final orientacion = MediaQuery.of(context).orientation;
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //           width: orientacion == Orientation.portrait
  //               ? size.width * 0.85
  //               : size.width * 0.9,
  //           height: orientacion == Orientation.portrait
  //               ? size.height * 0.08
  //               : size.height * 0.165,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Telefono'),
  //               TextFormField(
  //                   controller: telefonoController,
  //                   keyboardType: TextInputType.number,
  //                   decoration: InputDecoration(hintText: '310 6404303')),
  //             ],
  //           )),
  //     ],
  //   );
  // }

  // Widget crearContrasena(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   final orientacion = MediaQuery.of(context).orientation;
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //           height: orientacion == Orientation.portrait
  //               ? size.height * 0.08
  //               : size.height * 0.165,
  //           width: orientacion == Orientation.portrait
  //               ? size.width * 0.85
  //               : size.width * 0.9,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Contraseña'),
  //               TextFormField(
  //                   keyboardType: TextInputType.visiblePassword,
  //                   decoration: InputDecoration(hintText: '********')),
  //             ],
  //           )),
  //     ],
  //   );
  // }

  // Widget crearConfirmarContrasena(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   final orientacion = MediaQuery.of(context).orientation;
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //           height: orientacion == Orientation.portrait
  //               ? size.height * 0.08
  //               : size.height * 0.165,
  //           width: orientacion == Orientation.portrait
  //               ? size.width * 0.85
  //               : size.width * 0.9,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Confirmar Contraseña'),
  //               TextFormField(
  //                   decoration: InputDecoration(hintText: '********')),
  //             ],
  //           )),
  //     ],
  //   );
  // }

  Widget crearBoton(
      {BuildContext context,
      String texto,
      Color colorBoton,
      Color colorTexto,
      Function onpressed}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: orientation == Orientation.portrait
          ? size.height * 0.07
          : size.height * 0.11,
      width: orientation == Orientation.portrait
          ? size.width * 0.4
          : size.width * 0.29,
      child: RaisedButton(
        elevation: 2,
        color: colorBoton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Text(texto ?? '',
            style: TextStyle(
                fontSize: orientation == Orientation.portrait
                    ? size.width * 0.048
                    : size.width * 0.022,
                color: colorTexto)),
        onPressed: onpressed ?? () {},
      ),
    );
  }

  put() async {
    try {
      load(context);
      var resp = await _http.putMethod(
          table: 'user',
          id: int.parse(_prefs.user_id),
          token: _prefs.token,
          body: {
            "nombre": "${nombreController.text}",
            "telefono": "${telefonoController.text}",
            "email": "${correoController.text}",
            "url_foto_perfil":perfilImage!=null?"${base64Encode(perfilImage.readAsBytesSync())}":"no",
          });

      if (resp['message'] == "expiro") {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
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
        Navigator.pop(context);
        _prefs.email = correoController.text;
        _prefs.telefono = telefonoController.text;
        _prefs.nombre = nombreController.text;
        _prefs.url_foto_perfil=resp['data']['url_foto_perfil'];
        setState(() {

        });
      return  alerta(context,
            titulo: 'Enhorabuena!',
            code: false,
            contenido: 'Los datos han sido actualizados correctamente');
      }

      if (resp['message'] == 'false') {
        // List<dynamic> errors = [];
        // print(resp.body);
        Navigator.pop(context);
        final errorsModel = errorsFormModelFromJson(resp['resp']);
        // Navigator.pop(context);
        List<Widget> errors = [];
        errorsModel.errors.forEach((key, value) {
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
      nombreController.text = _prefs.nombre;
      telefonoController.text = _prefs.telefono;
      correoController.text = _prefs.email;
      alerta(context,
          titulo: "alerta",
          contenido: 'algo salio mal intentelo nuevamente.',
          code: false);
    }
  }
}
