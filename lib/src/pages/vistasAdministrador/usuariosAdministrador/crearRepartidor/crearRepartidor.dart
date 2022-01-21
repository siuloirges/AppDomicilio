import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/providers/adjuntarProviders.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class CrearRepartidor extends StatefulWidget {
  const CrearRepartidor({Key key}) : super(key: key);

  @override
  _CrearRepartidorState createState() => _CrearRepartidorState();
}

class _CrearRepartidorState extends State<CrearRepartidor> {
  bool o = true;
  MantenerEstadoRepartidorProvider valores;
  TextEditingController nombreController = new TextEditingController();
  TextEditingController documentoController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController correoController = new TextEditingController();
  TextEditingController contrasennaController = new TextEditingController();
  TextEditingController placaController = new TextEditingController();
  TextEditingController confirmarcontrasennaController =
      new TextEditingController();
  FocusNode nombreFocus = new FocusNode();
  FocusNode documentFocus = new FocusNode();
  FocusNode telefonoFocus = new FocusNode();
  FocusNode placaDevehiculoFocus = new FocusNode();
  FocusNode documentoFocus = new FocusNode();
  FocusNode correoFocus = new FocusNode();
  FocusNode contrasennaFocus = new FocusNode();
  FocusNode confirmarContrasennaFocus = new FocusNode();
  var formKey = GlobalKey<FormState>();
  Validaciones validar = new Validaciones();
  String _tipoDeDocumento = 'Tipo de Documento';
  String _tipoDeVehiculo = 'Tipo de Vehiculo';
  // File perfilImage;
  // bool mostrar = true;
  UsuarioProvider user;

  Map<String, dynamic> element;

  List<String> nombresVehiculos = [];
  List<int> idVehiculos = [];
  List<String> nombresTipoDocumento = [];
  List<int> idTipoDocumento = [];

  //  Map<String,dynamic> element;
  Map<String, int> valoresv = {};
  Map<String, int> valoresd = {};

