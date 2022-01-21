import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/pages/vistasAliado/inicioAsistente/models/sucursal_asistente_model.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/models/SucursalModel.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/models/DireccionModel.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/InicioAdministrador/inicioAdministrador.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/models/DireccionModel.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/provider/DireccionesProvider.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/provider/guardarCoordenadas.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/provider/guardarCoordenadas.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

// import 'models/SucursalModel.dart';

class EditarSucursalAsistente extends StatefulWidget {
  // const NuevaDireccionPage({Key key}) : super(key: key);
  @override
  _EditarSucursalAsistente createState() => _EditarSucursalAsistente();
}

class _EditarSucursalAsistente extends State<EditarSucursalAsistente> {
  File imagenPerfil;
  File imagenPortada;
// dynamic element;
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
    // _getCurrentLocation();
    print(pref.token);
  }

  @override
  void dispose() {
    coordenadas.reset();
    super.dispose();
  }

  Validaciones validar = new Validaciones();
//  DireccionesProvider direcciones;

  TextEditingController nombreController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  FocusNode contrasenaFocus = new FocusNode();
  FocusNode telefonoFocus = new FocusNode();
  // ScrollController scrollController = new ScrollController();
  var formKey = GlobalKey<FormState>();

  // String _vista='Icono';

  // DireccionesProvider direccionesProvider;
  Size size;
  bool ifController = false;
  dynamic element;
  bool mapa = true;
  @override
  Widget build(BuildContext context) {
    element = ModalRoute.of(context).settings.arguments;

    size = MediaQuery.of(context).size;
    coordenadas = Provider.of<GuardarCoordenadas>(context);
    // direccionesProvider = Provider.of<DireccionesProvider>(context);

    if (element['data'] != null && ifController == false) {
      // dynamic precio = element['producto'].precio??'';
      // dynamic precioPromo = element['producto'].precioPromo??'';
      if (element['data'].nombre != '' || element['data'].nombre != null) {
        nombreController.text = element['data'].nombre;
      }
      if (element['data'].telefono != '' || element['data'].telefono != null) {
        telefonoController.text = element['data'].telefono.toString();
      }
      // if(element['data'].latitude!=null&&element['data'].longitude!=null){;}

      if (element['data'].direccion != null) {
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
    return Scaffold(
      // appBar:
      body: Stack(
        children: [
          SingleChildScrollView(
            // controller: scrollController,
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  height: mapa == true
                      ? size.width > 450
                          ? 200
                          : size.height * 0.38
                      : 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: _nameoftheaddress(context),
                ),
              ],
            ),
          ),
          mapa == true ? _headerMap(context) : Container(),
          Stack(
            children: [
              mapa == false
                  ? Column(
                      children: [
                        Container(
                          height: 80,
                        ),
                        Container(
                            height: 1,
                            decoration: ShapeDecoration(
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 9,
                                  )
                                ],
                                color: Colors.white,
                                shape: RoundedRectangleBorder())),
                      ],
                    )
                  : Container(),
              Container(
                color: verde,
                width: size.width,
                height: 80,
                // decoration: ShapeDecoration(color:Colors.white,),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: FlatButton(
                      onPressed: () {
                        //  scrollController.animateTo( mapa ==true?scrollController.position.pixels+size.width > 450 ? 180 : size.height * 0.35:scrollController.position.pixels-size.width > 450 ? 200 : size.height * 0.38, duration: Duration(microseconds: 500), curve: Curves.easeInBack);
                        mapa = !mapa;
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            mapa == true
                                ? 'Tap aqui para quitar Mapa'
                                : 'Tap aqui para ver Mapa',
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                                mapa == true
                                    ? Icons.highlight_remove_rounded
                                    : Icons.add,
                                color: Colors.white),
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerMap(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: size.width > 450 ? 200 : size.height * 0.38,
                width: size.width,
              ),
              Container(
                  height: 1,
                  decoration: ShapeDecoration(shadows: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 9,
                    )
                  ], color: Colors.white, shape: RoundedRectangleBorder())),
            ],
          ),
          Container(
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
        ],
      ),
    );
  }

  Widget _nameoftheaddress(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Container(
        width: size.width > 450 ? 450 : size.width,
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
                            bottom: 20.0, right: 20.0, left: 20.0, top: 20.0),
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
                  Text(size.width < 215 ? 'Telefono ' : 'Telefono'),
                ],
              ),
            ),
            TextFormField(
              validator: (value) => validar.validateNumerico(value),
              controller: telefonoController,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {
                telefonoFocus.requestFocus();
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: 'numero telefonico',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(size.width < 215
                      ? 'Nombre Sucursal '
                      : 'Nombre de la Sucursal'),
                ],
              ),
            ),
            TextFormField(
              validator: (value) => validar.validateGenerico(value),
              focusNode: telefonoFocus,
              // onFieldSubmitted: (value){element['data']== null?  _submit(): _submitUpDate();},
              controller: nombreController,
              decoration: InputDecoration(
                hintText: 'Nombre',
              ),
            ),

            Column(
              children: [
                crearImagenPerfil(context),
                crearImagen(context),
              ],
            ),
            // crearImagen(context),
            _save(),
          ]),
        ),
      ),
    );
  }

  Widget crearImagenPerfil(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: ShapeDecoration(
            color: gris,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Row(
                children: [
                  Text(
                    'Alto: 180px Ancho: 180px',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: verdeClaro,
                          borderRadius: BorderRadius.circular(100)),
                      width: 165,
                      height: 165,
                      child: imagenPerfil != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: FileImage(imagenPerfil)),
                            )
                    : element['data']!=null?ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:element['data'].urlFotoPerfil!=null? Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(storage+element['data'].urlFotoPerfil)):Container(),
                            ):Container()),
                ),
              ),
              imagenPerfil != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Center(
                        child: IconButton(
                            alignment: Alignment.center,
                            iconSize: 1,
                            icon: IconButton(
                              icon: Icon(
                                Icons.highlight_remove_rounded,
                                color: blanco,
                              ),
                              onPressed: () {
                                setState(() {
                                  imagenPerfil = null;
                                });
                              },
                            ),
                            onPressed: null),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 140,
                      ),
                      RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () {
                          onpressaddImage(context, imagenPerfil);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Container(
                                width: 100,
                                child: Center(
                                    child: Text('Subir imagen',
                                        style: TextStyle(
                                          color: verde,
                                          // fontSize: 30),
                                        ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget crearImagen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: ShapeDecoration(
            color: gris,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'Alto: 180px Ancho: 180px',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: verdeClaro,
                          borderRadius: BorderRadius.circular(10)),
                      width: size.width,
                      height: 165,
                      child: imagenPortada != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: FileImage(imagenPortada)),
                            )
                          : element['data'] !=null?ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: element['data'].urlFotoPortada !=null?Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(storage+element['data'].urlFotoPortada)):Container(),
                            ):Container()),
                ),
              ),
              imagenPerfil != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 165,
                          ),
                          RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            onPressed: () {
                              onpressaddImage(context, imagenPortada);
                            },
                            child: Container(
                              width: 100,
                              child: Center(
                                  child: Text('Subir imagen',
                                      style: TextStyle(
                                        color: verde,
                                        // fontSize: 30),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              imagenPortada != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: IconButton(
                                alignment: Alignment.center,
                                iconSize: 1,
                                icon: IconButton(
                                  icon: Icon(
                                    Icons.highlight_remove_rounded,
                                    color: blanco,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      imagenPortada = null;
                                    });
                                  },
                                ),
                                onPressed: null),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void onpressaddImage(BuildContext context, File foto) {
    final tamano = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Seleccione',
                  style:
                      TextStyle(fontSize: tamano.width * 0.038, color: verde),
                ),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: verde, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.center_focus_strong,
                              color: verde,
                              size: tamano.width * 0.05,
                            ),
                            Text(
                              'tomar',
                              style: TextStyle(
                                  fontSize: tamano.width * 0.038, color: verde),
                            ),
                          ],
                        ),
                        onPressed: () {
                          if (foto == imagenPerfil) {
                            cargarImageCamera(foto);
                            // Navigator.pop(context);
                          } else if (foto == imagenPortada) {
                            cargarImageCamera2(foto);
                            // Navigator.pop(context);
                          }
                          // cargarImageCamera();
                          Navigator.pop(context);
                        })),
                SizedBox(
                  width: tamano.height * 0.025,
                ),
                Container(
                    child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: verde, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add_a_photo,
                              color: verde,
                              size: tamano.width * 0.040,
                            ),
                            Text(
                              'galería',
                              style: TextStyle(color: verde),
                            ),
                          ],
                        ),
                        onPressed: () {
                          if (foto == imagenPerfil) {
                            cargarImageGalery(foto);
                            // Navigator.pop(context);
                          } else if (foto == imagenPortada) {
                            cargarImageGalery2(foto);
                            // Navigator.pop(context);
                          }
                          Navigator.pop(context);
                        })),
              ],
            ),
          );
        });
  }

  Future cargarImageGalery(foto) async {
    var tempImage = await ImagePicker.pickImage(
        maxHeight: 180, maxWidth: 180, source: ImageSource.gallery);
    setState(() {
      imagenPerfil = tempImage;
    });
  }

  Future cargarImageCamera(foto) async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight: 180, maxWidth: 180, source: ImageSource.camera);

    setState(() {
      imagenPerfil = tempImageCamera;
    });
  }

  Future cargarImageGalery2(foto) async {
    var tempImage = await ImagePicker.pickImage(
        maxHeight: 566, maxWidth: 180, source: ImageSource.gallery);
    setState(() {
      imagenPortada = tempImage;
    });
  }

  Future cargarImageCamera2(foto) async {
    var tempImageCamera = await ImagePicker.pickImage(
        maxHeight: 566, maxWidth: 180, source: ImageSource.camera);

    setState(() {
      imagenPortada = tempImageCamera;
    });
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
  //     items: direccionesProvider.getListaTipoDirecciones.map((String lista){
  //       return DropdownMenuItem(value: lista, child: Text(lista));
  //     }).toList(),
  //     onChanged: (value) => {
  //       setState(() {
  //         _vista = value;

  //       })
  //     },
  //     hint: Text(_vista),
  //     // value:_vista. ,
  //   );
  // }

  Widget _save() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
          child: Row(
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
                      element['data'] == null ? _submit() : _submitUpDate();
                    },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.cloud_upload,
                        color: coordenadas.getDireccion == null ||
                                coordenadas.getDireccion == 'Actualizando...'
                            ? blanco
                            : verde),
                  ),
                  Text(
                    'Guardar Sucursal',
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
      ),
    );
  }

  _getCurrentLocation() async {
    /*
    --- Função responsável por receber a localização atual do usuário
  */

    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
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
                        bool status =
                            await geolocator.isLocationServiceEnabled();
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

  _submit() async {
   if(imagenPerfil==null && imagenPortada==null){
     return alerta(context,code: false,contenido: 'Las imagenes son necesarias');
   } 
    if (!formKey.currentState.validate()) {
      return null;
    }
    load(context);
    Map _respuesta = await http.postMethod(
        context: context,
        body: {
          "nombre": "${nombreController.text}",
          "direccion": "${coordenadas.getDireccion.toString()}",
          "latitude": "${coordenadas.getCoordenadas.latitude.toDouble()}",
          "longitude": "${coordenadas.getCoordenadas.longitude.toDouble()}",
          "telefono": "${telefonoController.text}",
        
          "url_foto_perfil": imagenPerfil != null? "${base64Encode(imagenPerfil.readAsBytesSync())}":"no",
          "url_foto_portada": imagenPortada != null ? "${base64Encode(imagenPortada.readAsBytesSync())}":"no",
          "estado": "no_disponible"
        },
        table: 'sucursales',
        token: pref.token
    );
    if (_respuesta['message'] == "expiro") {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('IniciarSesion');
      alerta(context,
          titulo: 'alerta',
          code: false,
          contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
      await funciones.closeSection(context);
    }else{}
    if (_respuesta['message'] == "false") {
       Navigator.pop(context);
      print(_respuesta.toString() + '--Errors--');
      dynamic res = json.encode(_respuesta);

      print(res);
      var respModel = errorsFormModelFromJson(res);
      List<Widget> errors = [];
      respModel.errors.forEach((key, value) {
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
                    style: TextStyle(color: verde, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    value.join(),
                    overflow: TextOverflow.clip,
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
          padding: const EdgeInsets.only(top: 25.0, right: 5),
          child: Container(
            width: 56,
            height: 56,
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.black26,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_rounded,
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
    }else{}

    if (_respuesta['message'] == "true") {
      Map _respuesta = await http.getMethod(context: context, table: 'sucursales', token: pref.token);

      print(_respuesta);
      if (_respuesta['message'] == "expiro") {
        
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
       await funciones.closeSection(context);
       return alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
       
      }
      if (_respuesta['message'] == "true") {
        var respModel;
        try{
           respModel  = respSucursalFromJson(_respuesta['resp']);
        }catch(e){
          Navigator.pop(context);
          return alerta(context,code: false,contenido: 'Fallo en el modelo: $e');
        }
      
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.of(context).pushNamed('SucursalAsistente',arguments: {"data": respModel.data.data});
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        return alerta(context, contenido: Text('Error'), acciones: Container());
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
  }

  _submitUpDate() async {
    if (!formKey.currentState.validate()) {
      return null;
    }
    load(context);
    Map _respuesta = await http.putMethod(
      context: context,
      body: {
        "nombre": "${nombreController.text}",
        "direccion": "${coordenadas.getDireccion.toString()}",
        "latitude": "${coordenadas.getCoordenadas.latitude.toDouble()}",
        "longitude": "${coordenadas.getCoordenadas.longitude.toDouble()}",
        "telefono": "${telefonoController.text}",
        "id_aliado": "${pref.id_aliado}",
        "url_foto_perfil": imagenPerfil != null? "${base64Encode(imagenPerfil.readAsBytesSync())}":"no",
        "url_foto_portada": imagenPortada != null ? "${base64Encode(imagenPortada.readAsBytesSync())}":"no",
        "estado": "no_disponible"
      },
      table: 'sucursales',
      id: element['data'].id,
      token: pref.token,
    );
    if (_respuesta['message'] == "expiro") {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      }

    if (_respuesta['message'] == "false") {
       Navigator.pop(context);
      print(_respuesta.toString() + '---------------------------------Bad');
      dynamic res = json.encode(_respuesta);

      print(res);
      var respModel = errorsFormModelFromJson(res);
      List<Widget> errors = [];
      respModel.errors.forEach((key, value) {
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
                    style: TextStyle(color: verde, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Container(
                width: size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    value.join(),
                    overflow: TextOverflow.clip,
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
          padding: const EdgeInsets.only(top: 25.0, right: 5),
          child: Container(
            width: 56,
            height: 56,
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.black26,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_rounded,
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

    if (_respuesta['message'] == "true") {
     Map _respuesta = await http.getMethod(
      context: context,
      table: 'sucursales/${pref.id_sucursal}',
      token: pref.token);

      print(_respuesta);
      if (_respuesta['message'] == "expiro") {
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      }
      if (_respuesta['message'] == "true") {
        var respModel =  respuestaSucursalAsistenteFromJson(_respuesta['resp']);

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.of(context).pushNamed( 'SucursalAsistente', arguments: {"dato": respModel.data});
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        return alerta(context, contenido: Text('Error'), acciones: Container());
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
  }
}
