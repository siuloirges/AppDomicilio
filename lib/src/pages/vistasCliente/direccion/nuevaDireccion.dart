import 'dart:async';
import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/pages/vistasCliente/mostrarProveedor/ordenar/Providers/OrdenarProvider.dart';
// import 'package:traelo_app/src/pages/vistasCliente/ordenar/Providers/OrdenarProvider.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/provider/guardarCoordenadas.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

import 'models/GetDireccionModel.dart';

class NuevaDireccionPage extends StatefulWidget {
  // const NuevaDireccionPage({Key key}) : super(key: key);
  @override
  _NuevaDireccionPageState createState() => _NuevaDireccionPageState();
}

class _NuevaDireccionPageState extends State<NuevaDireccionPage> {
  PeticionesHttpProvider http = PeticionesHttpProvider();
  PreferenciasUsuario pref = PreferenciasUsuario();
  Funciones funciones = new Funciones();

  Completer<GoogleMapController> _controller = Completer();
  Position _currentPosition;
  LatLng _point;
  LatLng _ponitAtual;
  GuardarCoordenadas coordenadas;
  final Set<Marker> _markers = Set();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.399015, -75.504599),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    // coordenadas.reset();F
    // _getCurrentLocation();
  }

  @override
  void dispose() {
    coordenadas.reset();
    super.dispose();
  }

  Validaciones validar = new Validaciones();
