// import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/pages/registros/model/UsuarioModel.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
// import 'package:traelo_app/src/pages/registros/registroCliente/model/UsuarioModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';
// import 'package:http/http.dart'as http;

// import 'Providers/RegistroProvider.dart';

class CrearUsuariosAliado extends StatefulWidget {
  @override
  _CrearUsuariosAliadoState createState() => _CrearUsuariosAliadoState();
}

class _CrearUsuariosAliadoState extends State<CrearUsuariosAliado> {
  Size size;
  String _vista = 'Tipo de Documento';
  // int valorIdDocumento;

  TextEditingController nombreController = new TextEditingController();
  TextEditingController documentoController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController correoController = new TextEditingController();
  TextEditingController contrasenaController = new TextEditingController();
  TextEditingController confirmarContrasenaController =
      new TextEditingController();
  FocusNode nombreFocus = new FocusNode();
  FocusNode documentFocus = new FocusNode();
  FocusNode telefonoFocus = new FocusNode();
  FocusNode correoFocus = new FocusNode();
  FocusNode contrasenaFocus = new FocusNode();
  FocusNode confirmarContrasenaFocus = new FocusNode();
  var formKey = GlobalKey<FormState>();
  Validaciones validar = new Validaciones();
  PreferenciasUsuario pref = new PreferenciasUsuario();
  File perfilImage;
  bool mostrar = true;
  UsuarioProvider usuarioProvider;
  Funciones funciones = new Funciones();
  @override
  void initState() {
    super.initState();
  }

