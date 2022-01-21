import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/pages/registros/model/UsuarioModel.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class RegistrarClienteAdminPage extends StatefulWidget {
  @override
  _RegistrarClienteAdminPage createState() => _RegistrarClienteAdminPage();
}

class _RegistrarClienteAdminPage extends State<RegistrarClienteAdminPage> {
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
  UsuarioProvider usuarioProvider;
  String _vista = 'Tipo de Documento';
  List<int> id;
  List<String> nombres;
  Map<String, dynamic> element;
  Map<String, int> valores = {};
  Validaciones validar = new Validaciones();
  Size size;
  File perfilImage;
  bool mostrar = true;

  @override
  Widget build(BuildContext context) {
    element = ModalRoute.of(context).settings.arguments;

    id = element['id'];
    nombres = element['nombre'];

    if (valores.isEmpty) {
      element['modelo'].data.forEach((element) {
        valores.addAll({"${element.nombre}": element.id});
      });
      print("ok" + valores.toString());
    }

    usuarioProvider = Provider.of<UsuarioProvider>(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 241, 1, 1),
        title: Text(
          'Crear Cliente',
          style: TextStyle(color: verde),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
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
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              crearBoton1(
                  colorBoton: rojo,
                  colorTexto: Colors.white,
                  context: context,
                  texto: 'CANCELAR'),
              SizedBox(width: size.width * 0.05),
              crearBoton2(
                  colorBoton: amarillo,
                  colorTexto: verde,
                  context: context,
                  texto: 'CREAR'),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ],
      )),
    );
  }

  Widget crearNombre() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nombre'),
        TextFormField(
          focusNode: nombreFocus,
          controller: nombreController,
          validator: (value) => validar.validateName(value),
          decoration: InputDecoration(hintText: 'Yohan Blanco'),
          onFieldSubmitted: (value) {
            documentFocus.requestFocus();
          },
        ),
      ],
    );
  }

  Widget crearDocumento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Numero de documento'),
        TextFormField(
          focusNode: documentFocus,
          controller: documentoController,
          keyboardType: TextInputType.number,
          //  validator: (value) =>validar.isNumeric( ),
          validator: (value) => validar.validateNumerico(value),
          decoration: InputDecoration(hintText: '100725538'),
          onFieldSubmitted: (value) {
            telefonoFocus.requestFocus();
          },
        ),
      ],
    );
  }

  Widget crearTelefono() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Numero de telefono'),
        TextFormField(
          focusNode: telefonoFocus,
          keyboardType: TextInputType.number,
          controller: telefonoController,
          // keyboardType:,
          validator: (value) => validar.validateNumerico(value),
          decoration: InputDecoration(hintText: '45280287'),
          onFieldSubmitted: (value) {
            correoFocus.requestFocus();
          },
        ),
      ],
    );
  }

  Widget crearCorreo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Correo Electrónico o Teléfono'),
        TextFormField(
          focusNode: correoFocus,
          controller: correoController,
          validator: (value) => validar.validateEmail(value),
          decoration: InputDecoration(hintText: 'Tucorre@ejemplo.com'),
          onFieldSubmitted: (value) {
            contrasenaFocus.requestFocus();
          },
        ),
      ],
    );
  }

  Widget crearContrasena() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contraseña'),
        TextFormField(
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
      ],
    );
  }

  Widget crearConfirmarContrasena() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Confirmar contraseña'),
        TextFormField(
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

  Widget crearImagen(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
              decoration: BoxDecoration(
                  color: verdeClaro, borderRadius: BorderRadius.circular(100)),
              width: 150,
              height: 150,
              child: perfilImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                          fit: BoxFit.cover, image: FileImage(perfilImage)),
                    )
                  : null),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 120),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  onpressaddImage(context);
                },
                child: Container(
                  width: size.width < 425
                      ? 70
                      : size.width < 615
                          ? 90
                          : 100,
                  child: Center(
                      child: Text(size.width < 425 ? 'Subir' : 'Subir imagen',
                          style: TextStyle(
                            color: verde,
                            // fontSize: 30),
                          ))),
                ),
              ),
            ],
          ),
        )
      ],
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          height: orientation == Orientation.portrait
              ? size.height * 0.050
              : size.height * 0.070,
          width: orientation == Orientation.portrait
              ? size.width * 0.35
              : size.width * 0.20,
          child: RaisedButton(
              child: Text(
                "CANCELAR",
                style: TextStyle(
                  fontSize: orientation == Orientation.portrait
                      ? size.height * 0.017
                      : size.height * 0.030,
                  color: verde,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: Color.fromRGBO(255, 244, 1, 1),
              elevation: 0.0,
              onPressed: () {
                if (!formKey.currentState.validate()) return null;
              }),
        ),
        Container(
          height: orientation == Orientation.portrait
              ? size.height * 0.050
              : size.height * 0.070,
          width: orientation == Orientation.portrait
              ? size.width * 0.35
              : size.width * 0.20,
          child: RaisedButton(
              child: Text(
                'CREAR',
                style: TextStyle(
                    fontSize: orientation == Orientation.portrait
                        ? size.height * 0.017
                        : size.height * 0.030,
                    color: verde),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: Color.fromRGBO(255, 244, 1, 1),
              elevation: 0.0,
              onPressed: () {
                Navigator.of(context).pushNamed('');
              }),
        )
      ],
    );
  }

  Widget crearBoton1(
      {BuildContext context,
      String texto,
      Color colorBoton,
      Color colorTexto}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: size.height > 762 ? 32.766 : size.height * 0.043,
      width: size.width > 333 ? 126.54 : size.width * 0.38,
      child: RaisedButton(
        elevation: 2,
        color: colorBoton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Text(texto ?? '',
            style: TextStyle(
                fontSize: size.width > 333
                    ? 14.985
                    : size.width < 251
                        ? 8
                        : size.width * 0.045,
                color: colorTexto)),
        onPressed: () {},
      ),
    );
  }

  Widget crearBoton2(
      {BuildContext context,
      String texto,
      Color colorBoton,
      Color colorTexto}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: size.height > 762 ? 32.766 : size.height * 0.043,
      width: size.width > 333 ? 126.54 : size.width * 0.38,
      child: RaisedButton(
        elevation: 2,
        color: colorBoton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Text(texto ?? '',
            style: TextStyle(
                fontSize: size.width > 333
                    ? 14.985
                    : size.width < 251
                        ? 8
                        : size.width * 0.045,
                color: colorTexto)),
        onPressed: () {
          if (!formKey.currentState.validate()) return null;
          submit();
        },
      ),
    );
  }

  submit() async {
    //borro lo respuesta ddlregistro anterior
    usuarioProvider.deleteResp();

    //valido el formulario
    chekForm();

    //intentando Subir el Cliente
    Map<String, dynamic> _respuesta = await usuarioProvider.postUsuario(
      context: context,
      usuario: UsuarioModel(
          rol: 'cliente',
          nombre: nombreController.text,
          email: correoController.text,
          telefono: int.parse(telefonoController.text),
          password: contrasenaController.text,
          tipoDocumento: valores['$_vista'],
          numeroDocumento: int.parse(documentoController.text),
          urlFotoPerfil: perfilImage != null
              ? base64Encode(perfilImage.readAsBytesSync())
              : 'no'),
    );

    chekResp(_respuesta);

    // Navigator.pop(context);
    // return alerta(context,code:false,contenido: 'Algo salio mal');
  }

  //--------------- BackZone -----------------//

  chekForm() {
    if (!formKey.currentState.validate()) return null;

    //valido el tipo Documento
    if (_vista == "Tipo de Documento") {
      return alerta(context,
          code: false, contenido: 'el campo tipo de documento es necesario.');
    }
  }

  chekResp(respuesta) {
    if (respuesta['message'] == "false") {
      mensajeNegativo(context, respuesta: respuesta);
    }

    if (respuesta['message'] == "true") {
      mensajePositivo(context);
    }
  }

  mensajeNegativo(
    context, {
    Map respuesta,
  }) {
    Navigator.pop(context);
    print(respuesta.toString() + 'Errors in Crear Usuario');
    dynamic res = json.encode(respuesta);

    print(res);
    var respModel = errorsFormModelFromJson(res);
    List<Widget> errors = [];

    try {
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
                    // '${index.toString().replaceAll(new RegExp(r'.0'), '')}','
                    '0',
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

      return alerta(
        context,
        contenido: Column(
          children: errors,
        ),
      );
    } catch (error) {
      return alerta(context, code: false, contenido: 'Error en el servidor');
    }
  }

  mensajePositivo(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Image(image: AssetImage('assets/tick.png'), width: 35),
                Text(
                  'Cliente Creado',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Exitosamente',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    shape: StadiumBorder(),
                    color: verde,
                    child: Text(
                      'Listo',
                      style: TextStyle(
                          color: blanco,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ))
              ],
            ),
          );
        });
  }
}
