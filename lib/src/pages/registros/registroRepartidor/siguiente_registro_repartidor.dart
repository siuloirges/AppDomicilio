import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/pages/registros/model/UsuarioModel.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/providers/adjuntarProviders.dart';
// import 'package:traelo_app/src/pages/registros/registroRepartidor/registro_repartidor.dart';

import 'package:traelo_app/src/utils/Global.dart';

class SiguienteRegistroRepartidor extends StatefulWidget {
  @override
  _SiguienteRegistroRepartidorState createState() =>
      _SiguienteRegistroRepartidorState();
}

class _SiguienteRegistroRepartidorState
    extends State<SiguienteRegistroRepartidor> {

  File imagenCCTrasera;
  File imagenCCDelantera;
  File perfilImage;
  File perfilImage2;
  File perfilImage3;
  File perfilImag4e;
  File perfilIma5ge;

  MantenerEstadoRepartidorProvider guardarEstadoRepartidor;
  // AdjuntarTargetaDePropiedadProvider adjuntarTargetaDePropiedadProvider;
  // AdjuatarFotosVehiculosProvider adjuatarFotosVehiculosProvider;
  // GuardarFotosDocIdProvider guardarFotosDocIdProvider;

  // RegistroRepartidorProvider registroRepartidorProvider;

  UsuarioProvider usuarioProvider;
  Size size;
  @override
  Widget build(BuildContext context) {
     size = MediaQuery.of(context).size;
    guardarEstadoRepartidor = Provider.of<MantenerEstadoRepartidorProvider>(context);
    // adjuntarTargetaDePropiedadProvider = Provider.of<AdjuntarTargetaDePropiedadProvider>(context);
    // adjuatarFotosVehiculosProvider = Provider.of<AdjuatarFotosVehiculosProvider>(context);
    // guardarFotosDocIdProvider = Provider.of<GuardarFotosDocIdProvider>(context);

    // registroRepartidorProvider = Provider.of<RegistroRepartidorProvider>(context);
    usuarioProvider = Provider.of<UsuarioProvider>(context);

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
          children: <Widget>[siguienteRegistroRepartidor(context)],
        ),
      ),
    );
  }

  Widget siguienteRegistroRepartidor(BuildContext context) {
    
    
    Orientation orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.085),
          Text(
            'Documentación',
            style: TextStyle(
                color: verde,
                fontWeight: FontWeight.bold,
               fontSize: orientation == Orientation.portrait
                    ? size.height * 0.017
                    : size.height * 0.030,),
          ),
          SizedBox(height: size.height * 0.085),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container( 
             decoration:guardarEstadoRepartidor.getDocIdParteDelantera!=null&&guardarEstadoRepartidor.getDocIdParteDelantera!=null? ShapeDecoration(shape: RoundedRectangleBorder(side: BorderSide(color: verde),borderRadius: BorderRadius.circular(10))):null,
             
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top:10.0),
                   child: Text(guardarEstadoRepartidor.getDocIdParteDelantera!=null&&guardarEstadoRepartidor.getDocIdParteDelantera!=null?'Imagenes Cargadas Correctamente':'Tap para cargar imagenes',style: TextStyle(color:verde,fontWeight: FontWeight.bold),),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 10.0,left: 10,right: 10),
                   child: TextFormField(

                      onTap: () {
                        // adjuntar(context: context, doc: "Documento de identidad");
                        Navigator.of(context).pushNamed('AdjuntarId');
                      },
                      decoration: InputDecoration(
                          labelText: "Documento de identidad - Ambos lados",
                          hintText: "Adjunte imagenes",
                          suffixIcon: Icon(Icons.camera_alt))),
                 ),
               ],
             ),
           ),
         ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container( 
           decoration:guardarEstadoRepartidor.getTargetaDePropiedadFrontal!=null&&guardarEstadoRepartidor.getTargetaDePropiedadTrasera!=null? ShapeDecoration(shape: RoundedRectangleBorder(side: BorderSide(color: verde),borderRadius: BorderRadius.circular(10))):null,
           
           child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top:10.0),
                   child: Text(guardarEstadoRepartidor.getTargetaDePropiedadFrontal!=null&&guardarEstadoRepartidor.getTargetaDePropiedadTrasera!=null?'Imagenes Cargadas Correctamente':'Tap para cargar imagenes',style: TextStyle(color:verde,fontWeight: FontWeight.bold),),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 10.0,left: 10,right: 10),
                   child: TextFormField(
              
                onTap: () {
                  Navigator.of(context).pushNamed('AdjuntarTargetaDePropiedad');
                },
                decoration: InputDecoration(
                    labelText: "Tarjeta de propiedad - Ambos lados",
                    hintText: "Adjunte imagenes",
                    suffixIcon: Icon(Icons.camera_alt))),
                 ),
               ],
           ),
         ),
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container( 
           decoration:guardarEstadoRepartidor.getSoatParteFrontal!=null&&guardarEstadoRepartidor.getSoatParteTrasera!=null? ShapeDecoration(shape: RoundedRectangleBorder(side: BorderSide(color: verde),borderRadius: BorderRadius.circular(10))):null,
           
           child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top:10.0),
                   child: Text(guardarEstadoRepartidor.getSoatParteFrontal!=null&&guardarEstadoRepartidor.getSoatParteTrasera!=null?'Imagenes Cargadas Correctamente':'Tap para cargar imagenes',style: TextStyle(color:verde,fontWeight: FontWeight.bold),),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 10.0,left: 10,right: 10),
                   child: TextFormField(
              onTap: () {
                Navigator.of(context).pushNamed('AdjuntarSoat');
              },
              decoration: InputDecoration(
                  labelText: "SOAT - Ambos lados",
                  hintText: 'Adjunte imagenes',
                  suffixIcon: Icon(Icons.camera_alt))),
                 ),
               ],
           ),
         ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container( 
           decoration:guardarEstadoRepartidor.getVehiculoPrimerAngulo!=null&&guardarEstadoRepartidor.getVehiculoSegundoAngulo!=null? ShapeDecoration(shape: RoundedRectangleBorder(side: BorderSide(color: verde),borderRadius: BorderRadius.circular(10))):null,
           
           child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top:10.0),
                   child: Text(guardarEstadoRepartidor.getVehiculoPrimerAngulo!=null&&guardarEstadoRepartidor.getVehiculoSegundoAngulo!=null?'Imagenes Cargadas Correctamente':'Tap para cargar imagenes',style: TextStyle(color:verde,fontWeight: FontWeight.bold),),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 10.0,left: 10,right: 10),
                   child: TextFormField(
              onTap: () {
                Navigator.of(context).pushNamed('AdjuntarFotosDeVehiculo');
              },
              decoration: InputDecoration(
                  labelText: "Fotografías del Vehículo",
                  hintText: "Adjunte imagenes",
                  suffixIcon: Icon(Icons.camera_alt))),
                 ),
               ],
           ),
         ),
            ),
          SizedBox(height:20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
             
              Container(
                height: orientation == Orientation.portrait
                    ? size.height * 0.070
                    : size.height * 0.125 ,
          width: orientation == Orientation.portrait
                    ? size.width * 0.35
                    : size.width * 0.20,
                child: RaisedButton(
                    child: Text(
                      'Cancelar',
                      style:
                          TextStyle(fontSize:orientation == Orientation.portrait
                    ? size.height * 0.02
                    : size.height * 0.030, color: verde),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: amarillo,
                    elevation: 0.0,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
               Container(
                height: orientation == Orientation.portrait
                    ? size.height * 0.070
                    : size.height * 0.125 ,
                width: orientation == Orientation.portrait
                    ? size.width * 0.35
                    : size.width * 0.20,
                  child: RaisedButton(
                      child: Text(
                        "Registrarse",
                        style: TextStyle(
                           fontSize: orientation == Orientation.portrait
                    ? size.height * 0.02
                    : size.height * 0.030, 
                        color: verde,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: amarillo,
                    elevation: 0.0,
                    onPressed: () {submit(context);}),
              ),
            ],
          ),
            
        ],
      ),
    );
  }
  submit(context)async{
    load(context);
    if(guardarEstadoRepartidor.getDocIdParteDelantera!=null&&guardarEstadoRepartidor.getDocIdParteTrasera!=null&&guardarEstadoRepartidor.getTargetaDePropiedadFrontal!=null&&guardarEstadoRepartidor.getTargetaDePropiedadTrasera!=null&&guardarEstadoRepartidor.getSoatParteFrontal!=null&&guardarEstadoRepartidor.getSoatParteTrasera!=null&&guardarEstadoRepartidor.getVehiculoPrimerAngulo!=null&&guardarEstadoRepartidor.getVehiculoSegundoAngulo!=null){
      usuarioProvider.deleteResp();
     dynamic _respuesta = await usuarioProvider.postUsuario(
     context: context,usuario: UsuarioModel(

      rol: 'repartidor',
      urlFotoPerfil: guardarEstadoRepartidor.getFotoPerfil!=null?base64Encode(guardarEstadoRepartidor.getFotoPerfil.readAsBytesSync()):'',
      nombre: guardarEstadoRepartidor.getNombre.toString(),
      tipoDocumento: guardarEstadoRepartidor.gettipoDocumento,
      numeroDocumento: int.parse(guardarEstadoRepartidor.getDocumento),
      telefono: int.parse(guardarEstadoRepartidor.getTelefono),
      email: guardarEstadoRepartidor.getCorreo.toString(), 
      password: guardarEstadoRepartidor.getcontrasena.toString(),

      tipoVehiculo: guardarEstadoRepartidor.gettipoDeVehiculo,
      placaVehiculo: guardarEstadoRepartidor.getplacaDeVehiculo.toString(),

      fotoDocumentoIdentidad1: guardarEstadoRepartidor.getDocIdParteDelantera!=null?base64Encode(guardarEstadoRepartidor.getDocIdParteDelantera.readAsBytesSync()):'',
      fotoDocumentoIdentidad2: guardarEstadoRepartidor.getDocIdParteTrasera!=null?base64Encode(guardarEstadoRepartidor.getDocIdParteTrasera.readAsBytesSync()):'',

      fotoTargetaPropiedad1:guardarEstadoRepartidor.getTargetaDePropiedadFrontal!=null?base64Encode(guardarEstadoRepartidor.getTargetaDePropiedadFrontal.readAsBytesSync()):'',
      fotoTargetaPropiedad2:guardarEstadoRepartidor.getTargetaDePropiedadTrasera!=null?base64Encode(guardarEstadoRepartidor.getTargetaDePropiedadTrasera.readAsBytesSync()):'',

      fotoSoat1: guardarEstadoRepartidor.getSoatParteFrontal!=null?base64Encode(guardarEstadoRepartidor.getSoatParteFrontal.readAsBytesSync()):'',
      fotoSoat2: guardarEstadoRepartidor.getSoatParteTrasera!=null?base64Encode(guardarEstadoRepartidor.getSoatParteTrasera.readAsBytesSync()):'',

      fotoVehiculo1:guardarEstadoRepartidor.getVehiculoPrimerAngulo!=null?base64Encode(guardarEstadoRepartidor.getVehiculoPrimerAngulo.readAsBytesSync()):'',
      fotoVehiculo2: guardarEstadoRepartidor.getVehiculoSegundoAngulo!=null?base64Encode(guardarEstadoRepartidor.getVehiculoSegundoAngulo.readAsBytesSync()):'',

     ),
   );

    if(_respuesta['message']=="false"){
      
    //  Navigator.pop(context);
     print(_respuesta.toString()+'Errores del rejistro repartidor'); 
     dynamic res = json.encode(_respuesta);

     print(res);
     var respModel = errorsFormModelFromJson(res);
     List<Widget> errors=[];
     respModel.errors.forEach((key, value) {

      var index=errors.length/2;
      errors..add(Row(
        children: [
          CircleAvatar(radius: 15,backgroundColor: amarillo,child: Center(child: Text('${index.toString().replaceAll(new RegExp(r'.0'), '')}',style: TextStyle(color:verde,fontWeight: FontWeight.bold),),),),
          Container(
            width: size.width/2,
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(
                 value.join(),
                 overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ))..add(Divider());
            
    
    });

   return  alerta(context,contenido:Column(children: errors,));
    
    }

    if(_respuesta['message']=="true"){

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      guardarEstadoRepartidor.guardarNombre = null;
      guardarEstadoRepartidor.guardarTipoDocumento = null;
      guardarEstadoRepartidor.guardarDocumento =null;
      guardarEstadoRepartidor.guardarTelefono = null;
      guardarEstadoRepartidor.guardarCorreo = null;
      guardarEstadoRepartidor.guardarContrasena = null;
      guardarEstadoRepartidor.guardarConfirmarContrasena = null;
      guardarEstadoRepartidor.guardarTipoDeVehiculo = null;
      guardarEstadoRepartidor.guardarPlaca = null;

      guardarEstadoRepartidor.setFotoPerfil = null;
      guardarEstadoRepartidor.setDocIdParteTrasera = null;
      guardarEstadoRepartidor.setIdParteDelantera = null;
      guardarEstadoRepartidor.setTargetaDePropiedadFrontal = null;
      guardarEstadoRepartidor.setTargetaDePropiedadTrasera = null;
      guardarEstadoRepartidor.setSoatParteDelantera = null;
      guardarEstadoRepartidor.setSoatParteTrasera = null;
      guardarEstadoRepartidor.setVhiculoPrimerAngulo = null;
      guardarEstadoRepartidor.setVehiculoSegundoAngulo = null;


      // guardarEstadoRepartidor.ge
     

    return  alerta(context,contenido: Text('Tu usuario se ha creado correctamente.',style: TextStyle(color: Colors.grey),), );

 
  }


    }else{
     return alerta(context,code: false,contenido: 'Debe cargar todas las fotos');
    }
  //  dynamic fotoPerfil;
    // if(guardarEstadoRepartidor.getFotoPerfil!=null){
    //  fotoPerfil =
    // }
    //  print('Imagen_base_64: '+fotoPerfil);
    
     
  }

  
 
}
