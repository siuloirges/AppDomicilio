import 'package:traelo_app/src/utils/Global.dart';
import 'package:http/http.dart'as http;
import 'package:traelo_app/src/utils/preferencias.dart';
// import 'PeticionesHttp.dart';

class Funciones {
  // PeticionesHttpProvider http = PeticionesHttpProvider();
  PreferenciasUsuario _pref = new PreferenciasUsuario();
closeSection(context)async{
  
  try{
   Map<String,String> head = {'Accept': 'application/json','Content-Type': 'application/json','Authorization':'Bearer ${_pref.token}'};
   dynamic  resp = await http.get('$url/logout',headers: head);
   print(resp.body);
   prefDelete();
  }catch(e){
    prefDelete();
    print(e);
  }
  
}

prefDelete(){
  //TODO  BORRAR TODAS LAS PREFERENCIAS
_pref.email=null;
_pref.foto_documento_identidad_1=null;
_pref.foto_documento_identidad_2=null;
_pref.foto_soat_1=null;
_pref.foto_soat_2=null;
_pref.foto_targeta_propiedad_1=null;
_pref.foto_targeta_propiedad_2=null;
_pref.foto_vehiculo_1=null;
_pref.foto_vehiculo_2=null;
_pref.id_aliado=null;
_pref.id_sucursal=null;
_pref.last_location=null;
_pref.nombre=null;
_pref.numero_documento=null;
_pref.refresh_token=null;
_pref.rol=null;
_pref.telefono=null;
_pref.tipo_documento=null;
_pref.token=null;
_pref.refresh_token=null;
_pref.ultima_pagina=null;
_pref.url_foto_perfil=null;
_pref.user_id=null;
_pref.ultima_pagina = null;
_pref.activo = null;


 print('PREF DELETE');                   
}

}