  int id;
  List<String> nombres;
  Map<String, dynamic> element;
  Map<String, int> valores = {};
  @override
  Widget build(BuildContexcontext) {
    element = ModalRoute.of(context).settings.arguments;
    print(element['id_sucursal'].toString());
    id = element['id_sucursal'];
    nombres = element['nombre'];

    if (valores.isEmpty) {
      element['modelo'].data.forEach((element) {
        valores.addAll({"${element.nombre}": element.id});
      });
      print("ok" + valores.toString());
    }
    size = MediaQuery.of(context).size;
    usuarioProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 241, 1, 1),
        title: Text(
          'Registro Asistente',
          style: TextStyle(color: verde),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                crearImagen(context),
                crearNombre(),
                SizedBox(height: size.height * 0.03),
                _drowDow(),
                SizedBox(height: size.height * 0.03),
                crearDocumento(),
                SizedBox(height: size.height * 0.03),
                crearTelefono(),
                SizedBox(height: size.height * 0.03),
                crearCorreo(),
                SizedBox(height: size.height * 0.03),
                crearContrasena(),
                SizedBox(height: size.height * 0.03),
                crearConfirmarContrasena(),
                SizedBox(
                  height: size.height * 0.10,
                ),
                botones(context),
              ],
            )),
      )),
    );
  }

  Widget crearNombre() {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nombre'),
        Container(
          width: size.width > 450 ? 440 : size.width,
          child: TextFormField(
            focusNode: nombreFocus,
            controller: nombreController,
            validator: (value) => validar.validateName(value),
            decoration: InputDecoration(hintText: 'Juan Andres'),
            onFieldSubmitted: (value) {
              documentFocus.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget _drowDow() {
    return DropdownButton(
      // value: _vista,

      // underline: id,
      // onTap: (){  user.obetenerTipoDocumento(); },
      // onTap:(){obetenerTipoDocumento(); },
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: verde,
      ),
      items: nombres.map((String lista) {
        return DropdownMenuItem(value: lista, child: Text(lista));
      }).toList(),
      onChanged: (value) => {
        setState(() {
          _vista = value;
          // valorIdDocumento = value;
        })
      },
      hint: Text(_vista),
      // value:_vista. ,
    );
  }

  Widget crearDocumento() {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Numero de documento'),
        Container(
          width: size.width > 450 ? 440 : size.width,
          child: TextFormField(
            focusNode: documentFocus,
            controller: documentoController,
            keyboardType: TextInputType.number,
            //  validator: (value) =>validar.isNumeric( ),
            validator: (value) => validar.validateNumerico(value),
            decoration: InputDecoration(hintText: '1002426523'),
            onFieldSubmitted: (value) {
              telefonoFocus.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget crearTelefono() {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Numero de telefono'),
        Container(
          width: size.width > 450 ? 440 : size.width,
          child: TextFormField(
            focusNode: telefonoFocus,
            keyboardType: TextInputType.number,
            controller: telefonoController,
            // keyboardType:,
            validator: (value) => validar.validateNumerico(value),
            decoration: InputDecoration(hintText: '3136964200'),
            onFieldSubmitted: (value) {
              correoFocus.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget crearCorreo() {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Correo Electrónico'),
        Container(
          width: size.width > 450 ? 440 : size.width,
          child: TextFormField(
            focusNode: correoFocus,
            controller: correoController,
            validator: (value) => validar.validateEmail(value),
            decoration: InputDecoration(hintText: 'correo@ejemplo.com'),
            onFieldSubmitted: (value) {
              contrasenaFocus.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget crearContrasena() {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contraseña'),
        Container(
          width: size.width > 450 ? 440 : size.width,
          child: TextFormField(
            obscureText: mostrar,
            focusNode: contrasenaFocus,
            controller: contrasenaController,
            // keyboardType: TextInputType.number,
            validator: (value) => validar.validatePassword(value),
            decoration: InputDecoration(hintText: '********'),
            onFieldSubmitted: (value) {
              confirmarContrasenaFocus.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget crearConfirmarContrasena() {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Confirmar contraseña'),
        Container(
          width: size.width > 450 ? 440 : size.width,
          child: TextFormField(
            obscureText: mostrar,
            focusNode: confirmarContrasenaFocus,
            controller: confirmarContrasenaController,
            validator: (value) =>
                validar.validateRepetPassword(value, contrasenaController.text),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(mostrar ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      mostrar = !mostrar;
                    });
                  },
                ),
                hintText: '********'),
          ),
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
            : Container(),
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

  Widget botones(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: size.width > 450 ? 50 : size.height * 0.070,
          width: size.width > 450 ? 200 : size.width * 0.35,
          child: RaisedButton(
              child: Text(
                'Cancelar',
                style: TextStyle(
                    fontSize: size.width > 450 ? 10 : size.height * 0.017,
                    color: verde),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Color.fromRGBO(255, 244, 1, 1),
              elevation: 0.0,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          height: size.width > 450 ? 50 : size.height * 0.070,
          width: size.width > 450 ? 200 : size.width * 0.35,
          child: RaisedButton(
              child: Text(
                "Registrar",
                style: TextStyle(
                  fontSize: size.width > 450 ? 10 : size.height * 0.017,
                  color: verde,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Color.fromRGBO(255, 244, 1, 1),
              elevation: 0.0,
              onPressed: () {
                submit();
              }),
        ),
      ],
    );
  }

  submit() async {
    
    usuarioProvider.deleteResp();
    if (!formKey.currentState.validate()) return null;

    if (_vista == "Tipo de Documento") {
      return alert('el campo tipo de documento es necesario.');
    }
    dynamic imagen;
    if (perfilImage != null) {
      imagen = null;
      imagen = base64Encode(perfilImage.readAsBytesSync());
    }
    
    load(context);
    Map<String, dynamic> _respuesta = await usuarioProvider.postUsuario(
      context: context,
      usuario: UsuarioModel(
        idAliado: int.parse(pref.id_aliado),
        rol: 'asistente',
        nombre: nombreController.text,
        email: correoController.text,
        telefono: int.parse(telefonoController.text),
        password: contrasenaController.text,
        tipoDocumento: valores['$_vista'],
        numeroDocumento: int.parse(documentoController.text),
        urlFotoPerfil: 'sadasdasdasd',
        idSucursal: element['id_sucursal'],
      ),
    );
    // Map <String,dynamic> decodeResp  = json.decode(_respuesta.body);
    // print(decodeResp['errors']);
    // if(_respuesta. != 200){
      Navigator.pop(context);
    if (_respuesta['message'] == "expiro") {
      
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
    } else {}

    if (_respuesta['message'] == "false") {
      // Navigator.pop(context);
      print(_respuesta.toString() + '---------------------------------Bad');
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

      alerta(
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

    if (_respuesta['message'] == "true") {
     
      alerta(
        context,
        contenido: Text(
          'Tu usuario se ha creado correctamente.',
          style: TextStyle(color: Colors.grey),
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
              color: verdeClaro,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ],
              )),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.of(context).pushNamed('UsuariosAliado');
              },
            ),
          ),
        ),
      );
    }

    // return  alert('${usuarioProvider.getRespuesta}');
    //  return showDialog(context: context,builder:(context){return AlertDialog(  content:SingleChildScrollView(child: Text(user.getRespuesta  )) , );  });

    // }

    // return  alert('${usuarioProvider.getRespuesta}');
    //  return showDialog(context: context,builder:(context){return AlertDialog(  content:SingleChildScrollView(child: Text(user.getRespuesta  )) , );  });
  }

  alert(String texto) {
    return alerta(
      context,
      acciones: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
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
        ],
      ),
      contenido: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
            child: Text(
          '$texto',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        )),
      ),
    );
  }
}
