import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/utils/Global.dart';
// import 'package:universal_platform/universal_platform.dart';
import 'package:connection_verify/connection_verify.dart';

import 'Providers/RegistroProvider.dart';

class RegistroPage extends StatelessWidget {
  UsuarioProvider usuarioProvider;
  @override
  Widget build(BuildContext context) {
    usuarioProvider = Provider.of<UsuarioProvider>(context);
    return Scaffold(
      //  floatingActionButton: FloatingActionButton(onPressed: (){
      //   verificarInternet(context);
      //  } ),

      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        title: Text(
          "Registro",
          style: TextStyle(
            color: verde,
            fontSize: 15.0,
          ),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[registro(context)],
        ),
      ),
    );
  }

  verificarInternet(BuildContext context) async {
    if (await ConnectionVerify.connectionStatus()) {
      return alerta(context,
          code: false, titulo: "alerta", contenido: "si hay conexion.");
      //Do your online stuff here
    } else {
      return alerta(context,
          code: false, titulo: "alerta", contenido: "no hay conexion.");
      //Do your offline stuff here
    }
  }

  Widget registro(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/logo.png"),
                    width: 120,
                    // color: verde,
                  ),
                  SizedBox(height: size.height * 0.06),
                  Text(
                    "REGISTRARSE COMO",
                    style: TextStyle(
                      color: verde,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width > 450 ? 10 : size.height * 0.018,
                    ),
                  ),
                  SizedBox(height: size.height * 0.08),
                  Container(
                    height: size.height * 0.065,
                    width: size.width > 450 ? 450 : size.width,
                    child: RaisedButton(
                        elevation: 0.0,
                        color: amarillo,
                        child: Text('CLIENTE',
                            style: TextStyle(
                                fontSize:
                                    size.width > 450 ? 10 : size.height * 0.018,
                                color: verde)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        onPressed: () {
                          usuarioProvider.obetenerDatos(context,
                              ruta: 'RegistroCliente',
                              table: 'tipo_documentos');
                          load(context);
                        }),
                  ),
                  SizedBox(height: size.height * 0.025),
                  Container(
                    height: size.height * 0.065,
                    width: size.width > 450 ? 450 : size.width,
                    child: RaisedButton(
                        elevation: 0.0,
                        color: verde,
                        child: Text(
                          'ALIADO',
                          style: TextStyle(
                              fontSize:
                                  size.width > 450 ? 10 : size.height * 0.018,
                              color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('PrimerRegistroAliado');
                        }),
                  ),
                  SizedBox(height: size.height * 0.025),
                  Container(
                    height: size.height * 0.065,
                    width: size.width > 450 ? 450 : size.width,
                    child: RaisedButton(
                        elevation: 0.0,
                        color: amarillo,
                        child: Text('REPARTIDOR',
                            style: TextStyle(
                                fontSize:
                                    size.width > 450 ? 10 : size.height * 0.018,
                                color: verde)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        onPressed: () {
                          usuarioProvider.obetenerDatos(context,
                              ruta: 'RegistroRepartidor',
                              table: 'tipo_documentos',
                              repartidor: 'tipo_vehiculo');
                          load(context);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
