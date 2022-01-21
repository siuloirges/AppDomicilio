import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/cardBlancaScroll/prueba.dart';
import 'package:traelo_app/src/utils/Widgets/cardPequenna/cardPequenna.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class ConsultarRepartidorAdministrador extends StatefulWidget {
  const ConsultarRepartidorAdministrador({Key key}) : super(key: key);

  @override
  _ConsultarRepartidorAdministradorState createState() =>
      _ConsultarRepartidorAdministradorState();
}

class _ConsultarRepartidorAdministradorState
    extends State<ConsultarRepartidorAdministrador> {
  String _vista = 'Seleccione ';
  TextEditingController buscarController = new TextEditingController();
  var formKey = GlobalKey<FormState>();
  Validaciones validar = new Validaciones();
  // ScrollController _scrollController = new ScrollController();
  bool consulta = false;
  bool bloqueado = true;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consultar Repartidor',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: _size.height * 0.05),
            Text(
              'Detalles',
              style: TextStyle(
                  color: verde, fontSize: 25, fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: _size.width > 589
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceAround,
              children: [
                CardPequenna(
                    notificacion: notificacion(
                        context: context, color: verde, herotag: 'btn1'),
                    heroTag: 'bt1',
                    cantidad: 15,
                    titulo: 'TOTAL DE REPARTIDORES',
                    colorCard: amarillo,
                    colorNumero: verde,
                    colorTitulo: verde,
                    image: 'assets/notificationp.png'),
                _size.width > 589
                    ? SizedBox(
                        width: 28,
                      )
                    : Container(),
                CardPequenna(
                    notificacion:
                        notificacion(context: context, herotag: 'btn2'),
                    heroTag: '7',
                    cantidad: 74,
                    titulo: 'REPARTIDORES ACTIVOS',
                    colorCard: verde,
                    colorNumero: amarillo,
                    colorTitulo: Colors.white,
                    image: 'assets/notificationp.png'),
                _size.width > 589
                    ? SizedBox(
                        width: 28,
                      )
                    : Container(),
                CardPequenna(
                    // notificacion: notificacion(context: context, color: rojo),
                    heroTag: 'bt3',
                    cantidad: 8,
                    titulo: 'REPARTIDORES INACTIVOS',
                    colorCard: Colors.grey,
                    colorNumero: Colors.white,
                    colorTitulo: Colors.white,
                    image: 'assets/notificationp.png'),
              ],
            ),
            SizedBox(height: _size.height * 0.07),
            Column(
              children: [
                consultarPor(context),
                SizedBox(height: _size.height * 0.03),
                Form(key: formKey, child: ingresarDocumento(context)),
                SizedBox(height: _size.height * 0.0),
              ],
            ),
            SizedBox(height: _size.height * 0.09),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                crearBoton1(
                    colorBoton: rojo,
                    colorTexto: Colors.white,
                    context: context,
                    texto: 'CANCELAR'),
                SizedBox(width: _size.width * 0.05),
                crearBoton2(
                    colorBoton: amarillo,
                    colorTexto: verde,
                    context: context,
                    texto: 'CONSULTAR'),
                SizedBox(height: _size.height * 0.05),
              ],
            ),
            SizedBox(height: _size.height * 0.05),
            consulta == true
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          child: alertConsultarRepartidor(context),
                        ),
                      );
                    },
                    child: PruebaWidget(
                      alto: 0.3,
                      anchoPequenno: true,
                      pagConsultar: true,
                      // pagActualizar: true,
                      datos: Column(
                        children: <Widget>[
                          Item(
                            texto1: 'D-002',
                            texto2: 'Leonardo',
                            texto3: bloqueado == true ? 'Bloqueado' : 'Activo',
                            colorT3: bloqueado == true ? rojo : verde,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget notificacion({BuildContext context, Color color, String herotag}) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Positioned(
        left: _size.width > 589 ? 101.55 : _size.width / 05.8,
        top: _size.width > 589 ? 14.725 : _size.width / 40,
        child: Container(
          height: _size.width > 589 ? 19.437 : _size.width * 0.033,
          width: _size.width > 589 ? 19.437 : _size.width * 0.033,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: herotag,
              elevation: 5,
              onPressed: () {},
              backgroundColor: color ?? verde,
              splashColor: amarillo,
            ),
          ),
        ));
  }

  Widget consultarPor(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Container(
      // color: verde,
      width: _size.width * 0.9,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Consultar Por ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize:
                            _size.width > 391 ? 17 : _size.width * 0.0452),
                  ),
                ],
              ),
              Container(width: _size.width * 0.7, child: _drowDow())
            ],
          ),
        ],
      ),
    );
  }

  Widget _drowDow() {
    final _lista = [
      'Documento de identificacion',
      'Nombre',
    ];
    return DropdownButton(
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: verde,
      ),
      items: _lista.map((String lista) {
        return DropdownMenuItem(value: lista, child: Text(lista));
      }).toList(),
      onChanged: (value) => {
        setState(() {
          _vista = value;
        })
      },
      hint: Text(_vista),
    );
  }

  Widget ingresarDocumento(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Container(
      // color: Colors.grey,
      width: _size.width * 0.7,

      child: Column(
        children: [
          Text(
              _vista == 'Nombre' ? 'Ingrese El Nombre' : 'Ingrese El Documento',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: _size.width > 391 ? 17 : _size.width * 0.045)),
          TextFormField(
            controller: buscarController,
            validator: _vista == 'Nombre'
                ? (value) => validar.validateName(value)
                : (value) => validar.validateNumerico(value),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Ingrese Aqui',
            ),
          )
        ],
      ),
    );
  }

  Widget crearBoton1(
      {BuildContext context,
      String texto,
      Color colorBoton,
      Color colorTexto}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: size.height > 762 ? 32.766 : size.height * 0.043,
      width: size.width > 333 ? 126.54 : size.width * 0.38,
      child: RaisedButton(
        elevation: 2,
        color: colorBoton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Text(texto ?? '',
            style: TextStyle(
                fontSize: size.width > 333
                    ? 14.985
                    : size.width < 251 ? 8 : size.width * 0.045,
                color: colorTexto)),
        onPressed: () {},
      ),
    );
  }

  Widget crearBoton2(
      {BuildContext context,
      String texto,
      Color colorBoton,
      Color colorTexto}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: size.height > 762 ? 32.766 : size.height * 0.043,
      width: size.width > 333 ? 126.54 : size.width * 0.38,
      child: RaisedButton(
        elevation: 2,
        color: colorBoton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Text(texto ?? '',
            style: TextStyle(
                fontSize: size.width > 333
                    ? 14.985
                    : size.width < 251 ? 8 : size.width * 0.045,
                color: colorTexto)),
        onPressed: () {
          setState(() {
            if (!formKey.currentState.validate()) return null;
            consulta = !consulta;
          });
        },
      ),
    );
  }

  Widget alertConsultarRepartidor(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20), right: Radius.circular(20))),
          title: Column(
            children: [
              Text(
                'Usuario',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: _size.width > 525 ? 26.25 : _size.width * 0.05),
              ),
              SizedBox(
                height: _size.width > 525 ? 10.5 : _size.width * 0.02,
              ),
              Text(
                'Informacion Del Usuario',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(156, 156, 156, 1),
                    fontSize: _size.width > 525 ? 18.375 : _size.width * 0.035),
              ),
              SizedBox(height: _size.width * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  fotoDePerfil(context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // SizedBox(height: _size.width * 0.045),
                      Container(
                        width: _size.width < 258
                            ? _size.width * 0.2
                            : _size.width < 258
                                ? _size.width * 0.23
                                : _size.width < 288
                                    ? _size.width * 0.3
                                    : _size.width * 0.4,
                        // color: Colors.grey,
                        child: Text(
                          'Yohan Blanco',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _size.width > 525
                                  ? 26.25
                                  : _size.width * 0.05),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              height:
                                  _size.width > 525 ? 21 : _size.width * 0.04,
                              width:
                                  _size.width > 525 ? 105 : _size.width * 0.2,
                              child: RaisedButton(
                                color: rojo,
                                onPressed: () {},
                                shape: StadiumBorder(),
                                child: Text('Cliente',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _size.width > 525
                                            ? 15.75
                                            : _size.width * 0.03)),
                              )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: _size.width > 525 ? 10.5 : _size.width * 0.02),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: _size.width > 525 ? 42 : _size.width * 0.08,
                        width: _size.width > 525 ? 42 : _size.width * 0.08,
                        child: FloatingActionButton(
                            heroTag: 'btn1',
                            onPressed: () {},
                            backgroundColor: blanco,
                            elevation: 4,
                            child: Image(
                              width: _size.width > 525
                                  ? 26.25
                                  : _size.width * 0.05,
                              image:
                                  AssetImage('assets/correo-electronico.png'),
                            )),
                      ),
                      SizedBox(
                          width:
                              _size.width > 525 ? 15.75 : _size.width * 0.03),
                      Container(
                        // color: Colors.grey,
                        width: _size.width < 224
                            ? _size.width * 0.25
                            : _size.width < 264
                                ? _size.width * 0.3
                                : _size.width < 296
                                    ? _size.width * 0.4
                                    : _size.width * 0.45,
                        child: Text('yohanblaro18@gmail.com',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: _size.width > 525
                                    ? 17.85
                                    : _size.width * 0.034)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: _size.width > 525 ? 10.5 : _size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: _size.width > 525 ? 42 : _size.width * 0.08,
                        width: _size.width > 525 ? 42 : _size.width * 0.08,
                        child: FloatingActionButton(
                            heroTag: 'btn2',
                            onPressed: () {},
                            backgroundColor: blanco,
                            elevation: 4,
                            child: Image(
                              width: _size.width > 525
                                  ? 26.25
                                  : _size.width * 0.05,
                              image: AssetImage('assets/telefono.png'),
                            )),
                      ),
                      SizedBox(
                          width:
                              _size.width > 525 ? 15.75 : _size.width * 0.03),
                      Container(
                        width: _size.width < 224
                            ? _size.width * 0.25
                            : _size.width < 264
                                ? _size.width * 0.3
                                : _size.width < 296
                                    ? _size.width * 0.4
                                    : _size.width * 0.45,
                        child: Text('3106404303',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: _size.width > 525
                                    ? 21
                                    : _size.width * 0.04)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: _size.width > 525 ? 10.5 : _size.height * 0.02,
                  ),
                ],
              ),
              Text(
                'Estatus',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(156, 156, 156, 1),
                    fontSize: _size.width > 525 ? 18.375 : _size.width * 0.035),
              ),
              Container(
                  height: _size.width > 525 ? 52.5 : _size.width * 0.1,
                  width: _size.width > 525 ? 252.5 : _size.width * 0.5,
                  child: RaisedButton(
                    color: bloqueado == true ? rojo : verde,
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20))),
                                title: Column(
                                  children: [
                                    Text(
                                      'Usuario',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: _size.width > 525
                                              ? 26.25
                                              : _size.width * 0.05),
                                    ),
                                    SizedBox(
                                      height: _size.width > 525
                                          ? 10.5
                                          : _size.width * 0.02,
                                    ),
                                    Text(
                                      'Informacion Del Usuario',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(156, 156, 156, 1),
                                          fontSize: _size.width > 525
                                              ? 18.375
                                              : _size.width * 0.035),
                                    ),
                                    SizedBox(
                                        height: _size.width > 525
                                            ? 10.5
                                            : _size.width * 0.02),
                                    Text(
                                      '¿Estas Seguro Que ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      bloqueado == true
                                          ? 'Deseas Bloquear a '
                                          : 'Deseas Desbloquear a ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'este usuaio?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                        height: _size.width > 525
                                            ? 10.5
                                            : _size.width * 0.02),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            width: _size.width > 525
                                                ? 84
                                                : _size.width * 0.16,
                                            height: _size.width > 525
                                                ? 63
                                                : _size.width * 0.12,
                                            child: RaisedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              color: rojo,
                                              child: Text('NO',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: _size.width >
                                                              525
                                                          ? 15.75
                                                          : _size.width * 0.03,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              shape: StadiumBorder(),
                                            )),
                                        Container(
                                            width: _size.width > 525
                                                ? 84
                                                : _size.width * 0.16,
                                            height: _size.width > 525
                                                ? 63
                                                : _size.width * 0.12,
                                            child: RaisedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    bloqueado = !bloqueado;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text('SI',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: verde,
                                                        fontSize:
                                                            _size.width > 525
                                                                ? 15.75
                                                                : _size.width *
                                                                    0.03,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                color: amarillo,
                                                shape: StadiumBorder()))
                                      ],
                                    )
                                  ],
                                ),
                              ));
                    },
                    shape: StadiumBorder(),
                    child: Text(bloqueado == true ? 'bloquear' : 'Desbloquear',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _size.width < 224
                              ? _size.width * 0.04
                              : _size.width > 525 ? 26.25 : _size.width * 0.05,
                        )),
                  ))
            ],
          )),
    );
  }

  Widget fotoDePerfil(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            backgroundColor: verde,
            child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/foto-gratis/repartidor-sobre-pared-amarilla-aislada_1368-72297.jpg?size=626&ext=jpg'),
                radius: _size.width > 525 ? 36.75 : _size.width * 0.07,
                backgroundColor: Colors.white),
            radius: _size.width > 525 ? 38.325 : _size.width * 0.073),
      ],
    );
  }
}
