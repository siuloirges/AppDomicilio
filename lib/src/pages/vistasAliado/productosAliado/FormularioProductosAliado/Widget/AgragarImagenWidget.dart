

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traelo_app/src/utils/Global.dart';

class AddImagen extends StatefulWidget {
   
   AddImagen({
   var foto,
  });
  // const Imagen({Key key}) : super(key: key);
  @override
  _AddImagen createState() => _AddImagen();
}

class _AddImagen extends State<AddImagen> {
  

 File foto;
 

  var size;

  var orientacion;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: crearImagen(context,),
    );
  }

  Widget crearImagen(BuildContext context,) {
    
    size = MediaQuery.of(context).size;
    orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: verdeClaro,
                      borderRadius: BorderRadius.circular(100)),
                  width:size.width<140? size.width * 0.6 :140,
                  height:size.width<140?  size.width * 0.6:140,
                  child: foto != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                              fit: BoxFit.cover, image: FileImage(foto)),
                        )
                      : null),
              Container(
                  color: Colors.transparent,
                  width: size.width * 0.35,
                  height:size.height * 0.025
              )
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 115,
              ),
              Container(
                width:size.width <500 ? 168:168
                    ,
                height: 28
                   ,
                child: RaisedButton(
                  color: verde,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    onpressaddImage(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload,
                        color: Colors.white,
                        size:15 ,
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text( 'Subir foto',style: TextStyle(color: Colors.white, fontSize:15, letterSpacing: 1.5)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                  style:
                      TextStyle(fontSize: size.width * 0.038, color: verde),
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
      foto = tempImage;
    });
  }

  Future cargarImageCamera() async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight: 480, maxWidth: 640, source: ImageSource.camera);

    setState(() {
      foto = tempImageCamera;
    });
  }
}