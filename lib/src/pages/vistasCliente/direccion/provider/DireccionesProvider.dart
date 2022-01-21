// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart'as http;
// import 'package:traelo_app/src/pages/vistasCliente/direccion/models/DireccionModel.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/models/GetDireccionModel.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/models/TipoDireccion.dart';
// import 'package:traelo_app/src/utils/Estilos.dart';


// class DireccionesProvider extends ChangeNotifier{

//   List<String>_listaTipoDirecciones=[];
//  Map<dynamic,dynamic> _respuesta = {'':''};
//   List<dynamic> _direcciones=[];

//   List<String> get getListaTipoDirecciones => _listaTipoDirecciones;
//   Map<dynamic,dynamic> get getRespuesta => _respuesta;
//   List<dynamic> get getDirecciones => _direcciones;

//   // set setDirecciones(r)=>r=_direcciones;

//   postDireccion(DireccionModel direccion)async{
//     Map<String, String>   head = {'Accept':'application/json' };
//     // String url = 'http://$ip/traeloo_database/public/api';

//      try{    
//     // _respuesta=null;
//     dynamic resp = await http.post(url+'/direcciones',body: {
   
//      "usuario_id":"${direccion.usuarioId}",
//      "nombre":"${direccion.nombre}",
//      "direccion":"${direccion.direccion}",
//      "tipo_direcion":"${direccion.tipoDireccion}",
//      "latitude":"${direccion.latitude}",
//      "longitude":"${direccion.longitude}",
//      "referencia":"${direccion.referencia}"
//     },headers: head); 
      
//     print(resp.body); 

//     Map<dynamic,dynamic> json = jsonDecode(resp.body.toString());
 
//       _respuesta=json['data'];
    
  
//     notifyListeners();
    
//       print(json);
//     return resp.body;
   
//    }catch(e){

//     // _respuesta=res;
//     print('error');
//     print(e);
//     return e;
//    }


//   }

//     obetenerTipoDirecciones()async{

//     //  _listaTipoDocumento=[];
//     Map<String, String>   head = {'Content-Type':'application/json','Accept':'application/json' };
      
//       // String url = 'http://$ip/traeloo_database/public/api';
//       dynamic respuestaTipoDocumento = await http.get(url+'/TipoDirecciones',headers: head); 
//       Map<String, dynamic> decodedResp = jsonDecode(respuestaTipoDocumento.body);
//       //print(respuestaTipoDocumento.body);
//       final tipoDireccion = tipoDireccionFromJson(respuestaTipoDocumento.body);
//       print(respuestaTipoDocumento);
//       tipoDireccion.data.data.forEach((element) {

//         print(element.icono);
//       //  _listaTipoDocumentoId.add(element.id);
//         _listaTipoDirecciones.add(element.icono);
//         notifyListeners();
//       });
     

//       // print('${decodedResp['data']}');
//       return respuestaTipoDocumento.body;

 
//   }

//   obtenerDirecciones() async {
    
//      try{

//       Map<String, String>   head = {'Content-Type':'application/json','Accept':'application/json' };

//       // String url = 'http://$ip/traeloo_database/public/api';


//       dynamic resp = await http.get(url+'/direcciones',headers: head); 
//        Map<dynamic, dynamic> decodedResp = jsonDecode(resp.body);
//       // final client = tipoDatosClienteFromJson(respuestaTipoDocumento.body);
//       final getDireccionModel = getDireccionModelFromJson(resp.body);


//      _direcciones = getDireccionModel.data.data;
//       // getDireccionModel.data.data.forEach((element) {

//       //    print(element);
//       //   _direcciones.add(element);
//       //   notifyListeners();
//       // });
//       notifyListeners();
     

//       // _direcciones = resp.body;
//       // print(_direcciones.body);
//       return resp.body;

//     }catch(e){
//       print(e);
//       return e;

//     }
    
//   }

//   deleteDireccion(int id)async{
//     try{

//       Map<String, String>   head = {'Content-Type':'application/json','Accept':'application/json' };
//       // String url = 'http://$ip/traeloo_database/public/api';
 
//       dynamic resp = await http.delete(url+'/direcciones'+'/$id',headers: head); 
//       print(resp.body);
//       deleteResp();
//       return resp.body;

//     }catch(e){
//       print(e);
//       return e;

//     }
   
//   }


//   deleteResp(){
//     _direcciones = [];
//     notifyListeners();
//   }
   
// }

// // 