import 'package:flutter/material.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/models/SucursalModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/cardPequenna/cardPequenna.dart';
import 'package:traelo_app/src/utils/Widgets/drawer/drawer.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

import 'models/inicioEmpleadoModel.dart';
import 'models/sucursal_asistente_model.dart';

class InicioEmpleado extends StatefulWidget {
  @override
  _InicioEmpleadoState createState() => _InicioEmpleadoState();
}

class _InicioEmpleadoState extends State<InicioEmpleado> {
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  PeticionesHttpProvider http = new PeticionesHttpProvider();
  Funciones funciones = new Funciones();
  String nombreSucursal = '';
  String urlFotoSucursal = null;
  String nuevas;
  String pendientes;
  
  String estado;
  String entregadas;
  String canceladas;
  String total;
  bool peticiones = false;
  bool busqueda = false;
  int totalOrdenes;
  @override
  Widget build(BuildContext context) {
     if(prefs.ultima_pagina != 'inicioasistente'){ prefs.ultima_pagina = 'inicioasistente'; }
    //  print('////////////////////'+prefs.ultima_pagina+'////////////////////');
     print(prefs.ultima_pagina);
    if (peticiones == false) {
      pedir(context);
      peticiones = true;
      setState(() {});
    }
    
    return Scaffold(
        drawer: MenuDesplegable(),
        appBar: AppBar(
          actions: [
            IconButton(
              // autofocus: true,

                icon: Icon(Icons.replay),
                onPressed: () {
                  setState(() {
                    busqueda = false;
                    peticiones = false;
                  });
                })
          ],
          backgroundColor: amarillo,
          elevation: 0,
          iconTheme: IconThemeData(color: verde),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: body(context),
        )
        
        );
  }

