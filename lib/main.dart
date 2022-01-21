import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/login/Provider/LoginProvider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/pages/registros/registro%20aliado/providers/guardarEstadoAliadoProvider.dart';
// import 'package:traelo_app/src/pages/registros/registroCliente/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/providers/adjuntarProviders.dart';
// import 'package:traelo_app/src/pages/registros/registroRepartidor/registro_repartidor.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/crear/services/cantidadProvider.dart';
import 'package:traelo_app/src/pages/vistasAliado/misOrdenes/mis_ordenes_aliado.dart';
import 'package:traelo_app/src/pages/vistasCliente/misOrdenes/mis_ordenes.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/provider/DireccionesProvider.dart';
import 'package:traelo_app/src/pages/vistasCliente/mostrarProveedor/ordenar/Providers/OrdenarProvider.dart';
// import 'package:traelo_app/src/pages/vistasCliente/ordenar/Providers/OrdenarProvider.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/provider/guardarCoordenadas.dart';
import 'package:traelo_app/src/routes/rutas.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/pages/vistasAliado/productosAliado/provider/productoprovider.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/RastreoProvider.dart';
import 'package:traelo_app/src/utils/provider/guardarCoordenadas.dart';
import 'package:traelo_app/src/utils/provider/push_notifications_provider.dart';
import 'package:traelo_app/src/utils/provider/RefrescarToken.dart';
import 'src/pages/vistasAliado/sucursalAliado/provider/guardarEstadoSucursalProvider.dart';
import 'package:traelo_app/src/utils/respOrdenAsistente.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/Ordenes/ordenes_Repartidor.dart';