//  DireccionesProvider direcciones;

  TextEditingController nombreController = TextEditingController();
  TextEditingController referenciaController = TextEditingController();

  FocusNode contrasenaFocus = new FocusNode();

  var formKey = GlobalKey<FormState>();

  String _vista = 'Icono';

  // DireccionesProvider direccionesProvider;
  Size size;
  dynamic element;
  bool ifController = false;
  OrdenarProvider ordenarProvider;
  
  @override
  Widget build(BuildContext context) {

    ordenarProvider = Provider.of<OrdenarProvider>(context);

    element = ModalRoute.of(context).settings.arguments;
    // print(
    //   element['data'].latitude,
    // );
    size = MediaQuery.of(context).size;
    //  print(element['data'].nombre);
    coordenadas = Provider.of<GuardarCoordenadas>(context);

    if (element['data'] != null && ifController == false) {
      // dynamic precio = element['producto'].precio??'';
      // dynamic precioPromo = element['producto'].precioPromo??'';
      if (element['data'].nombre != null) {
        nombreController.text = element['data'].nombre;
      }
      if (element['data'].referencia != null) {
        referenciaController.text = element['data'].referencia.toString();
      }
      // if(element['data'].latitude!=null&&element['data'].longitude!=null){;}

      if (element['data'].direccion != null) {
        // dynamic coordenadasEdit = LatLng(
        //     int.parse(element['data'].latitude.toString() ).toDouble(),
        //     int.parse(element['data'].longitude.toString()  ).toDouble());
        dynamic coordenadasEdit = LatLng(element['data'].latitude, element['data'].longitude);
        // target = coordenadasEdit;
        _kGooglePlex = CameraPosition(
          target: coordenadasEdit,
          zoom: 14.4746,
        );
        coordenadas.obtenerCoordenadas = coordenadasEdit;
      }

      ifController = true;
    }

    // direccionesProvider = Provider.of<DireccionesProvider>(context);

    // if(direccionesProvider.getListaTipoDirecciones.length == 0){
    //  direccionesProvider.obetenerTipoDirecciones();
    // }

    return Scaffold(
      // appBar:
      body: Column(
        children: [
          Flexible(child: _headerMap(context)),
          Flexible(child: _nameoftheaddress(context)),
        ],
      ),
    );
  }

  Widget _headerMap(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      child: Container(
        height: size.width > 450 ? 200 : size.height * 0.38,
        width: size.width,
        child: Container(
          child: GoogleMap(
            myLocationEnabled: true,
            trafficEnabled: false,
            mapType: MapType.normal,
            markers: _markers,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (value) {
              coordenadas.obtenerCoordenadas = value;
              setState(() {
                _ponitAtual = value;
                _markers.clear();
                final marker = new Marker(
                    markerId: MarkerId('Mi ubicacion Actual'),
                    position: _ponitAtual,
                    infoWindow: InfoWindow(
                        title: 'Mi ubicacion', snippet: 'Mi ubicacion'),
                    draggable: true);
                _markers.add(marker);
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _nameoftheaddress(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width > 450 ? 450 : size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(children: [
                  // Container(height: size.width>450?200: size.height * 0.43,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.only(
                                  bottom: 20.0,
                                  right: 20.0,
                                  left: 20.0,
                                  top: 20.0),
                              width: double.infinity,
                              child: Text(
                                coordenadas.getDireccion != null
                                    ? coordenadas.getDireccion.toString()
                                    : 'Tap en el mapa para definir la dirección',
                                style: TextStyle(color: blanco),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 15.0,bottom:15.0),
                  //   child: _drowDow(),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(size.width < 215
                            ? 'Nombre direccion '
                            : 'Nombre de la Dirección'),
                      ],
                    ),
                  ),
                  TextFormField(
                    validator: (value) => validar.validateGenerico(value),
                    controller: nombreController,
                    decoration: InputDecoration(
                      hintText: 'Casa',
                    ),
                  ),

                  _save(),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  Widget _drowDow() {
  //   return DropdownButton(
  //     // onTap: (){  user.obetenerTipoDocumento(); },
  //     // onTap:(){obetenerTipoDocumento(); },
  //     isExpanded: true,
  //     icon: Icon(
  //       Icons.keyboard_arrow_down,
  //       color: verde,
  //     ),
  //     // items: direccionesProvider.getListaTipoDirecciones.map((String lista){
  //     //   return DropdownMenuItem(value: lista, child: Text(lista));
  //     // }).toList(),
  //     // onChanged: (value) => {
  //     //   setState(() {
  //     //     _vista = value;

  //     //   })
  //     // },
  //     hint: Text(_vista),
  //     // value:_vista. ,
  //   );
  // }

  Widget _save() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_rounded),
                ),
                Text(
                  'Cancelar',
                  style: TextStyle(
                      color: coordenadas.getDireccion != 'Actualizando...'
                          ? negro
                          : negro),
                ),
              ],
            ),
            color: gris,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: coordenadas.getDireccion == null ||
                    coordenadas.getDireccion == 'Actualizando...'
                ? null
                : () {
                    _submit();
                  },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.cloud_upload,
                    color: coordenadas.getDireccion == null ||
                            coordenadas.getDireccion == 'Actualizando...'
                        ? blanco
                        : verde,
                  ),
                ),
                Text(
                  'Guardar direccion',
                  style: TextStyle(
                      color: coordenadas.getDireccion == null ||
                              coordenadas.getDireccion == 'Actualizando...'
                          ? blanco
                          : verde),
                ),
              ],
            ),
            color: amarillo,
          ),
        ),
      ],
    );
  }

  _getCurrentLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    // geolocator.
    bool status = await geolocator.isLocationServiceEnabled();
    if (!status) return _showDialogGps(geolocator);
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _currentPosition = position;
      setState(() {
        _getCurrentLocationMarker();
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _getCurrentLocationMarker() async {
    setState(() {
      _point = LatLng(_currentPosition.latitude, _currentPosition.longitude);
      coordenadas.obtenerCoordenadas = _point;
      final marker = new Marker(
          markerId: MarkerId('Mi ubicacion'),
          position: _point,
          infoWindow:
              InfoWindow(title: 'Mi ubicacion', snippet: 'Mi ubicacion'),
          draggable: true);
      _markers.add(marker);
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        new CameraPosition(
            zoom: 17,
            target:
                LatLng(_currentPosition.latitude, _currentPosition.longitude)),
      ),
    );
  }

_showDialogGps(Geolocator geolocator) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          backgroundColor: Color.fromRGBO(246, 245, 250, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: ShapeDecoration(
                    color: blanco,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Text("Obligatorio"),
                  )),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 50.0,
              ),
              Text("Activa GPS para Continuar"),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: size.width,
                    child: RaisedButton(
                      color: verde,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: new Text("Listo!",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        bool status = await geolocator.isLocationServiceEnabled();
                        if (status) return Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
}

  referencia() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(246, 245, 250, 1),
            title: Container(
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'Confirmar',
                    style: TextStyle(color: Colors.grey),
                  )),
                )),
            content: Container(
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Container(
                  height: size.width > 450 ? 200 : size.height * 0.22,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                            child: TextFormField(
                          controller: referenciaController,
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText: 'referencia del lugar \n(opcional)'),
                        )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width / 2,
                            height: 45,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: verde,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Enviar',
                                      style: TextStyle(color: blanco),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                                onPressed: element['data'] == null
                                    ? () async {
                                        load(context);
                                        dynamic _respuesta =  await http.postMethod(
                                                context: context,
                                                body: {
                                                  "usuario_id":
                                                      "${int.parse(pref.user_id)}",
                                                  "nombre":
                                                      "${nombreController.text}",
                                                  "direccion":
                                                      "${coordenadas.getDireccion.toString()}",
                                                  "tipo_direcion_id": "1",
                                                  "latitude":
                                                      "${coordenadas.getCoordenadas.latitude.toDouble()}",
                                                  "longitude":
                                                      "${coordenadas.getCoordenadas.longitude.toDouble()}",
                                                  "referencia":
                                                      "${referenciaController.text}"
                                                },
                                                table: 'direcciones',
                                                token: pref.token);

                                        //  print(resp);
                                        if (_respuesta['message'] == "expiro") {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);

                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  'IniciarSesion');
                                          alerta(context,
                                              titulo: 'alerta',
                                              code: false,
                                              contenido:
                                                  'Tiempo de conexion agotado, inicie sesion nuevamente.');
                                          await funciones.closeSection(context);
                                        }

                                        if (_respuesta['message'] == "false") {
                                          //  Navigator.pop(context);
                                          print(_respuesta.toString() +
                                              '---------------------------------Bad');
                                          dynamic res = json.encode(_respuesta);

                                          print(res);
                                          var respModel =
                                              errorsFormModelFromJson(res);
                                          List<Widget> errors = [];
                                          respModel.errors
                                              .forEach((key, value) {
                                            var index = errors.length / 2;
                                            errors
                                              ..add(Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor: amarillo,
                                                    child: Center(
                                                      child: Text(
                                                        '${index.toString().replaceAll(new RegExp(r'.0'), '')}',
                                                        style: TextStyle(
                                                            color: verde,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.width / 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        value.join(),
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                              ..add(Divider());
                                          });

                                          // Navigator.pop(context);
                                          return alerta(
                                            context,
                                            contenido: Column(
                                              children: errors,
                                            ),
                                            acciones: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0, right: 5),
                                              child: Container(
                                                width: 56,
                                                height: 56,
                                                child: RaisedButton(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  color: Colors.black26,
                                                  child: Center(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .arrow_back_rounded,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  )),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        if (_respuesta['message'] == "expiro") {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  'IniciarSesion');
                                          alerta(context,
                                              titulo: 'alerta',
                                              code: false,
                                              contenido:
                                                  'Tiempo de conexion agotado, inicie sesion nuevamente.');
                                          await funciones.closeSection(context);
                                        }

                                        if (_respuesta['message'] == "true") {
                                          ordenarProvider
                                              .setGlobalRespDirecciones = '';
                                          try {
                                            Map _respuesta =
                                                await http.getMethod(
                                                    context: context,
                                                    table: 'direcciones',
                                                    token: pref.token);
                                            if (_respuesta['message'] ==
                                                'true') {
                                              // print(_respuesta);
                                              final respModel =
                                                  getDireccionesModelFromJson(
                                                      _respuesta['resp']);
                                              print(respModel.data.data);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              // Scaffold.of(context).openEndDrawer();
                                              Navigator.of(context).pushNamed(
                                                  'MisDirecciones',
                                                  arguments: {
                                                    "data": respModel.data.data
                                                  });
                                            }
                                          } catch (e) {
                                            Navigator.pop(context);
                                            Scaffold.of(context)
                                                .openEndDrawer();
                                            return alerta(context,
                                                contenido: Text(e),
                                                acciones: Container());
                                          }
                                        }
                                        //  direccionesProvider.postDireccion(
                                        //    DireccionModel(
                                        //      usuarioId: '29318294817294817',
                                        //      nombre: nombreController.text,
                                        //      tipoDireccion: _vista.toString(),
                                        //      direccion: coordenadas.getDireccion.toString(),
                                        //      latitude: coordenadas.getCoordenadas.latitude.toDouble(),
                                        //      longitude: coordenadas.getCoordenadas.longitude.toDouble(),
                                        //      referencia: referenciaController.text,
                                        //    )
                                        //  );
                                        //   direccionesProvider.deleteResp();
                                        //   Navigator.pop(context);
                                        //   Navigator.pop(context);
                                      }
                                    : () async {
                                        load(context);
                                        if (!formKey.currentState.validate()) {
                                          return null;
                                        }
                                        // load(context);
                                        Map _respuesta = await http.putMethod(
                                          context: context,
                                          body: {
                                            "usuario_id":
                                                "${int.parse(pref.user_id)}",
                                            "nombre":
                                                "${nombreController.text}",
                                            "direccion":
                                                "${coordenadas.getDireccion.toString()}",
                                            "tipo_direcion_id": "1",
                                            "latitude":
                                                "${coordenadas.getCoordenadas.latitude.toDouble()}",
                                            "longitude":
                                                "${coordenadas.getCoordenadas.longitude.toDouble()}",
                                            "referencia":
                                                "${referenciaController.text}"
                                          },
                                          table: 'direcciones',
                                          id: element['data'].id,
                                          token: pref.token,
                                        );

                                        if (_respuesta['message'] == "false") {
                                          Navigator.pop(context);
                                          print(_respuesta.toString() +
                                              '---------------------------------Bad');
                                          dynamic res = json.encode(_respuesta);

                                          print(res);
                                          var respModel =
                                              errorsFormModelFromJson(res);
                                          List<Widget> errors = [];
                                          respModel.errors
                                              .forEach((key, value) {
                                            var index = errors.length / 2;
                                            errors
                                              ..add(Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor: amarillo,
                                                    child: Center(
                                                      child: Text(
                                                        '${index.toString().replaceAll(new RegExp(r'.0'), '')}',
                                                        style: TextStyle(
                                                            color: verde,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.width / 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        value.join(),
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                              ..add(Divider());
                                          });

                                          return alerta(
                                            context,
                                            contenido: Column(
                                              children: errors,
                                            ),
                                            acciones: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0, right: 5),
                                              child: Container(
                                                width: 56,
                                                height: 56,
                                                child: RaisedButton(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  color: Colors.black26,
                                                  child: Center(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .arrow_back_rounded,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  )),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        if (_respuesta['message'] == "expiro") {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  'IniciarSesion');
                                          alerta(context,
                                              titulo: 'alerta',
                                              code: false,
                                              contenido:
                                                  'Tiempo de conexion agotado, inicie sesion nuevamente.');
                                          await funciones.closeSection(context);
                                        }
                                        if (_respuesta['message'] == "true") {
                                          try {
                                            Map _respuesta =
                                                await http.getMethod(
                                                    context: context,
                                                    table: 'direcciones',
                                                    token: pref.token);

                                            if (_respuesta['message'] ==
                                                'true') {
                                              // print(_respuesta);
                                              final respModel =
                                                  getDireccionesModelFromJson(
                                                      _respuesta['resp']);
                                              print(respModel.data.data);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              // Scaffold.of(context).openEndDrawer();
                                              Navigator.of(context).pushNamed(
                                                  'MisDirecciones',
                                                  arguments: {
                                                    "data": respModel.data.data
                                                  });
                                            }
                                          } catch (e) {
                                            Navigator.pop(context);
                                            return alerta(context,
                                                contenido: Text(e),
                                                acciones: Container());
                                          }
                                          // var respModel = getDireccionesModelFromJson(_respuestaDireccion['resp'].body);
                                          // Navigator.pop(context);
                                          // Navigator.pop(context);
                                          // Navigator.pop(context);
                                          // Navigator.of(context).pushNamed('SucursalAliado',arguments:{"data":respModel.data.data});
                                        } else {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          return alerta(context,
                                              contenido: Text('Error'),
                                              acciones: Container());
                                        }
                                      }
                                // print(resp);

                                //     'nombre',
                                //     'direccion',
                                //     'latitude',
                                //     'longitude',
                                //     'telefono',
                                //     'id_aliado'

                                // usuarioId: '29318294817294817',
                                // nombre: nombreController.text,
                                // direccion: coordenadas.getDireccion.toString(),
                                // latitude: coordenadas.getCoordenadas.latitude.toDouble(),
                                // longitude: coordenadas.getCoordenadas.longitude.toDouble(),
                                // referencia: referenciaController.text,

                                ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  _submit() {
    if (!formKey.currentState.validate()) {
      return null;
    }
    referencia();
    //0011011
  }
}
