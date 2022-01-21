import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/providers/adjuntarProviders.dart';
import 'package:traelo_app/src/utils/Global.dart';

class AdjuntarDocumentoDeIdentidad extends StatefulWidget {
  @override
  _AdjuntarDocumentoDeIdentidadState createState() =>
      _AdjuntarDocumentoDeIdentidadState();
}

class _AdjuntarDocumentoDeIdentidadState
    extends State<AdjuntarDocumentoDeIdentidad> {
  MantenerEstadoRepartidorProvider fotos;

  // File delanteraImage;
  // File traseraImage;

  // File perfilImage;
  // File perfilImage2;

  @override
  Widget build(BuildContext context) {
    fotos = Provider.of<MantenerEstadoRepartidorProvider>(context);
    // traseraImage=fotos.getDocIdParteTrasera;
    // delanteraImage=fotos.getDocIdParteDelantera;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        title: Text(
          'Documento de identidad',
          style: TextStyle(color: verde),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      fotos.getDocIdParteTrasera == null
                          ? addImage(fotos.getDocIdParteTrasera)
                          : image(fotos.getDocIdParteTrasera),
                      ClipRRect(
                           borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20) ),
                          child: Container(
                              color: verde,
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                'Parte de atras',
                                style: TextStyle(color: Colors.white),
                              )))),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      fotos.getDocIdParteDelantera == null
                          ? addImage(fotos.getDocIdParteDelantera)
                          : image(fotos.getDocIdParteDelantera),
                      ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20) ),
                          child: Container(
                              color: verde,
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                'Parte de adelante',
                                style: TextStyle(color: Colors.white),
                              )))),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Container(
                        width: size.width,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            onPressed: () {Navigator.pop(context);},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload,
                                  color: verde,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Siguente', style: TextStyle(color: verde)),
                              ],
                            ),
                            color: amarillo),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget image(File foto) {
    final tamano = MediaQuery.of(context).size;
    return Container(
        child: Column(
      children: <Widget>[
        ClipRRect(
             borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20) ),
            child: GestureDetector(
                onTap: () {
                  onpressaddImage(foto);
                },
                child: Image.file(
                  foto,
                  height: tamano.height / 4,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ))),
      ],
    ));
  }

  Widget addImage(File foto) {
    
     Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
   
    final tamano = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onpressaddImage(foto);
      },
      child: Container(
        decoration:
            BoxDecoration(color: gris, borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20) ),),
        height: tamano.height / 4,
        width: double.infinity,
        child: Icon(
          Icons.add_a_photo,
          size: orientation == Orientation.portrait
                    ? size.width * 0.07
                    : size.width * 0.03,
          color: Colors.white,
        ),
      ),
    );
  }

  void onpressaddImage(File foto) {
    final tamano = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Seleccion',
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
                            borderRadius: BorderRadius.circular(50)),
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
                          if (foto == fotos.getDocIdParteTrasera) {
                            cargarImageCamera(foto);
                            Navigator.pop(context);
                          } else if (foto == fotos.getDocIdParteDelantera) {
                            cargarImageCamera2(foto);
                            Navigator.pop(context);
                          }
                        })),
                SizedBox(
                  width: tamano.height * 0.010,
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
                          if (foto == fotos.getDocIdParteTrasera) {
                            cargarImageGalery(foto);
                            Navigator.pop(context);
                          } else if (foto == fotos.getDocIdParteDelantera) {
                            cargarImageGalery2(foto);
                            Navigator.pop(context);
                          }
                        })),
              ],
            ),
          );
        });
  }


  Future cargarImageGalery(File foto) async {
    var tempImage = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.gallery);

    setState(() {
      fotos.setDocIdParteTrasera = tempImage;
    });
  }

  Future cargarImageCamera(File foto) async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.camera);

    setState(() {
      fotos.setDocIdParteTrasera = tempImageCamera;
    });
  }

  Future cargarImageGalery2(File foto) async {
    var tempImage = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.gallery);

    setState(() {
      fotos.setIdParteDelantera = tempImage;
    });
  }

  Future cargarImageCamera2(File foto) async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.camera);

    setState(() {
      fotos.setIdParteDelantera = tempImageCamera;
    });
  }
}


