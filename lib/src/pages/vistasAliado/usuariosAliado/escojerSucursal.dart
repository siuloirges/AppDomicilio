import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/models/SucursalModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

class SucursalesCrearUsuarioAliado extends StatefulWidget {
  @override
  _SucursalesCrearUsuarioAliadoState createState() =>
      _SucursalesCrearUsuarioAliadoState();
}

class _SucursalesCrearUsuarioAliadoState
    extends State<SucursalesCrearUsuarioAliado> {
  PeticionesHttpProvider http = new PeticionesHttpProvider();

  Funciones funciones = new Funciones();

  PreferenciasUsuario pref = new PreferenciasUsuario();

  bool peticion = false;

  dynamic globalRespSucursales = [];
  UsuarioProvider usuarioProvider;
  @override
  Widget build(BuildContext context) {
    usuarioProvider = Provider.of<UsuarioProvider>(context);
    final size = MediaQuery.of(context).size;
    if (peticion == false) {
      peticion = true;
      pedir(context);
    }
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: verde),
          backgroundColor: amarillo,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 15),
                      Container(
                          width: size.width * 0.8,
                          child: Text(
                            'Como primer paso debe elegir la sucursal con la que quiere vicular al usuario.',
                            style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
              globalRespSucursales.length == 0
                  ? Column(
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    )
                  : globalRespSucursales == 'vacio'
                      ? Column(children: [
                          SizedBox(height: size.height * 0.35),
                          Text('No hay Sucursales creadas')
                        ])
                      : SingleChildScrollView(
                          child: Column(
                            children: globalRespSucursales,
                          ),
                        ),
            ],
          ),
        ));
  }

  pedir(context) async {
    // load(context);
    final size = MediaQuery.of(context).size;

    try {
      List<Widget> widgets = [];
      // load(context);
      dynamic resp = await http.getMethod(
          context: context, table: 'sucursales', token: pref.token);

      if (resp['message'] == "expiro") {
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      } else {}

      if (resp['message'] == "true") {
        final model = respSucursalFromJson(resp['resp']);
        print(model.message);
        // if (model.message != 'Unauthenticated.') {
        if (model.data.data.length == 0) {
          globalRespSucursales = 'vacio';
          setState(() {});
        } else {
          model.data.data.forEach((element) {
            widgets.add(sucursal(
                sucursal: element,
                context: context,
                onpressed: () {
                  load(context);
                  print('-----------------------' + element.id.toString());
                  usuarioProvider.obetenerDatos(context,
                      ruta: 'CrearUsuariosAliado',
                      table: 'tipo_documentos',
                      idSucursal: element.id);
                  // load(context);
                },
                id: element.id.toString(),
                subtitulo: element.direccion,
                titulo: element.nombre));
          });
          globalRespSucursales = [];
          globalRespSucursales = widgets;
          setState(() {});
        }

        // } else {
        //  Navigator.of(context).pushReplacementNamed('IniciarSesion');
        //   await funciones.closeSection(context);
        // }

        //  print('---------------------------------------------------------------------ok');
      }

      if (resp['message'] == "false") {
        return alerta(context, contenido: 'error', code: false);
      }
    } catch (e) {
      print("EL ERROR ES:-------------" + e);
      return alerta(context, contenido: 'error', code: false);
    }
  }
}

Widget sucursal({
  BuildContext context,
  String titulo,
  String subtitulo,
  dynamic sucursal,
  String id,
  Function onpressed,
}) {
  Size size = MediaQuery.of(context).size;
  Orientation orientation = MediaQuery.of(context).orientation;
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: GestureDetector(
          onTap: sucursal.idAsistente == null ? onpressed : () {},
          child: Container(
            width: size.width,
            height: 80,
            color: Colors.white,
            child: Card(
              margin: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: size.width * 0.03),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_business, color: verde),
                          ],
                        ),
                        SizedBox(width: size.width * 0.01),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width < 322
                                  ? size.width * 0.5
                                  : size.width < 570
                                      ? size.width * 0.6
                                      : size.width * 0.7,
                              //color: Colors.grey,
                              child: Text(
                                titulo,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: size.width < 436
                                      ? 13.08
                                      : size.width > 540
                                          ? 16.2
                                          : size.width * 0.03,
                                ),
                              ),
                            ),
                            Container(
                              width: size.width < 322
                                  ? size.width * 0.5
                                  : size.width < 570
                                      ? size.width * 0.6
                                      : size.width * 0.7,
                              child: Text(subtitulo,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: size.width < 436
                                          ? 12.2
                                          : size.width > 540
                                              ? 15.12
                                              : size.width * 0.028,
                                      color: Color.fromRGBO(103, 96, 95, 1))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          width: size.width,
          height: 80,
          color: sucursal.idAsistente != null ? Colors.black26 : null,
        ),
      )
    ],
  );
}