  Widget body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
          child: Column(
          children: [
      Container(
        color: Colors.grey[200],
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
                      child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('Sucursal: '),
                                SizedBox(
                                 height: 5,
                                ),
                                busqueda == false
                        ? CircularProgressIndicator(
                         backgroundColor: amarillo,
                         strokeWidth: 1,
                        )
                        : Text(nombreSucursal,
                           style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          Text('Estado: '),
                           busqueda == false ? CircularProgressIndicator(
                         backgroundColor: amarillo,
                         strokeWidth: 1,
                        )
                        : Text(estado,
                           style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      ),
                                // SizedBox(
                                //  height: 5,
                                // ),
                               
                    ],
                            ),
                            urlFotoSucursal != null
                                ?   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                         radius: 40,
                         backgroundImage:
                             NetworkImage(storage + urlFotoSucursal),
                      ),
                      )
                      : Container(),
                ],
              ),
          ),
        ),
      ),

      SizedBox(
        height: 35,
      ),
      Center(
        child: busqueda == false
            ? Row(
                children: [
                  Text(
                    'ORDENES: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Color.fromRGBO(19, 166, 7, 1),
                        letterSpacing: 2),
                  ),
                  CircularProgressIndicator(
                    backgroundColor: amarillo,
                    strokeWidth: 1,
                  )
                ],
              )
            : Text(
                'ORDENES: ' + '${totalOrdenes.toString() ?? '0'}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Color.fromRGBO(19, 166, 7, 1),
                    letterSpacing: 2),
              ),
      ),

      //  'ORDENES: '+'${totalOrdenes.toString()??'0'}'
      Container(
            width: size.width * 0.9,
            child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CardPequenna(
          aliado: true,
          asistente: true,
          colorNumero: amarillo,
          titulo: 'NUEVAS',
          colorTitulo: blanco,
          cantidadMod: busqueda == false
              ? CircularProgressIndicator(
                  backgroundColor: amarillo,
                  strokeWidth: 1,
                )
              : Text(nuevas ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize:
                          size.width > 589 ? 45.3 : size.width / 13,
                      fontWeight: FontWeight.bold,
                      color: amarillo ?? Colors.black)),
        ),
        CardPequenna(
          aliado: true,
          asistente: true,
          colorNumero: amarillo,
          titulo: 'PENDIENTES',
          colorTitulo: blanco,
          cantidadMod: busqueda == false
              ? CircularProgressIndicator(
                  backgroundColor: amarillo,
                  strokeWidth: 1,
                )
              : Text(pendientes ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize:
                          size.width > 589 ? 45.3 : size.width / 13,
                      fontWeight: FontWeight.bold,
                      color: amarillo ?? Colors.black)),
        ),
      ],
            )),
      Container(
            width: size.width * 0.9,
            child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CardPequenna(
          aliado: true,
          asistente: true,
          colorCard: blanco,
          colorNumero: verde,
          colorFloat: verde,
          colorTitulo: verde,
          titulo: 'CANCELADAS',
          ontap: () {},
          cantidadMod: busqueda == false
              ? CircularProgressIndicator(
                  backgroundColor: amarillo,
                  strokeWidth: 1,
                )
              : Text(canceladas ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize:
                          size.width > 589 ? 45.3 : size.width / 13,
                      fontWeight: FontWeight.bold,
                      color: verde ?? Colors.black)),
        ),
        CardPequenna(
          aliado: true,
          asistente: true,
          colorCard: blanco,
          colorNumero: verde,
          colorTitulo: verde,
          colorFloat: verde,
          titulo: 'ENTREGADAS',
          ontap: () {},
          cantidadMod: busqueda == false
              ? CircularProgressIndicator(
                  backgroundColor: amarillo, strokeWidth: 1)
              : Text(entregadas ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize:
                          size.width > 589 ? 45.3 : size.width / 13,
                      fontWeight: FontWeight.bold,
                      color: verde ?? Colors.black)),
        ),
      ],
            )),
    
     
      // Column(
      //   children: [
      //     // columnaDeTarjetas(context),

      //     SizedBox(height: size.height * 0.08),
      //     Image(
      //       image: AssetImage('assets/logoC.png'),
      //       width: 50,
      //     ),
      //     SizedBox(height: size.height * 0.05),
      //   ],
      // )
          ],
        ),
    );
  }

  pedir(context, {bool vehiculo = false}) async {
    final size = MediaQuery.of(context)
        .size; //  CircularProgressIndicator(backgroundColor: amarillo,strokeWidth: 1,);
    try {
      // load(context);

      List<Widget> widgets = [];
      // int pendientes;
      dynamic resp = await http.getMethod(
        context: context,
        table: 'pedido?sucursal_id=${prefs.id_sucursal}&all=1',
        token: prefs.token,
      );
      if (resp['message'] == "expiro") {
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      }

      if (resp['message'] == "true") {
        int calculoPendientes;
        int total;
        final sucursalesModel = homeAsistenteModelFromJson(resp['resp']);
        setState(() {
          nombreSucursal = sucursalesModel.nombre;
          urlFotoSucursal = sucursalesModel.urlFotoPerfil;
          calculoPendientes = sucursalesModel.preparada + sucursalesModel.autorizada;
          pendientes = calculoPendientes.toString();
          nuevas = sucursalesModel.generadas.toString();
          canceladas = sucursalesModel.cancelada.toString();
          entregadas = sucursalesModel.entregada.toString();
          total = sucursalesModel.preparada +  sucursalesModel.autorizada +  sucursalesModel.generadas + sucursalesModel.cancelada +  sucursalesModel.entregada;
          totalOrdenes = total;
          estado = sucursalesModel.estado;
          busqueda = true;
        });

        //  print('---------------------------------------------------------------------ok');
      }

      if (resp['message'] == "false") {
        return alerta(context);
      }
    } catch (e) {
      // Navigator.pop(context);
      return alerta(context,
          // titulo: 'sa',
          contenido: '$e',
          code: false);
    }
  }
}
