import 'dart:async';
import 'dart:convert';
// import 'dart:js';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:traelo_app/src/pages/vistasAliado/perfilAliado/editarUsuario.dart';
// import 'package:traelo_app/src/pages/vistasAliado/misOrdenesAliado/model/respuestaOrdenesAliados.dart';
// import 'package:traelo_app/src/pages/vistasAliado/misOrdenesAsistente/model/respuestaOrdenesAsistente.dart';
import 'package:traelo_app/src/pages/vistasCliente/misOrdenes/models/respMisOrdenesModels.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/respOrdenAsistente.dart';

PeticionesHttpProvider _http = PeticionesHttpProvider();

class PushNotificationsProviders {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<Map>.broadcast();

  Stream<Map> get mensajesStream => _mensajesStreamController.stream;

  static String token = '';

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }
    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
    // Or do other work.
  }

  initNotifications() async {
    _firebaseMessaging.requestNotificationPermissions();
    token = await _firebaseMessaging.getToken();
    print('========= FCM Token =========');
    print(token);
    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('========== onMessage ==========');
    final data = message['data'];
    _mensajesStreamController.sink.add({"data": data, "type": "onMessage"});
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('========== onLaunch ==========');
    final data = message['data'];
    _mensajesStreamController.sink.add({"data": data, "type": "onLaunch"});
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print('========== onResume ==========');
    final data = message['data'];
    _mensajesStreamController.sink.add({"data": data, "type": "onResume"});
  }

  dispose() {
    _mensajesStreamController?.close();
  }

  static Widget toastCustomWidget(
      {navigatorKey, data, ruta, elementresp, Function onTap}) {
    return GestureDetector(
      // onTap: () {
      //   // print({"orden": data['orden']});
      //   // Map orden = jsonDecode(data['orden']);
      //   var element = respDetalleOrdenAsistenteFromJson(elementresp);
      //   navigatorKey.currentState.pushNamed(ruta, arguments: {"orden": element});
      // },

      onTap: onTap,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: BoxDecoration(
            color: Colors.black54, borderRadius: BorderRadius.circular(100)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  data['title'] + ':',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  data['body'],
                  style: TextStyle(color: Colors.yellow),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 


}


class ToastWidgetRepartidor extends StatefulWidget {
 final dynamic data;
 final dynamic navigatorKey;
  const ToastWidgetRepartidor({Key key, this.data,this.navigatorKey}) : super(key: key);
  @override
  _ToastWidgetRepartidorState createState() => _ToastWidgetRepartidorState();
}

class _ToastWidgetRepartidorState extends State<ToastWidgetRepartidor> {
   final GlobalKey<NavigatorState> navigatorGlobalKey = new GlobalKey<NavigatorState>();
@override
void dispose() { 
  
  super.dispose();
}
 int contador=20;
 bool load=false;
  @override
  Widget build(BuildContext context) {
// currentContext
if(contador==20){
  cronometro();
}
    return  GestureDetector(

      child:contador>1? Container(
        // height: 500,
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$contador',
              
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: blanco, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '¿Quieres hacerte cargo es este domicilio?',
            
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: blanco, fontWeight: FontWeight.bold),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 300,
                  child: Text(
                    'Recoger  en: ${widget.data.sucursal.direccion}',
                    // '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: blanco),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 300,
                  child: Text(
                    'Destino ${widget.data.direccion.direccion}',
                    // '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: blanco),
                  )),
            ),
            Text('Valor domicilio \$100.00 No es el precio real'), 
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:load==false? RaisedButton(
                      color: amarillo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        // load(context);
                        load=true;
                        setState(() {
                          
                        });
                        Map resp = await _http.putMethod(
                            table: 'pedido',
                            token: pref.token,
                            id: widget.data.id,
                            body: {
                              "roll": "repartidor",
                              "estado": "preparada",
                              "generada": "",
                              "autorizada": "",
                              "preparada": "1",
                              "en_transito": "",
                              "entregada": "",
                              "cancelada": "",
                              "repartidor_id": "${pref.user_id}"
                            });
                        // Navigator.pop(context);
                        if (resp['message'] == 'true') {
                          Map<String, dynamic> decodeResp =  json.decode(resp['resp'].body);

                          if (decodeResp['result'] == "1") {
                            contador=0;
                            setState(() {
                              
                            });
                            // print('contador 0 todo ok');
                            // Navigator.pushNamed(context, 'OrdenesRepartidor');
                            if(pref.activo=='true'){
                              
                               return showToastWidget(
                              Container(
                                height: 100,
                                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(decodeResp['data'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                       
                                        Text('Recarga la pagina para ver el pedido',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                       
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              duration: Duration(seconds: 7),
                              position: ToastPosition.center
                            );
                            }else{
                               return showToastWidget(
                              Container(
                                height: 100,
                                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(decodeResp['data'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                       
                                        Text('Revisa tus ordenes en el menu lateral',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                       
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              duration: Duration(seconds: 7),
                              position: ToastPosition.center
                            );
                            }
                            
                            


                            
                          } else {
                            contador=0;
                            setState(() {
                              
                            });
                            return showToastWidget(
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(decodeResp['data'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              duration: Duration(seconds: 5),
                                position: ToastPosition.bottom
                            );
                          }
                        }else{
                           contador=0;
                            setState(() {
                              
                            });
                           return showToastWidget(
                              Container(
                                height: 50,
                                margin:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Error con el servidor',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              duration: Duration(seconds: 5)
                            );
                        }
                      },
                      child: Text(
                        'Si',
                        style: TextStyle(
                            color: verde, fontWeight: FontWeight.bold),
                      ),
                    ):CircularProgressIndicator(backgroundColor: amarillo,strokeWidth: 1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: verde,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                     contador--;
                       setState(() {
                         
                       });
                       print('contador'+contador.toString());
                   },
                      child: Text(
                        'No',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ):Container(),
    );
  }

  cronometro()async{
      for(contador;contador>1;contador--){
        await Future.delayed(Duration(seconds: 1));
         setState(() {
         });
      }
  }
}