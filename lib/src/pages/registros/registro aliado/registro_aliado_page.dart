// import 'dart:convert';
import 'dart:convert';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/pages/registros/model/AliadoModel.dart';
import 'package:traelo_app/src/pages/registros/model/UsuarioModel.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/pages/registros/registro%20aliado/providers/guardarEstadoAliadoProvider.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class RegistroAliado extends StatefulWidget {
  @override
  _RegistroAliadoState createState() => _RegistroAliadoState();
}

class _RegistroAliadoState extends State<RegistroAliado> {
  GuardarEstadoAliadoProvider guardarEstado;
  Size size;
  String _vista = 'Tipo de Documento';

  // TextEditingController nombreController = new TextEditingController();
  // TextEditingController documentoController = new TextEditingController();
  // TextEditingController telefonoController = new TextEditingController();
  // TextEditingController correoController = new TextEditingController();
  // TextEditingController contrasenaController = new TextEditingController();
  // TextEditingController confirmarContrasenaController = new TextEditingController();

  FocusNode nombreFocus = new FocusNode();
  FocusNode documentFocus = new FocusNode();
  FocusNode telefonoFocus = new FocusNode();
  FocusNode correoFocus = new FocusNode();
  FocusNode contrasenaFocus = new FocusNode();
  FocusNode confirmarContrasenaFocus = new FocusNode();
  var formKey = GlobalKey<FormState>();
  Validaciones validar = new Validaciones();

  // File perfilImage;
  bool mostrar = true;
  UsuarioProvider usuarioProvider;

  List<int> id;
  List<String> nombres;
  Map<String, dynamic> element;

