import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/crear/categorias.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class EditarPerfilAdministrador extends StatefulWidget {
  const EditarPerfilAdministrador({Key key}) : super(key: key);

  @override
  _EditarPerfilAdministradorState createState() =>
      _EditarPerfilAdministradorState();
}

// PreferenciasUsuario _pref = new PreferenciasUsuario();

class _EditarPerfilAdministradorState extends State<EditarPerfilAdministrador> {
  File perfilImage;

  bool datos = false;
  Validaciones _validar = new Validaciones();
  TextEditingController correoController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController nombreController = new TextEditingController();
  PreferenciasUsuario _pref = new PreferenciasUsuario();
  PeticionesHttpProvider http = new PeticionesHttpProvider();
  var formKey = GlobalKey<FormState>();
  Size size;
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    if (datos == false) {
      nombreController.text = _pref.nombre;
      telefonoController.text = _pref.telefono;
      correoController.text = _pref.email;
      datos = true;
    }
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                appbarStack(context),
                SizedBox(
                  height: _size.height * 0.045,
                ),
                Text(
                  '${_pref.nombre} ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: _orientacion == Orientation.portrait
                          ? _size.width * 0.09
                          : _size.width * 0.05),
                ),
                SizedBox(
                  height: _size.height * 0.045,
                ),
                Text(
                  'Datos',
                  style: TextStyle(
                      color: Color.fromRGBO(151, 151, 151, 1),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: _size.height * 0.045,
                ),
                crearNombre(context),
                SizedBox(height: _size.height * 0.03),
                crearCorreo(context),
                SizedBox(height: _size.height * 0.03),
                crearTelefono(context),
                SizedBox(height: _size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    crearBoton(
                        colorBoton: rojo,
                        colorTexto: Colors.white,
                        context: context,
                        texto: 'CANCELAR'),
                    SizedBox(width: _size.width * 0.08),
                    crearBoton(
                        colorBoton: amarillo,
                        colorTexto: verde,
                        context: context,
                        texto: 'GUARDAR',
                        onpress: () {
                          submit(context);
                        })
                  ],
                ),
                SizedBox(height: _size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  submit(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    load(context);

    Map _respuesta = await http.putMethod(
      body: {
        'nombre': '${nombreController.text}',
        'email': '${correoController.text}',
        'telefono': '${int.parse(telefonoController.text)}',
        'url_foto_perfil':perfilImage!=null?'${base64Encode(perfilImage.readAsBytesSync())}':'no'
      },
      id: int.parse(_pref.user_id),
      table: 'user',
      token: _pref.token,
      context: context,
    );

    if (_respuesta['message'] == "false") {
      Navigator.pop(context);
      //  Navigator.pop(context);
      print(_respuesta.toString() + '----Bad');
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
                    style: TextStyle(color: verde, fontWeight: FontWeight.bold),
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

    if (_respuesta['message'] == 'true') {
      Navigator.pop(context);
      setState(() {
        _pref.nombre = nombreController.text;
        _pref.telefono = telefonoController.text;
        _pref.email = correoController.text;
        _pref.url_foto_perfil = _respuesta['data']['url_foto_perfil'];
      });

      alerta(context,
          titulo: 'Enhorabuena!',
          code: false,
          contenido: 'Los datos han sido actualizados correctamente');
    }
  }

  Widget appbarStack(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        AppBar(
          title: Text('Perfil',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: blanco,
          elevation: 0,
          iconTheme: IconThemeData(color: verde),
        ),
        Column(
          children: [
            SizedBox(
              height: _orientacion == Orientation.portrait
                  ? _size.height * 0.045
                  : _size.height * 0.095,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: _orientacion == Orientation.portrait
                        ? _size.width * 0.32
                        : _size.width * 0.2,
                    height: _orientacion == Orientation.portrait
                        ? _size.width * 0.07
                        : _size.width * 0.038,
                    child: RaisedButton(
                        child: Text(
                          'Administrador',
                          style: TextStyle(
                              color: blanco,
                              fontSize: _orientacion == Orientation.portrait
                                  ? _size.width * 0.044
                                  : _size.width * 0.026),
                        ),
                        onPressed: () {},
                        color: verde,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(13),
                                topLeft: Radius.circular(13))))),
              ],
            ),
          ],
        ),
        fotoDePerfil(context)
      ],
    );
  }

  Widget fotoDePerfil(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: _orientacion == Orientation.portrait
                      ? _size.height * 0.08
                      : _size.height * 0.115,
                ),
                CircleAvatar(
                    backgroundColor: verde,
                    child: perfilImage != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(perfilImage),
                            radius: _orientacion == Orientation.portrait
                                ? _size.width * 0.138
                                : _size.width * 0.09,
                            backgroundColor: Colors.white)
                        : _pref.url_foto_perfil!=null? CircleAvatar(
                          
                            backgroundImage: NetworkImage(
                                storage+_pref.url_foto_perfil),
                           radius: _orientacion == Orientation.portrait
                            ? _size.width * 0.138
                            : _size.width * 0.09,
                            backgroundColor: Colors.white):Container(),
                    radius: _orientacion == Orientation.portrait
                        ? _size.width * 0.143
                        : _size.width * 0.093),
              ],
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: _orientacion == Orientation.portrait
                  ? _size.width * 0.43
                  : _size.width * 0.23,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: _orientacion == Orientation.portrait
                        ? _size.width * 0.35
                        : _size.width * 0.22,
                    height: _orientacion == Orientation.portrait
                        ? _size.width * 0.07
                        : _size.width * 0.038,
                    child: RaisedButton.icon(
                      icon: Icon(Icons.cloud_upload,
                          color: blanco,
                          size: _orientacion == Orientation.portrait
                              ? _size.width * 0.045
                              : _size.width * 0.022),
                      label: Text(
                        'Subir Foto',
                        style: TextStyle(
                            color: blanco,
                            fontSize: _orientacion == Orientation.portrait
                                ? _size.width * 0.041
                                : _size.width * 0.023),
                      ),
                      onPressed: () {
                        onpressaddImage(context);
                      },
                      color: verde,
                      shape: StadiumBorder(),
                    ))
              ],
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

  Widget crearNombre(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: orientacion == Orientation.portrait
                ? size.height * 0.08
                : size.height * 0.165,
            width: orientacion == Orientation.portrait
                ? size.width * 0.85
                : size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('nombre'),
                TextFormField(
                    validator: (value) => _validar.validateName(value),
                    controller: nombreController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'juan')),
              ],
            )),
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
            height: orientacion == Orientation.portrait
                ? size.height * 0.08
                : size.height * 0.165,
            width: orientacion == Orientation.portrait
                ? size.width * 0.85
                : size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('correo'),
                TextFormField(
                    validator: (value) => _validar.validateEmail(value),
                    controller: correoController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'adminyohanblanco@gmail.com')),
              ],
            )),
      ],
    );
  }

  Widget crearTelefono(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: orientacion == Orientation.portrait
                ? size.width * 0.85
                : size.width * 0.9,
            height: orientacion == Orientation.portrait
                ? size.height * 0.08
                : size.height * 0.165,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Telefono'),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly

                  ],
                    validator: (value) => _validar.validateNumerico(value),
                    controller: telefonoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '3106404303')),
              ],
            )),
      ],
    );
  }

  Widget crearBoton({
    BuildContext context,
    String texto,
    Color colorBoton,
    Color colorTexto,
    Function onpress,
  }) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: orientation == Orientation.portrait
          ? size.height * 0.05
          : size.height * 0.10,
      width: orientation == Orientation.portrait
          ? size.width * 0.4
          : size.width * 0.25,
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
        onPressed: onpress ?? () {},
      ),
    );
  }
}
