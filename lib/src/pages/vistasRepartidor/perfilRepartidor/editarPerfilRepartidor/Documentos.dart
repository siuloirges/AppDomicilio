import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';

enum TiposDocumentos { docId1, docId2, tPropiedad1, tPropiedad2, fotoSoat1, fotoSoat2, fotoVehiculo1, fotoVehiculo2 }


class DocumentosPageRepartidor extends StatefulWidget {
  
  DocumentosPageRepartidor({Key key,}) : super(key: key,);
 
  @override
  _DocumentosPageRepartidorState createState() => _DocumentosPageRepartidorState();
}

class _DocumentosPageRepartidorState extends State<DocumentosPageRepartidor> {

  PeticionesHttpProvider _peticionesHttpProvider =new PeticionesHttpProvider(); 
  PreferenciasUsuario _pref = new PreferenciasUsuario();

  File docId1;
  File docId2;
  File tPropiedad1;
  File tPropiedad2;
  File fotoSoat1;
  File fotoSoat2;
  File fotoVehiculo1;
  File fotoVehiculo2;
  Size size;
 
  @override
  Widget build(BuildContext context) {
      size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro repartidor'),
      ),
       body: Padding(
         padding: const EdgeInsets.only(top:0.0,left: 8,right: 8,),
         child: Column(
           children: [
             Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                   children: [
                     addImage(nombreCampo:'Foto documento id delantera',fotoCampo:docId1,idTipoDocumento: TiposDocumentos.docId1,urlFoto: _pref.foto_documento_identidad_1 ),
                     addImage(nombreCampo:'Foto documento id trasera',fotoCampo:docId2,idTipoDocumento: TiposDocumentos.docId2,urlFoto: _pref.foto_documento_identidad_2 ),
                     addImage(nombreCampo:'Foto targeta Propiedad delantera',fotoCampo:tPropiedad1,idTipoDocumento: TiposDocumentos.tPropiedad1,urlFoto: _pref.foto_targeta_propiedad_1  ),
                     addImage(nombreCampo:'Foto targeta Propiedad trasera',fotoCampo: tPropiedad2,idTipoDocumento: TiposDocumentos.tPropiedad2,urlFoto: _pref.foto_targeta_propiedad_2),
                     addImage(nombreCampo:'Foto Soat 1',fotoCampo:fotoSoat1,idTipoDocumento: TiposDocumentos.fotoSoat1,urlFoto: _pref.foto_soat_1 ),
                     addImage(nombreCampo:'Foto Soat 2',fotoCampo: fotoSoat2,idTipoDocumento: TiposDocumentos.fotoSoat2,urlFoto: _pref.foto_soat_2),
                     addImage(nombreCampo:'Foto vehiculo primer angulo',fotoCampo:fotoVehiculo1,idTipoDocumento: TiposDocumentos.fotoVehiculo1,urlFoto: _pref.foto_vehiculo_1 ),
                     addImage(nombreCampo:'Foto vehiculo Segundo angulo',fotoCampo:fotoVehiculo2,idTipoDocumento: TiposDocumentos.fotoVehiculo2,urlFoto: _pref.foto_vehiculo_2 ),
                   ],
                ),
               ),
             ),
            _botonGuardar(context)
           ],
         ),
       ),
    );
  }
 
  Widget addImage({String urlFoto,String nombreCampo,File fotoCampo,TiposDocumentos idTipoDocumento}) {
    // print(idTipoDocumento);
    Orientation orientation = MediaQuery.of(context).orientation;
   
    final tamano = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
     
          return selectModoCargarImagen(context,idTipoDocumento:idTipoDocumento );
     
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // TextFormField(),
           fotoCampo==null?Container(
              decoration:BoxDecoration(color: gris, borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20) ),),
              height: size.height / 4,
              width: double.infinity,
              child: urlFoto ==''?Column(
                mainAxisAlignment:MainAxisAlignment.center ,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    size: orientation == Orientation.portrait
                    ? size.width * 0.07
                    : size.width * 0.03,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Tap aqui para cargar imagen', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)
                ],
              ):ClipRRect(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20) ),
              child:Image.network(storage+urlFoto,fit: BoxFit.cover, height: tamano.height / 4,)
             ),
           ):ClipRRect(
            //  decoration:BoxDecoration(color: gris, borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20) ),),
             borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20)   ),
             child:Image.file(fotoCampo,width: size.width,fit: BoxFit.cover,  height: tamano.height / 4, ),
           ),
            Container(
              child: Center(child: Text('$nombreCampo', style: TextStyle(color: Colors.white))),
              decoration:
                  BoxDecoration(color: verde, borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20) ),),
              height:20,
              width: double.infinity,
           
            ),
          ],
        ),
      ),
    );
  }

  cargarAndUbicarImagen({TiposDocumentos idTipoDocumento, bool camara = false})async{
   var imagen = await ImagePicker.pickImage(maxHeight: 720, maxWidth: 1280, source:camara==true? ImageSource.camera:ImageSource.gallery);
   switch (idTipoDocumento){
    case TiposDocumentos.docId1:setState(() {}); docId1 = imagen;break;
    case TiposDocumentos.docId2:setState(() {}); docId2 = imagen;break;
    case TiposDocumentos.tPropiedad1:setState(() {}); tPropiedad1 = imagen;break;
    case TiposDocumentos.tPropiedad2:setState(() {}); tPropiedad2 = imagen;break;
    case TiposDocumentos.fotoSoat1:setState(() {}); fotoSoat1 = imagen;break;
    case TiposDocumentos.fotoSoat2:setState(() {}); fotoSoat2 = imagen;break;
    case TiposDocumentos.fotoVehiculo1:setState(() {}); fotoVehiculo1 = imagen;break;
    case TiposDocumentos.fotoVehiculo2:setState(() {}); fotoVehiculo2 = imagen;break;
   }
  }

  void selectModoCargarImagen(BuildContext context,{ File foto,String texto,TiposDocumentos idTipoDocumento}) {
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                            Navigator.pop(context);
                            cargarAndUbicarImagen(idTipoDocumento:idTipoDocumento,camara: true);
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
                          Navigator.pop(context);
                          cargarAndUbicarImagen(idTipoDocumento:idTipoDocumento,);
                        })),
              ],
            ),
          );
        });
 }

 _botonGuardar(context){
   return Container(
    decoration:BoxDecoration(color: verde, borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10) ),),
     height: 75,
     child: RaisedButton(
       elevation: 0,
       highlightElevation: 0,
       color: Colors.transparent,
       shape: RoundedRectangleBorder( borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10) ),),
       onPressed: (){put(context);},child: Center(child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           
           Text('Guardar',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
           SizedBox(width: 10,),
           Icon(Icons.cloud_upload_sharp,color: Colors.white,)
         ],
       ))),
   );
 }

 put(context)async{

  load(context);
  Map _resp = await _peticionesHttpProvider.putMethod(
    context: context,
    table: 'user',
    token: _pref.token,
    id: int.parse(_pref.user_id),
    body: {
     "email":"${_pref.email}",
     "id":"${_pref.user_id}",
     "url_foto_perfil":"no",
     "foto_documento_identidad_1": docId1!=null?"${base64Encode(docId1.readAsBytesSync())}":"no",
     "foto_documento_identidad_2":docId2!=null?"${base64Encode(docId2.readAsBytesSync())}":"no",
     "foto_targeta_propiedad_1":tPropiedad1!=null?"${base64Encode(tPropiedad1.readAsBytesSync())}":"no",
     "foto_targeta_propiedad_2":tPropiedad2!=null?"${base64Encode(tPropiedad2.readAsBytesSync())}":"no",
     "foto_soat_1": fotoSoat1!=null?"${base64Encode(fotoSoat1.readAsBytesSync())}":"no",
     "foto_soat_2": fotoSoat2!=null?"${base64Encode(fotoSoat2.readAsBytesSync())}":"no",
     "foto_vehiculo_1":fotoVehiculo1!=null?"${base64Encode(fotoVehiculo1.readAsBytesSync())}":"no",
     "foto_vehiculo_2":fotoVehiculo2!=null?"${base64Encode(fotoVehiculo2.readAsBytesSync())}":"no",
    }
  );
  if( _resp['message']=='expiro'){
   Navigator.pop(context);
  }

 if( _resp['message']=='true'){

    docId1=null;
    docId2=null;
    tPropiedad1=null;
    tPropiedad2=null;
    fotoSoat1=null;
    fotoSoat2=null;
    fotoVehiculo1=null;
    fotoVehiculo2=null;
    size=null;
      //  var _josn = json.decode(_resp['resp']);
    _pref.foto_documento_identidad_1 = _resp['data']['foto_documento_identidad_1'];
    _pref.foto_documento_identidad_2 = _resp['data']['foto_documento_identidad_2'];
    _pref.foto_targeta_propiedad_1   = _resp['data']['foto_targeta_propiedad_1'];
    _pref.foto_targeta_propiedad_2   = _resp['data']['foto_targeta_propiedad_2'];
    _pref.foto_soat_1 = _resp['data']['foto_soat_1'];
    _pref.foto_soat_2 = _resp['data']['foto_soat_2'];
    _pref.foto_vehiculo_1 = _resp['data']['foto_vehiculo_1'];
    _pref.foto_vehiculo_2 = _resp['data']['foto_vehiculo_2'];


   Navigator.pop(context);
   Navigator.pop(context);

  //  print(_resp['data']['foto_documento_identidad_1']);
  //  print(_resp['data']['foto_documento_identidad_2']);
  //  print(_resp['data']['foto_targeta_propiedad_1']);
  //  print(_resp['data']['foto_targeta_propiedad_2']);
  //  print(_resp['data']['foto_soat_1']);
  //  print(_resp['data']['foto_soat_2']);
  //  print(_resp['data']['foto_vehiculo_1']);
  //  print(_resp['data']['foto_vehiculo_2']);

  return alerta(context,titulo: 'Exito',code: false,contenido: 'sus datos fueron guardados exitosamente');

   
 }
  
 if( _resp['message'] == 'false' ){
  Navigator.pop(context);
   return alerta(context,titulo: 'Error',code: false,contenido: 'Fallo al Actualizar usuario');

 }else{
   Navigator.pop(context);
    return alerta(context,titulo: 'Error',);
 }
 }

}