  Map<String, int> valores = {};
  @override
  Widget build(BuildContext context) {
    guardarEstado = Provider.of<GuardarEstadoAliadoProvider>(context);
    usuarioProvider = Provider.of<UsuarioProvider>(context);
    print("id initState ${usuarioProvider.getIdAliado}");
    element = ModalRoute.of(context).settings.arguments;

    id = element['id'];
    nombres = element['nombre'];
    size = MediaQuery.of(context).size;
    if (valores.isEmpty) {
      element['modelo'].data.forEach((element) {
        valores.addAll({"${element.nombre}": element.id});
      });
      print("ok" + valores.toString());
    }

    // if(usuarioProvider.getListaTipoDocumento.length == 0){
    //   usuarioProvider.refreshDocumento();
    //  usuarioProvider.obetenerTipoDocumento();
    // }
    //  print( user.getRespuesta);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 241, 1, 1),
        title: Text(
          'Registro Aliado',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _drowDow(),
                ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nombre'),
        Container(
          width: size.width > 450 ? 440 : size.width,
          child: TextFormField(
            focusNode: nombreFocus,
            // controller: nombreController,
            initialValue: guardarEstado.getNombre,
            onChanged: (value) => guardarEstado.setNombre = value,
            validator: (value) => validar.validateName(value),
            decoration: InputDecoration(hintText: 'Tu nombre'),
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
            // controller: documentoController,
            initialValue: guardarEstado.getDocumento,
            onChanged: (value) => guardarEstado.guardarDocumento = value,
            // validator: (value) => validar.validateName(value),
            keyboardType: TextInputType.number,
            //  validator: (value) =>validar.isNumeric( ),
            validator: (value) => validar.validateNumerico(value),
            decoration: InputDecoration(hintText: 'Documento de identidad'),
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
            initialValue: guardarEstado.getTelefono,
            onChanged: (value) => guardarEstado.guardarTelefono = value,
            // controller: telefonoController,
            // keyboardType:,
            validator: (value) => validar.validateNumerico(value),
            decoration: InputDecoration(hintText: 'Numero de telefono'),
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
            initialValue: guardarEstado.getCorreo,
            onChanged: (value) => guardarEstado.guardarCorreo = value,
            focusNode: correoFocus,
            // controller: correoController,
            validator: (value) => validar.validateEmail(value),
            decoration: InputDecoration(hintText: 'Tucorre@ejemplo.com'),
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
            // controller: contrasenaController,
            initialValue: guardarEstado.getcontrasena,

            onChanged: (value) => guardarEstado.guardarContrasena = value,
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
            // controller: confirmarContrasenaController,
            initialValue: guardarEstado.getConfirmarContrasena,
            onChanged: (value) =>guardarEstado.guardarConfirmarContrasena = value,
            validator: (value) => validar.validateRepetPassword(guardarEstado.getcontrasena, guardarEstado.getConfirmarContrasena),
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
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: Container(
              decoration: BoxDecoration(
                  color: verdeClaro, borderRadius: BorderRadius.circular(100)),
              width: 165,
              height: 165,
              child: guardarEstado.getFotoPerfil != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                          fit: BoxFit.cover,
                          image: FileImage(guardarEstado.getFotoPerfil)),
                    )
                  : null),
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
        guardarEstado.getFotoPerfil != null
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
                          guardarEstado.setFotoPerfil = null;
                        });
                      },
                    ),
                    onPressed: null),
              )
            : Container(),
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
      guardarEstado.setFotoPerfil = tempImage;
    });
  }

  Future cargarImageCamera() async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.camera);

    setState(() {
      guardarEstado.setFotoPerfil = tempImageCamera;
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
              onPressed: () {Navigator.pop(context);}),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          height: size.width > 450 ? 50 : size.height * 0.070,
          width: size.width > 450 ? 200 : size.width * 0.35,
          child: RaisedButton(
              child: Text(
                "Registrarse",
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
              onPressed: ()=> submit()),
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
    // cargando 
    load(context);

    if(usuarioProvider.getIdAliado == null){
      
      await usuarioProvider.postAliado(
      context: context,
      usuario: AliadoModel(
          nit: guardarEstado.getNit,
          nombre: guardarEstado.getNombreAliado,
          razonSocial: guardarEstado.getRazonSocial,
          urlFotoPerfil:guardarEstado.getFotoPerfilAliado!=null?base64Encode(guardarEstado.getFotoPerfilAliado.readAsBytesSync()):'no',
        
          urlFotoPortada: guardarEstado.getFotoPortadaAliado!=null?base64Encode(guardarEstado.getFotoPortadaAliado.readAsBytesSync()):'no',
      ),
     );

     print('----------Aliado----------');
    }
    // intentando postear el Aliado
  

    
    if (usuarioProvider.getIdAliado != null) {

      dynamic _respuesta = await usuarioProvider.postUsuario(
        context: context,
        usuario: UsuarioModel(

            urlFotoPerfil:guardarEstado.getFotoPerfil!=null?base64Encode(guardarEstado.getFotoPerfil.readAsBytesSync()):'',
            rol: 'aliado',
            nombre: guardarEstado.getNombre,
            email: guardarEstado.getCorreo,
            telefono: int.parse(guardarEstado.getTelefono),
            password: guardarEstado.getcontrasena,
            tipoDocumento: valores['$_vista'],
            numeroDocumento: int.parse(guardarEstado.getDocumento),
            idAliado: int.parse(usuarioProvider.getIdAliado.toString())
            
        ),
      );

      if (_respuesta['message'] == "false") {
        Navigator.pop(context);
        print(_respuesta.toString() + '---------------------------------Bad');
        dynamic res = json.encode(_respuesta);

        print(res);
        var respModel = errorsFormModelFromJson(res);
        List<Widget> errors = [];

        if (_respuesta['errors'].length != 0) {
        respModel.errors.forEach((key, value) {
          var index = errors.length / 2;
          errors..add(
              
              Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: amarillo,
                  child: Center(
                    child: Text(
                      '${index.toString().replaceAll(new RegExp(r'.0'), '')}',
                      style:
                          TextStyle(color: verde, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: size.width / 2.2,
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
      }

      return  alerta(
          context,
          contenido: Column(
            children: errors??"Error: error con el servidor, no se pudo crear el usuario",
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
        usuarioProvider.setIdeAliado=null;
         Navigator.pop(context);
        //  Navigator.pop(context);
         Navigator.pop(context);
         Navigator.pop(context);
        guardarEstado.setFotoPerfilAliado = null;
        guardarEstado.setFotoPortadaAliado = null;
        guardarEstado.setNombreAliado = null;
        guardarEstado.setRazonSocial = null;
        guardarEstado.setNit = null;

        guardarEstado.setFotoPerfil = null;
        guardarEstado.setNombre = null;
        guardarEstado.guardarDocumento = null;
        guardarEstado.guardarTelefono = null;
        guardarEstado.guardarCorreo = null;
        guardarEstado.guardarContrasena = null;
        guardarEstado.guardarConfirmarContrasena = null;

        return alerta(
          context,
          contenido: Text(
            'Tu usuario se ha creado correctamente.',
            style: TextStyle(color: Colors.grey),
          ),
         
        );
      }

      // Future.delayed(Duration(seconds: 5));
      //  return  alert('${usuarioProvider.getRespuesta}');
      // await usuarioProvider.getRespuesta;

      //  return alert('$v');

      //  return showDialog(context: context,builder:(context){return AlertDialog(  content:SingleChildScrollView(child: Text(user.getRespuesta  )) , );  });

    }
      // print('1111111111111111111111111111111111111111111111111111111111111111111111111111');
  }


  checkForm(){
  

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