  @override
  Widget build(BuildContext context) {
    element = ModalRoute.of(context).settings.arguments;

    nombresVehiculos = element['nombreV'];
    idVehiculos = element['idV'];

    nombresTipoDocumento = element['nombre'];
    idTipoDocumento = element['id'];

    if (valoresv.isEmpty) {
      print(element['modeloV'].data);
      element['modeloV'].data.forEach((element) {
        valoresv.addAll({"${element.nombre}": element.id});
        print(element.nombre);
        print(element.id);
      });
      print("ok" + valoresv.toString());
    }
    if (valoresd.isEmpty) {
      element['modeloD'].data.forEach((element) {
        valoresd.addAll({"${element.nombre}": element.id});
        print(element.nombre);
      });
      print("ok" + valoresd.toString());
    }
    user = Provider.of<UsuarioProvider>(context);

    valores = Provider.of<MantenerEstadoRepartidorProvider>(context);
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear Repartidor',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: verde,
              width: _size.width,
              height: 40,
              child: Center(
                  child: Text(
                'Datos de Nuevo Usuario',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: _size.height > 862 ? 21 : _size.width * 0.04,
                    fontWeight: FontWeight.w600),
              )),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    fotoDePerfil(context),
                    SizedBox(
                        height:
                            _size.width > 525 ? 26.25 : _size.height * 0.05),
                    Container(
                        width: _size.width > 525
                            ? 204.75 * 2
                            : _size.width > 525
                                ? 204.75 * 2
                                : _size.width * 0.78,
                        child: Column(
                          children: [
                            Text(
                              'Tipo De Documento',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: _size.width > 525
                                      ? 15.75
                                      : _size.width * 0.03),
                            ),
                            _drowDow(),
                          ],
                        )),
                    SizedBox(
                        height:
                            _size.width > 525 ? 26.25 : _size.height * 0.05),
                    crearNombreYdocumento(context),
                    SizedBox(height: _size.height * 0.03),
                    crearTelefonoYcorreo(context),
                    SizedBox(height: _size.height * 0.03),
                    crearContrasennaYconfirmar(context),
                    SizedBox(height: _size.height * 0.03),
                    crearVehicoloYplaca(context),
                    SizedBox(height: _size.height * 0.09),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        crearBoton1(
                            colorBoton: rojo,
                            colorTexto: Colors.white,
                            context: context,
                            texto: 'CANCELAR'),
                        SizedBox(width: _size.width * 0.08),
                        crearBoton2(
                            colorBoton: amarillo,
                            colorTexto: verde,
                            context: context,
                            texto: 'SIGUIENTE')
                      ],
                    ),
                  ],
                )),
            SizedBox(height: _size.height * 0.05),
          ],
        ),
      ),
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
                    height: _size.width > 525 ? 10.5 : _size.height * 0.02),
                CircleAvatar(
                    backgroundColor: verde,
                    child: valores.getFotoPerfil != null
                        ? CircleAvatar(
                            child: Image(
                                fit: BoxFit.cover,
                                image: FileImage(valores.getFotoPerfil)),
                            radius:
                                _size.width > 525 ? 72.45 : _size.width * 0.138,
                            backgroundColor: Colors.white)
                        : Container(),
                    radius: _size.width > 525 ? 75.075 : _size.width * 0.143),
              ],
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
                height: _size.width < 256
                    ? _size.width * 0.3
                    : _size.width > 525
                        ? 147
                        : _size.width * 0.28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: _size.width > 525 ? 183.75 : _size.width * 0.35,
                    height: _size.width > 525 ? 36.75 : _size.width * 0.07,
                    child: RaisedButton.icon(
                      icon: Icon(Icons.cloud_upload,
                          color: blanco,
                          size:
                              _size.width > 525 ? 23.625 : _size.width * 0.045),
                      label: Text(
                        _size.width < 309 ? 'Subir' : 'Subir Foto',
                        style: TextStyle(
                            color: blanco,
                            fontSize: _size.width > 525
                                ? 21.525
                                : _size.width * 0.041),
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
      valores.setFotoPerfil = tempImage;
    });
  }

  Future cargarImageCamera() async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.camera);

    setState(() {
      valores.setFotoPerfil = tempImageCamera;
    });
  }

  Widget crearNombreYdocumento(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: _size.width > 525
              ? 204.75
              : _size.width > 525
                  ? 204.75
                  : _size.width * 0.39,
          // height: _orientacion == Orientation.portrait
          //     ? _size.height * 0.08
          //     : _size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _size.width > 525 ? 15.75 : _size.width * 0.03),
              ),
              TextFormField(
                initialValue: valores.getNombre,
                validator: (value) => validar.validateName(value),
                onFieldSubmitted: (value) {
                  documentoFocus.requestFocus();
                },
                onSaved: (value) => valores.guardarNombre = value,
                focusNode: nombreFocus,

                decoration: InputDecoration(hintText: 'Andres Felipe'),

                // },
              ),
            ],
          ),
        ),
        SizedBox(width: _size.width > 525 ? 36.75 : _size.width * 0.07),
        Container(
          width: _size.width > 525 ? 204.75 : _size.width * 0.39,
          // height: _orientacion == Orientation.portrait
          //     ? _size.height * 0.08
          //     : _size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Documento',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _size.width > 525 ? 15.75 : _size.width * 0.03),
              ),
              TextFormField(
                focusNode: documentoFocus,
                initialValue: valores.getDocumento,
                onSaved: (value) => valores.guardarDocumento = value,
                validator: (value) => validar.validateNumerico(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '900424678',
                ),
                onFieldSubmitted: (value) {
                  telefonoFocus.requestFocus();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _drowDowVehiculo() {
    return DropdownButton(
      // onTap: (){  user.obetenerTipoDocumento(); },
      // onTap:(){obetenerTipoDocumento(); },
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: verde,
      ),
      items: nombresVehiculos.map((String lista) {
        return DropdownMenuItem(value: lista, child: Text(lista));
      }).toList(),
      onChanged: (value) => {
        setState(() {
          _tipoDeVehiculo = value;
        })
      },
      hint: Text(_tipoDeVehiculo),
      // value:_vista. ,
    );
  }
  
   Widget _drowDow() {
    return DropdownButton(
      // onTap: (){  user.obetenerTipoDocumento(); },
      // onTap:(){obetenerTipoDocumento(); },
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: verde,
      ),
      items: nombresTipoDocumento.map((String lista) {
        return DropdownMenuItem(value: lista, child: Text(lista));
      }).toList(),
      onChanged: (value) => {
        setState(() {
          _tipoDeDocumento = value;
        })
      },
      hint: Text(_tipoDeDocumento),
      // value:_vista. ,
    );
  }
  Widget crearTelefonoYcorreo(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: _size.width > 525 ? 204.75 : _size.width * 0.39,
          // height: _orientacion == Orientation.portrait
          //     ? _size.height * 0.08
          //     : _size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Telefono',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _size.width > 525 ? 15.75 : _size.width * 0.03),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                focusNode: telefonoFocus,
                initialValue: valores.getTelefono,
                onSaved: (value) => valores.guardarTelefono = value,
                validator: (value) => validar.validateNumerico(value),
                decoration: InputDecoration(hintText: '3123450678'),
                onFieldSubmitted: (value) {
                  correoFocus.requestFocus();
                },
              ),
            ],
          ),
        ),
        SizedBox(width: _size.width > 525 ? 36.75 : _size.width * 0.07),
        Container(
          width: _size.width > 525 ? 204.75 : _size.width * 0.39,
          // height: _orientacion == Orientation.portrait
          //     ? _size.height * 0.08
          //     : _size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Correo',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _size.width > 525 ? 15.75 : _size.width * 0.03),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                focusNode: correoFocus,
                onSaved: (value) => valores.guardarCorreo = value,
                initialValue: valores.getCorreo,
                validator: (value) => validar.validateEmail(value),
                decoration: InputDecoration(
                  hintText: 'Administrador',
                ),
                onFieldSubmitted: (value) {
                  contrasennaFocus.requestFocus();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget crearContrasennaYconfirmar(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: _size.width > 525 ? 204.75 : _size.width * 0.39,
          // height: _orientacion == Orientation.portrait
          //     ? _size.height * 0.08
          //     : _size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contraseña ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _size.width > 525 ? 15.75 : _size.width * 0.03),
              ),
              TextFormField(
                obscureText: o,
                focusNode: contrasennaFocus,
                controller: contrasennaController,
                // initialValue: valores.getcontrasena,
                onSaved: (value) => valores.guardarContrasena = value,
                onChanged: (value) => valores.guardarContrasena = value,
                validator: (value) => validar.validatePassword(value),
                decoration: InputDecoration(hintText: '********'),
                onFieldSubmitted: (value) {
                  confirmarContrasennaFocus.requestFocus();
                },
              ),
            ],
          ),
        ),
        SizedBox(width: _size.width > 525 ? 36.75 : _size.width * 0.07),
        Container(
          width: _size.width > 525 ? 204.75 : _size.width * 0.39,
          // height: _orientacion == Orientation.portrait
          //     ? _size.height * 0.08
          //     : _size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confirme La Contraseña',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _size.width > 525 ? 15.75 : _size.width * 0.03),
              ),
              TextFormField(
                // controller: confirmarcontrasennaController,
                obscureText: o,
                // initialValue: valores.getConfirmarContrasena,
                focusNode: confirmarContrasennaFocus,
                // controller: nombreController,
                onChanged: (value) =>
                    valores.guardarConfirmarContrasena = value,
                validator: (value) => validar.validateRepetPassword(
                    value, contrasennaController.text),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: o == true
                        ? Icon(Icons.remove_red_eye)
                        : Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        o = !o;
                      });
                    },
                  ),
                  // labelText: "Confirme la contraseña",
                  hintText: "********",
                ),
                onFieldSubmitted: (value) {
                  placaDevehiculoFocus.requestFocus();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

 

  Widget crearVehicoloYplaca(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: _size.width > 525 ? 204.75 : _size.width * 0.39,
          // height: _orientacion == Orientation.portrait
          //     ? _size.height * 0.08
          //     : _size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tipo De Vehiculo ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _size.width > 525 ? 15.75 : _size.width * 0.03),
              ),
              _drowDowVehiculo()
            ],
          ),
        ),
        SizedBox(width: _size.width > 525 ? 36.75 : _size.width * 0.07),
        Container(
          width: _size.width > 525 ? 204.75 : _size.width * 0.39,
          // height: _orientacion == Orientation.portrait
          //     ? _size.height * 0.08
          //     : _size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Placa De Vehiculo',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _size.width > 525 ? 15.75 : _size.width * 0.03),
              ),
              TextFormField(
                focusNode: placaDevehiculoFocus,
                onSaved: (value) => valores.guardarPlaca = value,
                validator: (value) {
                  if (value.length == 0) {
                    return "El campo es necesario";
                  } else if (value.length <= 5) {
                    return 'El tamaño del campo debe ser más de 6 carácteres';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'CYV000',
                ),
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

  Widget crearBoton1(
      {BuildContext context,
      String texto,
      Color colorBoton,
      Color colorTexto}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: size.height > 862 ? 44.1 : size.height * 0.05,
      width: size.width > 525 ? 210 : size.width * 0.4,
      child: RaisedButton(
          elevation: 2,
          color: colorBoton,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Text(texto ?? '',
              style: TextStyle(
                  fontSize: size.width > 525 ? 23.625 : size.width * 0.045,
                  color: colorTexto)),
          onPressed: () {
            Navigator.pop(context);
          }),
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
      height: size.height > 862 ? 44.1 : size.height * 0.05,
      width: size.width > 525 ? 210 : size.width * 0.4,
      child: RaisedButton(
          elevation: 2,
          color: colorBoton,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Text(texto ?? '',
              style: TextStyle(
                  fontSize: size.width > 525 ? 23.625 : size.width * 0.045,
                  color: colorTexto)),
          onPressed: () {
            submit();
          }),
    );
  }

  submit() {
    if (!formKey.currentState.validate()) return null;

    if (valores.getFotoPerfil == null) {
      return alert('La foto es necesaria');
    }
    if (_tipoDeDocumento == "Tipo de Documento") {
      return alert('el campo Tipo de Documento es necesario.');
    }
    if (_tipoDeVehiculo == "Tipo de Vehiculo") {
      return alert('el campo Tipo de Vehiculo es necesario.');
    }
    formKey.currentState.save();
    valores.guardarTipoDeVehiculo = valoresv['$_tipoDeVehiculo'].toInt();
    Navigator.of(context).pushNamed('SiguientePagCrearRepartidor');
  }

  alert(String texto) {
    return alerta(
      context,
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
