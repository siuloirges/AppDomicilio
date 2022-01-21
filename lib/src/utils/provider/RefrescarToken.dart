// import 'package:flutter/material.dart';
import 'package:traelo_app/src/pages/vistasAliado/perfilAliado/editarUsuario.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';

class RefrescarTokenProvider {
   PeticionesHttpProvider _http = new PeticionesHttpProvider();
   PreferenciasUsuario _pref = new PreferenciasUsuario();
    refreshToken()async{
     await Future.delayed(const Duration(minutes: 40), () async {
     _send();
     if(_pref.token!=''){

      print('Refrecando');
     }else{
      print('No loggeado');
     }
     refreshToken();
    
    });
  }

  _send()async{
     dynamic _resp = await _http.postMethod(
         body: {
           "refresh_token":_pref.refresh_token
         },
         table: 'refresh',
     );

      if(_resp['message']=='true'){
        
       print('Refrescado');
       pref.token =_resp['data']['access_token'];
       pref.refresh_token =_resp['data']['refresh_token'];
       print('toke new: '+_resp['data']['access_token']);
       print('\nrefreds new: '+_resp['data']['refresh_token']);

      }
  }

}