// import 'package:traelo_app/src/pages/vistasAliado/misOrdenesAliado/mis_ordenes_aliado.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
 
  await prefs.initPrefs();
   RefrescarTokenProvider _refrescarTokenProvider = new RefrescarTokenProvider();
  _refrescarTokenProvider.refreshToken();
  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  PeticionesHttpProvider _http = new PeticionesHttpProvider();
  PreferenciasUsuario _pref = new PreferenciasUsuario();
  PedidoAliadoProvider pedido = new PedidoAliadoProvider();

  

  @override
  void initState(){
    
    super.initState();
    final pushProvider = new PushNotificationsProviders();
     
    //  refreshToken(); 
    pushProvider.initNotifications();
    pushProvider.mensajesStream.listen((message) {
      // print("===== DATA =======");
      // print(message);
       
      check(message);
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RastreoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => RegistroRepartidorProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => GuardarCoordenadas(),
        ),
        ChangeNotifierProvider(
          create: (context) => TotalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdenarProvider(),
        ),

        // ChangeNotifierProvider(create: (context) => ProductoProvider(),),

        ChangeNotifierProvider(
          create: (context) => UsuarioProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MantenerEstadoRepartidorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GuardarEstadoAliadoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GuardarEstadoSucursalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PedidoAliadoProvider(),
        ),
        
        ChangeNotifierProvider(
          create: (context) => PedidoRepartidorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PedidosClienteProvider(),
        ),

        // ChangeNotifierProvider(
          // create: (context) => DireccionesProvider(),
        // ),

        // ChangeNotifierProvider(create: (context) => DireccionesProvider(),),
      ],
      child: OKToast(
        handleTouth: true,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Pi3,14',
          initialRoute:_pref.ultima_pagina,
          routes: rutas(),
          theme: ThemeData(
            errorColor: Colors.deepOrangeAccent,
            primaryColor: verde,
          ),
        ),
      ),
    );
  }

  check(message) {
     
    bool _rolExist = _pref.rol != "";

    if (_rolExist) {

      String ruta = '';

      // print(message['data']['data']);
      switch (_pref.rol) {
        case 'cliente':
          ruta = 'iniciocliente';
          break;
        case 'repartidor':
          ruta = 'iniciorepartidor';
          break;
        case 'asistente':
          ruta = 'inicioasistente';
          break;
        default:
      }

      if (message['type'] == 'onMessage') {

        switch (_pref.rol) {
          
          case 'cliente':
           var element = respDetalleOrdenAsistenteFromJson(message['data']['data']);
           return  showToastWidget(
           PushNotificationsProviders.toastCustomWidget(navigatorKey: navigatorKey, data:message['data'],ruta: ruta,elementresp:message['data']['data'],
           onTap: (){
              if(_pref.activo=='true'){
                 navigatorKey.currentState.pop();
                navigatorKey.currentState.pushNamed('MisOrdenes',arguments: {"indice":element.id,"page":element.estado=='generada'?0:element.estado=='autorizada'?1:element.estado=='preparada'?2:element.estado=='en_transito'?3:element.estado=='entregada'?4:element.estado=='cancelada'?5:0,});
              }else{
                  navigatorKey.currentState.pushNamed('MisOrdenes',arguments: {"indice":element.id,"page":element.estado=='generada'?0:element.estado=='autorizada'?1:element.estado=='preparada'?2:element.estado=='en_transito'?3:element.estado=='entregada'?4:element.estado=='cancelada'?5:0,});
              }

           }
            ),
           position: ToastPosition.bottom,
           duration: Duration(seconds: 5), 
          );
            break;
          case 'repartidor':
           var element = respDetalleOrdenAsistenteFromJson(message['data']['data']);
         
         
         if(message['data']['tipo']=='repartidor'){
          showToastWidget(
            ToastWidgetRepartidor(navigatorKey: navigatorKey,data:element),
            duration: Duration(seconds: 20),
            position: ToastPosition.bottom,
           );
         }else{
             if(_pref.activo=='true'){
               return  showToastWidget(
                PushNotificationsProviders.toastCustomWidget(navigatorKey: navigatorKey, data: {
                  "title":"${message['data']['title']}",
                  "body":"${message['data']['body']}",
                } ,
                // ruta: ruta,
                onTap: (){
                  navigatorKey.currentState.pop();
                  navigatorKey.currentState.pushNamed('OrdenesRepartidor',arguments: {"indice":element.id,"page":element.estado=='generada'?0:element.estado=='autorizada'?1:element.estado=='preparada'?2:element.estado=='en_transito'?3:element.estado=='entregada'?4:element.estado=='cancelada'?5:0,});
                }
               ),
                position: ToastPosition.bottom,
                // dismissOtherToast: true,
                duration: Duration(seconds: 7), 
              );
             }else{
               return  showToastWidget(
                PushNotificationsProviders.toastCustomWidget(navigatorKey: navigatorKey, data: {
                  "title":"${message['data']['title']}",
                  "body":"${message['data']['body']}",
                } ,
                // ruta: ruta,
                onTap: (){
                  // navigatorKey.currentState.pop();
                  navigatorKey.currentState.pushNamed('OrdenesRepartidor',arguments: {"indice":element.id,"page":element.estado=='generada'?0:element.estado=='autorizada'?1:element.estado=='preparada'?2:element.estado=='en_transito'?3:element.estado=='entregada'?4:element.estado=='cancelada'?5:0,});
                }
               ),
                position: ToastPosition.bottom,
                // dismissOtherToast: true,
                duration: Duration(seconds: 7), 
              );
             }
          
         }
           
       
            break;
          case 'asistente':
          //
            var element = respDetalleOrdenAsistenteFromJson(message['data']['data']);
            if(_pref.activo=='true'){
              
              return  showToastWidget(
                PushNotificationsProviders.toastCustomWidget(navigatorKey: navigatorKey, data: {
                  "title":"${message['data']['title']}",
                  "body":"${message['data']['body']}",
                } ,
                // ruta: ruta,
                onTap: (){
                  navigatorKey.currentState.pop();
                  navigatorKey.currentState.pushNamed('MisOrdenesAliado',arguments: {'aliado':false,"indice":element.id,"page":element.estado=='generada'?0:element.estado=='autorizada'?1:element.estado=='preparada'?2:element.estado=='en_transito'?3:element.estado=='entregada'?4:element.estado=='cancelada'?5:0,});
                }
               ),
                position: ToastPosition.bottom,
                // dismissOtherToast: true,
                duration: Duration(seconds: 3), 
              );

            }else{
            
            return  showToastWidget(
              PushNotificationsProviders.toastCustomWidget(navigatorKey: navigatorKey, data: {
               "title":"${message['data']['title']}",
               "body":"${message['data']['body']}",
              },ruta: 'detallesDeOrdenAliado',
              onTap: (){
                navigatorKey.currentState.pushNamed('MisOrdenesAliado',arguments: {'aliado':false,"indice":element.id,"page":element.estado=='generada'?0:element.estado=='autorizada'?1:element.estado=='preparada'?2:element.estado=='en_transito'?3:element.estado=='entregada'?4:element.estado=='cancelada'?5:0,});
              }
             ),
              position: ToastPosition.bottom,
              // dismissOtherToast: true,
              duration: Duration(seconds: 3), 
          );

          }
            break;
          default:
         } 
       

      } else {
          var element = respDetalleOrdenAsistenteFromJson(message['data']['data']);
        navigatorKey.currentState.pushNamed(ruta, arguments: {"orden": element});
        // navigatorKey.currentState.pushNamed(ruta, arguments: {"orden": message['data']['orden']});

      }

    } else {
      _http.postMethod(
        body: {"fcm_token": "${PushNotificationsProviders.token}"},
        table: 'unset_fcm',
      );
    }
  }

}
