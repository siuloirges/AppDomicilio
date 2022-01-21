import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/pages/registros/model/AliadoModel.dart';
// import 'package:traelo_app/src/pages/registros/model/UsuarioModel.dart';
import 'package:traelo_app/src/pages/registros/registro%20aliado/providers/guardarEstadoAliadoProvider.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class PrimerRegistroAliado extends StatefulWidget {
  @override
  _PrimerRegistroAliadoState createState() => _PrimerRegistroAliadoState();
}

class _PrimerRegistroAliadoState extends State<PrimerRegistroAliado> {

  Size size;
  // String _vista = 'Tipo de Documento';
  GuardarEstadoAliadoProvider guardarEstado;
  TextEditingController nombreController = new TextEditingController();
  TextEditingController razonSocialController = new TextEditingController();
  TextEditingController nitController = new TextEditingController();

  FocusNode nombreFocus = new FocusNode();
  FocusNode razonSocialFocus = new FocusNode();
  FocusNode nitFocus = new FocusNode();

  FocusNode confirmarContrasenaFocus = new FocusNode();
  var formKey = GlobalKey<FormState>();
  Validaciones validar = new Validaciones();

  // File perfilImage;
  bool mostrar = true;
  UsuarioProvider usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    guardarEstado = Provider.of<GuardarEstadoAliadoProvider>(context);
    size = MediaQuery.of(context).size;

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
                crearImagenPerfil(context),
                crearImagen(context),
                crearNombre(),
                SizedBox(height: size.height * 0.03),
                crearRazonSocial(),
                SizedBox(height: size.height * 0.03),
                crearNit(),
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
            onChanged:(value) => guardarEstado.setNombreAliado = value,
            focusNode: nombreFocus,
            initialValue: guardarEstado.getNombreAliado,
            onSaved: (value) => guardarEstado.setNombreAliado = value,
            validator: (value) => validar.validateName(value),
            decoration: InputDecoration(hintText: 'Nombre'),
            onFieldSubmitted: (value) {
              razonSocialFocus.requestFocus();
            },

          ),
        ),
      ],
    );
  }

    
  Widget crearImagenPerfil(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: ShapeDecoration(  
         color: gris,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Row(
                children: [Text('Alto: 180px Ancho: 180px',textAlign: TextAlign.start,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)],
              ),
              Padding(
                padding: const EdgeInsets.only(top:30),
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: verdeClaro, borderRadius: BorderRadius.circular(100)),
                      width: 165,
                      height: 165,
                      child: guardarEstado.getFotoPerfilAliado != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                  fit: BoxFit.cover, image: FileImage(guardarEstado.getFotoPerfilAliado)),
                            )
                          : null),
                ),
              ),
              guardarEstado.getFotoPerfilAliado != null?Padding(
                padding: const EdgeInsets.only(top:30.0),
                child: Center(
                              child: IconButton(
                                alignment: Alignment.center,
                                iconSize: 1,
                                icon: IconButton(icon:Icon(Icons.highlight_remove_rounded,color: blanco,),onPressed: (){
                              setState(() {
                               guardarEstado.setFotoPerfilAliado = null;
                              });
                          },), onPressed: null),
                            ),
              ):Container(),
         Padding(
           padding: const EdgeInsets.only(top:30.0),
           child: Center(
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
                          onpressaddImage(context,guardarEstado.getFotoPerfilAliado);
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
                ),
         )
            ],
          ),
        ),
      ),
    );
  }


  Widget crearImagen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: ShapeDecoration(
          color: gris,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(children: [Text('Alto: 180px Ancho: 180px',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)],),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top:25.0),
                child: Center(
                  child: Container(

                      decoration: BoxDecoration(
                          color: verdeClaro, borderRadius: BorderRadius.circular(10)),
                      width: size.width,
                      height: 165,
                      child: guardarEstado.getFotoPortadaAliado != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                  fit: BoxFit.cover, image: FileImage(guardarEstado.getFotoPortadaAliado)),
                            )
                      :null 
                  
                  ),
                ),
              ),
            guardarEstado.getFotoPerfilAliado != null?  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 165,
                    ),
                    RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                        onpressaddImage(context,guardarEstado.getFotoPortadaAliado);
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
              ):Container(),
              guardarEstado.getFotoPortadaAliado != null?Row(
               mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top:15.0),
                                  child: IconButton(
                                    alignment: Alignment.center,
                                    iconSize: 1,
                                    icon: IconButton(icon:Icon(Icons.highlight_remove_rounded,color: blanco,),onPressed: (){
                                  setState(() {
                                   guardarEstado.setFotoPortadaAliado = null;
                                  });
                            },), onPressed: null),
                                ),
                              ),
                ],
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget crearRazonSocial() {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Razon social'),
        Container(
          width: size.width > 450 ? 440 : size.width,
          child: TextFormField(
             onChanged:(value) => guardarEstado.setRazonSocial = value,
            focusNode: razonSocialFocus,
            initialValue: guardarEstado.getRazonSocial,
            onSaved: (value) => guardarEstado.setRazonSocial = value,
            // controller: razonSocialController,
            //  validator: (value) => validar.isNumeric( ),
            // validator: (value) => validar.validateName(value),
            decoration: InputDecoration(hintText: 'Nombre'),
            onFieldSubmitted: (value) {
              nitFocus.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget crearNit() {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Numero de Nit'),
        Container(
          width: size.width > 450 ? 440 : size.width,
          child: TextFormField(
            onChanged:(value) => guardarEstado.setNit = value,
            initialValue: guardarEstado.getNit,
            onSaved: (value) => guardarEstado.setNit = value,
            focusNode: nitFocus,
            keyboardType: TextInputType.number,
            // controller: nitController,
            // keyboardType:,
            validator: (value) => validar.validateNumerico(value),
            decoration: InputDecoration(hintText: 'Numero'),
            onFieldSubmitted: (value) {},
          ),
        ),
      ],
    );
  }

  void onpressaddImage(BuildContext context,File foto) {
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
                          if (foto == guardarEstado.getFotoPerfilAliado) {
                            cargarImageCamera(foto);
                            // Navigator.pop(context);
                          } else if (foto == guardarEstado.getFotoPortadaAliado) {
                            cargarImageCamera2(foto);
                            // Navigator.pop(context);
                          }
                          // cargarImageCamera();
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
                          if (foto == guardarEstado.getFotoPerfilAliado) {
                            cargarImageGalery(foto);
                            // Navigator.pop(context);
                          } else if (foto == guardarEstado.getFotoPortadaAliado) {
                            cargarImageGalery2(foto);
                            // Navigator.pop(context);
                          }
                          Navigator.pop(context);
                        })),
              ],
            ),
          );
        });
  }

  Future cargarImageGalery(foto) async {
    var tempImage = await ImagePicker.pickImage(
        maxHeight: 180, maxWidth: 180, source: ImageSource.gallery);
    setState(() {
      guardarEstado.setFotoPerfilAliado = tempImage;
    });
  }

  Future cargarImageCamera(foto) async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight: 180, maxWidth: 180, source: ImageSource.camera);

    setState(() {
     guardarEstado.setFotoPerfilAliado = tempImageCamera;
    });
  }
  Future cargarImageGalery2(foto) async {
    var tempImage = await ImagePicker.pickImage(
        maxHeight:566 , maxWidth: 180, source: ImageSource.gallery);
    setState(() {
      guardarEstado.setFotoPortadaAliado = tempImage;
    });
  }

  Future cargarImageCamera2(foto) async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight:566 , maxWidth: 180, source: ImageSource.camera);

    setState(() {
       guardarEstado.setFotoPortadaAliado = tempImageCamera;
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
                Navigator.of(context).pushNamed('');
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
                "Siguiente",
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
              onPressed: () async {

                if (!formKey.currentState.validate()) {
                  return null;
                }

                if( guardarEstado.getFotoPerfilAliado==null){
                 return alerta(context,code: false,contenido: 'El logo del aliado es necesario');
               } 
               
               if( guardarEstado.getFotoPortadaAliado==null){
                 return alerta(context,code: false,contenido: 'La foto de portada es necesaria');
               }
               
                // load(context);
                

                // print('id aliado ' + usuarioProvider.getIdAliado.toString());
                
                  load(context);
                  usuarioProvider.obetenerDatos(context,
                      ruta: 'RegistroAliado', table: 'tipo_documentos');
             


                // Navigator.pushNamed(context, 'RegistroAliado',);
                //  load(context);
              }),
        ),
      ],
    );
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
          overflow: TextOverflow.clip,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        )),
      ),
    );
  }
}
