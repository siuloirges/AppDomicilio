import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

class EditarUsuarioAliado extends StatefulWidget {
  EditarUsuarioAliado({Key key}) : super(key: key);

  _EditarUsuarioAliadoState createState() => _EditarUsuarioAliadoState();
}

double tamanno400;
var size;
bool eye = false;
bool datos = false;
var formKey = GlobalKey<FormState>();
PeticionesHttpProvider _http = new PeticionesHttpProvider();
Validaciones validar = new Validaciones();
TextEditingController nombreController = new TextEditingController();
TextEditingController telefonoController = new TextEditingController();
TextEditingController correoController = new TextEditingController();
FocusNode correoFocus = new FocusNode();
Funciones funciones = new Funciones();
FocusNode telefonoFocus = new FocusNode();
FocusNode nombreFocus = new FocusNode();
PreferenciasUsuario pref = new PreferenciasUsuario();
File perfilImage;
@override
class _EditarUsuarioAliadoState extends State<EditarUsuarioAliado> {
  @override
  Widget build(BuildContext context) {
    if (datos == false) {
      nombreController.text = pref.nombre;
      telefonoController.text = pref.telefono;
      correoController.text = pref.email;
      datos = true;
    }
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: amarillo,
        iconTheme: IconThemeData(color: verde),
        elevation: 0,
        title: Text(
          'Editar usuario',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 40,
              color: verde,
              child: Center(
                child: Text(
                  'Editar usuario',
                  style: TextStyle(color: blanco),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            crearImagen(context),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      nombre(context),
                      SizedBox(
                        height: 30,
                      ),
                      crearTelefono(context),
                      SizedBox(
                        height: 30,
                      ),
                      crearCorreo(context)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25, top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  crearBoton(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    context: context,
                    colorBoton: rojo,
                    colorTexto: Colors.white,
                    nombreBoton: size.width < 300
                        ? Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )
                        : Text('Cancelar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    size.width < 400 ? size.width * 0.03 : 15,
                                color: amarillo)),
                  ),
                  SizedBox(width: size.width * 0.0705),
                  crearBoton(
                    onPress: () {
                      if (!formKey.currentState.validate()) return null;
                      put();
                    },
                    context: context,
                    colorBoton: amarillo,
                    nombreBoton: size.width < 300
                        ? Icon(Icons.save, color: Colors.white)
                        : Text('GUARDAR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    size.width < 400 ? size.width * 0.03 : 15,
                                color: verde)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  put() async {
    if (!formKey.currentState.validate()) {
      return null;
    }
    try {
      load(context);
      var resp = await _http.putMethod(
          table: 'user',
          id: int.parse(pref.user_id),
          token: pref.token,
          body: {
            "nombre": "${nombreController.text}",
            "url_foto_perfil":perfilImage!=null?"${base64Encode(perfilImage.readAsBytesSync())}":"no",
            "telefono": "${telefonoController.text}",
            "email": "${correoController.text}"
          });
      if (resp['message'] == "expiro") {
        Navigator.pop(context);
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
        pref.email = resp['data']['email'];
        pref.telefono = resp['data']['telefono'];
        pref.nombre = resp['data']['nombre'];
        pref.url_foto_perfil = resp['data']['url_foto_perfil'];

        setState(() {

        });
        alerta(context,
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
      nombreController.text = pref.nombre;
      telefonoController.text = pref.telefono;
      correoController.text = pref.email;
      alerta(context,
          titulo: "alerta",
          contenido: 'algo salio mal intentelo nuevamente.',
          code: false);
    }
  }

  Widget nombre(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre',
              style: TextStyle(
                  fontSize: size.width < 400 ? size.width * 0.04 : 15),
            ),
          ],
        ),
        TextFormField(
          focusNode: nombreFocus,
          controller: nombreController,
          validator: (value) {
            return validar.validateGenerico(value);
          },
          decoration: InputDecoration(
            hintText: 'razon social',
          ),
          onFieldSubmitted: (value) {
            telefonoFocus.requestFocus();
          },
        ),
      ],
    );
  }

  Widget crearCorreo(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'correo',
              style: TextStyle(
                  fontSize: size.width < 400 ? size.width * 0.04 : 15),
            ),
          ],
        ),
        TextFormField(
          focusNode: correoFocus,
          controller: correoController,
          validator: (value) {
            return validar.validateEmail(value);
          },
          decoration: InputDecoration(
            hintText: 'a@a.a',
          ),
        ),
      ],
    );
  }

  Widget crearTelefono(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Telefono',
              style: TextStyle(
                  fontSize: size.width < 400 ? size.width * 0.04 : 15),
            ),
          ],
        ),
        TextFormField(
          focusNode: telefonoFocus,
          controller: telefonoController,
          validator: (value) {
            return validar.validateNumerico(value);
          },
          decoration: InputDecoration(
            hintText: '3215674784',
          ),
          onFieldSubmitted: (value) {
            correoFocus.requestFocus();
          },
        ),
      ],
    );
  }
  
   Widget crearImagen(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: Container(
              decoration: BoxDecoration(
                  color: verdeClaro, borderRadius: BorderRadius.circular(100)),
              width: 165,
              height: 165,
              child: perfilImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                          fit: BoxFit.cover, image: FileImage(perfilImage)),
                    )
                  : null),
        ),
        perfilImage != null
            ? Center(
                child: IconButton(
                    alignment: Alignment.center,
                    iconSize: 1,
                    icon: IconButton(
                      icon: Icon(
                        Icons.highlight_remove_rounded,
                        color: blanco,
                      ),
                      onPressed: () {
                        setState(() {
                          perfilImage = null;
                        });
                      },
                    ),
                    onPressed: null),
              )
            : Center(
              child: Container(
                 decoration: BoxDecoration(color: verdeClaro, borderRadius: BorderRadius.circular(100)),
                width: 165,
                height: 165,
                child: ClipRRect(
                       borderRadius: BorderRadius.circular(100),
                       child: Image(fit: BoxFit.cover, image:  NetworkImage(storage+pref.url_foto_perfil)),
                ),
              ),
            ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 140,
              ),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  onpressaddImage(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Container(
                        width: 100,
                        child: Center(
                            child: Text('Subir imagen',
                                style: TextStyle(
                                  color: verde,
                                  // fontSize: 30),
                                ))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                  style:
                      TextStyle(fontSize: tamano.width * 0.038, color: verde),
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

  Widget crearBoton({
    BuildContext context,
    Widget nombreBoton,
    Color colorBoton,
    Color colorTexto,
    Function onPress,
  }) {
    return Container(
      height: 35,
      width: size.width < 400 ? size.width * 0.33 : 120,
      child: RaisedButton(
          elevation: 2,
          color: colorBoton,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: nombreBoton,
          onPressed: onPress),
    );
  }
}
