// import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/providers/adjuntarProviders.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class RegistroRepartidorPage extends StatefulWidget {
  @override
  _RegistroRepartidorPage createState() => _RegistroRepartidorPage();
}

class _RegistroRepartidorPage extends State<RegistroRepartidorPage> {
  bool o = true;

  MantenerEstadoRepartidorProvider valores;

  TextEditingController confirmarContrasenaController =
      new TextEditingController();

  FocusNode nombreFocus = new FocusNode();
  FocusNode documentFocus = new FocusNode();
  FocusNode telefonoFocus = new FocusNode();
  // FocusNode ntiFocus = new FocusNode();
  FocusNode correoFocus = new FocusNode();
  FocusNode tipoVehiculoFocus = new FocusNode();
  FocusNode placaFocus = new FocusNode();
  FocusNode contrasenaFocus = new FocusNode();
  FocusNode confirmarContrasenaFocus = new FocusNode();
  var formKey = GlobalKey<FormState>();
  Validaciones validar = new Validaciones();
  String _tipoDeDocumento = 'Tipo de Documento';
  String _tipoDeVehiculo = 'Tipo de Vehiculo';
  // File perfilImage;
  bool mostrar = true;
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        title: Text(
          "Registro Repartidor",
          style: TextStyle(
            color: verde,
            fontSize: 15.0,
          ),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[registroClientes(context)],
        ),
      ),
    );
  }

  Widget registroClientes(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            crearImagen(context),
            SizedBox(height: size.height * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre'),
                TextFormField(
                  // initialValue:valores.getNombre ??'',
                  initialValue: valores.getNombre,
                  onSaved: (value) => valores.guardarNombre = value,
                  focusNode: nombreFocus,
                  validator: (value) => validar.validateName(value),
                  decoration: InputDecoration(hintText: 'Tu nombre'),
                  onFieldSubmitted: (value) {
                    documentFocus.requestFocus();
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            _drowDow(),
            SizedBox(height: size.height * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Documento'),
                TextFormField(
                  initialValue: valores.getDocumento,
                  onSaved: (value) => valores.guardarDocumento = value,
                  focusNode: documentFocus,
                  validator: (value) {
                    // if(value <  8 ){}
                    return validar.validateNumerico(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: 'Documento de identidad'),
                  onFieldSubmitted: (value) {
                    telefonoFocus.requestFocus();
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Telefono'),
                TextFormField(
                  // initialValue: telefono,
                  initialValue: valores.getTelefono,
                  onSaved: (value) => valores.guardarTelefono = value,
                  focusNode: telefonoFocus,
                  validator: (value) => validar.validateNumerico(value),
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: 'Tu numero de telefono'),
                  onFieldSubmitted: (value) {
                    correoFocus.requestFocus();
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Correo'),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: valores.getCorreo,
                  focusNode: correoFocus,
                  onSaved: (value) => valores.guardarCorreo = value,
                  validator: (value) => validar.validateEmail(value),
                  decoration: InputDecoration(hintText: 'tucorreo@ejemplo.com'),
                  onFieldSubmitted: (value) {
                    tipoVehiculoFocus.requestFocus();
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            _drowDowVehiculo(),
            SizedBox(height: size.height * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Placa de Vehiculo'),
                TextFormField(
                  initialValue: valores.getplacaDeVehiculo,
                  focusNode: placaFocus,
                  onSaved: (value) => valores.guardarPlaca = value,
                  validator: (value) => validar.validateGenerico(value),
                  decoration: InputDecoration(hintText: 'Placa'),
                  onFieldSubmitted: (value) {
                    contrasenaFocus.requestFocus();
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('contraseña'),
                TextFormField(
                    obscureText: o,
                    initialValue: valores.getcontrasena,
                    focusNode: contrasenaFocus,
                    validator: (value) => validar.validatePassword(value),
                    // keyboardType: TextInputType.number,
                    
                    onSaved: (value) => valores.guardarContrasena = value,
                    onChanged: (value) => valores.guardarContrasena = value,
                    decoration: InputDecoration(
                      // suffixIcon: IconButton(
                      //   icon: o == true
                      //       ? Icon(Icons.remove_red_eye)
                      //       : Icon(Icons.visibility_off),
                      //   onPressed: () {
                      //     setState(() {
                      //       o = !o;
                      //     });
                      //   },
                      // ),
                      hintText: "********",
                    )),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Confirmar contraseña'),
                TextFormField(
                  obscureText: o,
                  initialValue:valores.getConfirmarContrasena,
                    //  onSaved: (value) => valores.guardarContrasena = value,
                    onChanged: (value) =>
                        valores.guardarConfirmarContrasena = value,
                    focusNode: confirmarContrasenaFocus,
                    validator: (value) => validar.validateRepetPassword(
                        value, valores.getcontrasena),
                    // keyboardType: TextInputType.number,
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
                    )),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              height: 40,
              width: 150,
              child: RaisedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Siguiente",
                        style: TextStyle(
                          fontSize: 12,
                          color: verde,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: verde,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: amarillo,
                  elevation: 0.0,
                  onPressed: () {
                    submit();
                  }),
            )
          ],
        ),
      ),
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

  submit() {
    if (!formKey.currentState.validate()) return null;

    if (valores.getFotoPerfil==null ) {
      return alert('La foto es necesaria');
    }
    if (_tipoDeDocumento == "Tipo de Documento") {
      return alert('el campo Tipo de Documento es necesario.');
    }

    if (_tipoDeVehiculo == "Tipo de Vehiculo") {
      return alert('el campo Tipo de Vehiculo es necesario.');
    }

    formKey.currentState.save();
    valores.guardarTipoDocumento = valoresd['$_tipoDeDocumento'].toInt();
    valores.guardarTipoDeVehiculo = valoresv['$_tipoDeVehiculo'].toInt();
    Navigator.of(context).pushNamed('SiguienteRegistroRepartidor');
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
              child: valores.getFotoPerfil != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                          fit: BoxFit.cover,
                          image: FileImage(valores.getFotoPerfil)),
                    )
                  : null),
        ),
        valores.getFotoPerfil != null
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
                          valores.setFotoPerfil = null;
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
                              style: TextStyle(color: verde),
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
}

// class RegistroRepartidorProvider extends ChangeNotifier {

// }
