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

class EditarPerfilAliado extends StatefulWidget {
  @override
  _EditarPerfilAliadoState createState() => _EditarPerfilAliadoState();
}

class _EditarPerfilAliadoState extends State<EditarPerfilAliado> {
  PreferenciasUsuario pref = PreferenciasUsuario();
  Funciones funciones = new Funciones();
  Map<String, dynamic> element;
  double tamanno400;
  var size;
  // var orientation;
  bool eye = false;
  var formKey = GlobalKey<FormState>();

  Validaciones validar = new Validaciones();

  // TextEditingController nombreController = new TextEditingController();

  TextEditingController razonSocialController = new TextEditingController();
  TextEditingController nombreAliadoController = new TextEditingController();
  TextEditingController nitController = new TextEditingController();

  FocusNode correoFocus = new FocusNode();
  FocusNode telefonoFocus = new FocusNode();
  FocusNode nombreAliadoFocus = new FocusNode();
  PeticionesHttpProvider http = new PeticionesHttpProvider();
  PreferenciasUsuario _pref = new PreferenciasUsuario();

  File fotoPortada;
  File fotoPefil;
  bool ifController = false;
  @override
  Widget build(BuildContext context) {
    element = ModalRoute.of(context).settings.arguments;
    print(element['data']['nombre']);
    size = MediaQuery.of(context).size;

    if (element['data'] != null && ifController == false) {
      if (element['data'] != '' || element['producto'] != null) {
        razonSocialController.text =
            element['aliado']['razon_social'] ?? pref.nombre;
      }

      if (element['data'] != '' || element['producto'] != null) {
        nombreAliadoController.text = element['aliado']['nombre'] ?? '';
      }

      if (element['data'] != '' || element['producto'] != null) {
        nitController.text = element['aliado']['nit'].toString();
      }
      // nitController.text = _pref.id_aliado.toString() ;

      ifController = true;
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                image(context),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      color: size.width > 650 ? gris : Colors.transparent,
                      width: size.width < 600 ? size.width : 600,
                      child: contenido(context)),
                ),
              ],
            ),
          ),
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
    double t = size.width < 200
        ? tamanno400
        : size.width < 300
            ? 10
            : size.width < 400
                ? 12.5
                : size.width < 500
                    ? 13.5
                    : size.width < 600
                        ? 14
                        : 15;
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                    child: fotoPortada != null
                        ? Image(
                            fit: BoxFit.cover,
                            height: size.width < 400 ? size.height * 0.3 : 200,
                            width: double.infinity,
                            image: FileImage(fotoPortada),
                          )
                        : Image(
                            fit: BoxFit.cover,
                            height: size.width < 400 ? size.height * 0.3 : 200,
                            width: double.infinity,
                            image: NetworkImage(
                                '$storage${element['aliado']['url_foto_portada']}'),
                          )),
                Column(
                  children: [
                    Image.asset(
                      'assets/Rectangle.png',
                      height: size.width < 400 ? size.height * 0.3 : 200,
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
          height: size.width < 400 ? size.height * 0.3 : 200,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  element['aliado']['nombre'],
                  style:
                      TextStyle(color: amarillo, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  element['aliado']['razon_social'] ?? pref.nombre,
                  style: TextStyle(color: blanco),
                ),
              ),
              SizedBox(height: size.width < 400 ? size.height * 0.05 : 20),
            ],
          ),
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.width < 400 ? size.height * 0.255 : 165),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Center(
                  child: Container(
                    height: 25,
                    width: size.width < 250
                        ? 80
                        : size.width < 450
                            ? size.width * 0.3
                            : size.width < 700
                                ? size.width * 0.26
                                : 160,
                    child: RaisedButton(
                      color: verde,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.upload_rounded,
                            color: Colors.white,
                            size: t,
                          ),
                          Text(
                              size.width < 380
                                  ? "Subir"
                                  : size.width < 400
                                      ? 'Subir Foto'
                                      : size.width < 660
                                          ? "Subir Foto"
                                          : 'Subir Foto',
                              style:
                                  TextStyle(fontSize: t, color: Colors.white)),
                        ],
                      ),
                      onPressed: () {
                        onpressaddImage(context, true);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      onpressaddImage(context, false);
                    },
                    child: CircleAvatar(
                      radius: 35,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10000),
                            child: fotoPefil == null
                                ? FadeInImage(
                                    fit: BoxFit.cover,
                                    height: size.width < 400
                                        ? size.height * 0.3
                                        : 200,
                                    width: double.infinity,
                                    placeholder: AssetImage('assets/load.gif'),
                                    image: NetworkImage(
                                        '$storage${element['aliado']['url_foto_perfil']}'))
                                : Image.file(
                                    fotoPefil,
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  )),
                        radius: 34,
                      ),
                      backgroundColor: verde,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget contenido(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('EditarUsuarioAliado');
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Editar usuario'),
                    Icon(Icons.edit, color: verde)
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Datos',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: size.width < 190 ? size.width * 0.07 : 13)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: crearRazonSocial(context),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            nombreAliado(context),
            SizedBox(
              height: size.height * 0.05,
            ),
            crearTelefono(context),
            // SizedBox(
            //   height: size.height * 0.05,
            // ),
            // crearContrasena(context),
            // SizedBox(
            //   height: size.height * 0.05,
            // ),
            // crearConfirmarContrasena(context),
            // SizedBox(
            //   height: size.height * 0.05,
            // ),
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

  Widget crearRazonSocial(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'razon social',
              style: TextStyle(
                  fontSize: size.width < 400 ? size.width * 0.04 : 15),
            ),
          ],
        ),
        TextFormField(
          focusNode: correoFocus,
          controller: razonSocialController,
          validator: (value) {
            return validar.validateGenerico(value);
          },
          decoration: InputDecoration(
            hintText: 'razon social',
          ),
          onFieldSubmitted: (value) {
            nombreAliadoFocus.requestFocus();
          },
        ),
      ],
    );
  }

  Widget nombreAliado(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre del aliado',
              style: TextStyle(
                  fontSize: size.width < 400 ? size.width * 0.04 : 15),
            ),
          ],
        ),
        TextFormField(
          focusNode: nombreAliadoFocus,
          controller: nombreAliadoController,
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

  Widget crearTelefono(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nit',
              style: TextStyle(
                  fontSize: size.width < 400 ? size.width * 0.04 : 15),
            ),
          ],
        ),
        TextFormField(
          focusNode: telefonoFocus,
          controller: nitController,
          validator: (value) {
            return validar.validateNumerico(value);
          },
          decoration: InputDecoration(
            hintText: '3215674784',
          ),
        ),
      ],
    );
  }

  // Widget crearContrasena(BuildContext context) {
  //   return Column(
  //     children: [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Contraseña',
  //             style: TextStyle(
  //                 fontSize: size.width < 400 ? size.width * 0.04 : 15),
  //           ),
  //         ],
  //       ),
  //       TextFormField(
  //         obscureText: eye,
  //         focusNode: contrasenaFocus,
  //         controller: contrasenaController,
  //         validator: (value) {
  //           return validar.validatePassword(value);
  //         },
  //         decoration: InputDecoration(
  //           hintText: '********',
  //         ),
  //         onFieldSubmitted: (value) {
  //           confimarContrasenaFocus.requestFocus();
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget crearConfirmarContrasena(BuildContext context) {
  //   return Column(
  //     children: [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Confirmar Contraseña',
  //             style: TextStyle(
  //                 fontSize: size.width < 400 ? size.width * 0.04 : 15),
  //           ),
  //         ],
  //       ),
  //       TextFormField(
  //         obscureText: eye,
  //         focusNode: confimarContrasenaFocus,
  //         controller: confimarContrasenaController,
  //         validator: (value) {
  //           return validar.validateRepetPassword(
  //               confimarContrasenaController.text, contrasenaController.text);
  //         },
  //         decoration: InputDecoration(
  //           suffixIcon: IconButton(
  //               onPressed: () {
  //                 setState(() {
  //                   eye = !eye;
  //                 });
  //               },
  //               icon: Icon(
  //                 eye != false
  //                     ? Icons.remove_red_eye_rounded
  //                     : Icons.visibility_off,
  //               )),
  //           hintText: '********',
  //         ),
  //         onFieldSubmitted: (value) {
  //           submit();
  //         },
  //       ),
  //     ],
  //   );
  // }

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

  void onpressaddImage(BuildContext context, bool isPortada) {
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
                          cargarImageCamera(isPortada);
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
                          cargarImageGalery(isPortada);
                          Navigator.pop(context);
                        })),
              ],
            ),
          );
        });
  }

  Future cargarImageGalery(bool isPortada) async {
    var tempImage = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.gallery);
    setState(() {
      if (isPortada == true) {
        fotoPortada = tempImage;
      } else {
        fotoPefil = tempImage;
      }
    });
  }

  Future cargarImageCamera(bool isPortada) async {
    var tempImage = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.camera);

    setState(() {
      if (isPortada == true) {
        fotoPortada = tempImage;
      } else {
        fotoPefil = tempImage;
      }
    });
  }

  // void submit() {
  //   if (!formKey.currentState.validate()) {
  //     return null;
  //   }
  // }

  put() async {
    if (!formKey.currentState.validate()) {
      return null;
    }
    try {
      load(context);
      var resp = await http.putMethod(
          table: 'aliado',
          id: int.parse(pref.id_aliado),
          token: pref.token,
          body: {
            "id": "${pref.id_aliado}",
            "nombre": "${nombreAliadoController.text}",
            "nit": "${nitController.text}",
            "razon_social": "${razonSocialController.text}",
            "url_foto_perfil":fotoPefil!=null?"${base64Encode(fotoPefil.readAsBytesSync())}":"no",
            "url_foto_portada": fotoPortada != null
                ? "${base64Encode(fotoPortada.readAsBytesSync())}"
                : "no",
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

        return alerta(
          context,
          code: false,
          titulo: 'Enhorabuena',
          contenido: 'Se actualizo correctamente',
        );
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
      // if (element['data'] != '' || element['producto'] != null) {
      //   razonSocialController.text =
      //       element['aliado']['razon_social'] ?? pref.nombre;
      // }

      // if (element['data'] != '' || element['producto'] != null) {
      //   nombreAliadoController.text = element['aliado']['nombre'] ?? '';
      // }

      // if (element['data'] != '' || element['producto'] != null) {
      //   nitController.text = element['data']['telefono'].toString();
      // }
      return alerta(context,
          titulo: "alerta",
          contenido: 'algo salio mal intentelo nuevamente.',
          code: false);
    }
  }
}
