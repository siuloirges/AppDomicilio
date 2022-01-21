import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/cardPequenna/cardPequenna.dart';

class OrdenesAdminPage extends StatefulWidget {
  @override
  _OrdenesAdminPageState createState() => _OrdenesAdminPageState();
}

class _OrdenesAdminPageState extends State<OrdenesAdminPage> {
  num buscar = 0;
// ScrollController _scrollController = new ScrollController();
  TextEditingController a1Controller = new TextEditingController();
  TextEditingController b2Controller = new TextEditingController();
  TextEditingController c3Controller = new TextEditingController();
  TextEditingController d4Controller = new TextEditingController();

  FocusNode a1Focus = new FocusNode();
  FocusNode b2Focus = new FocusNode();
  FocusNode c3Focus = new FocusNode();
  FocusNode d4Focus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: amarillo,
        iconTheme: IconThemeData(color: verde),
        title: Text(
          'Ordenes',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Detalles',
                  style: TextStyle(
                      color: verde, fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            size.width > 800
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: size.width > 912
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceAround,
                        children: [
                          CardPequenna(
                            titulo: 'Total de ordenes',
                            cantidad: 500,
                            colorCard: amarillo,
                            colorTitulo: verde,
                            colorNumero: verde,
                            image: 'assets/order.png',
                          ),
                          size.width > 912
                              ? SizedBox(
                                  width: 60,
                                )
                              : Container(),
                          CardPequenna(
                            titulo: 'Oredenes finalizadas',
                            cantidad: 235,
                            colorCard: verde,
                            colorTitulo: blanco,
                            colorNumero: amarillo,
                            image: 'assets/tick.png',
                            notificacion: notificacion(
                                color: verde, hero: '1', context: context),
                          ),
                          size.width > 912
                              ? SizedBox(
                                  width: 60,
                                )
                              : Container(),
                          CardPequenna(
                            titulo: 'Ordenes en transito',
                            colorCard: Colors.blue,
                            colorTitulo: blanco,
                            colorNumero: blanco,
                            image: 'assets/reloj.png',
                            notificacion: notificacion(
                                color: Colors.blue,
                                hero: '2',
                                context: context),
                            cantidad: 134,
                          ),
                          size.width > 912
                              ? SizedBox(
                                  width: 60,
                                )
                              : Container(),
                          CardPequenna(
                            titulo: 'Ordenes canceladas',
                            cantidad: 131,
                            colorCard: rojo,
                            colorTitulo: blanco,
                            colorNumero: blanco,
                            image: 'assets/basura.png',
                            notificacion: notificacion(
                                color: rojo, hero: '3', context: context),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width < 752
                                ? 75.2
                                : size.width < 752
                                    ? 75.2
                                    : size.width * 0.1,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                color: amarillo,
                                child: Center(
                                  child: Text(
                                    'Hoy',
                                    style: TextStyle(
                                        color: verde,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ],
                  )
                : size.width > 650
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CardPequenna(
                                titulo: 'Total de ordenes',
                                cantidad: 500,
                                colorCard: amarillo,
                                colorTitulo: verde,
                                colorNumero: verde,
                                image: 'assets/order.png',
                              ),
                              CardPequenna(
                                titulo: 'Oredenes finalizadas',
                                cantidad: 235,
                                colorCard: verde,
                                colorTitulo: blanco,
                                colorNumero: amarillo,
                                image: 'assets/tick.png',
                                notificacion: notificacion(
                                    color: verde, hero: '1', context: context),
                              ),
                              CardPequenna(
                                titulo: 'Ordenes en transito',
                                colorCard: Colors.blue,
                                colorTitulo: blanco,
                                colorNumero: blanco,
                                image: 'assets/reloj.png',
                                notificacion: notificacion(
                                    color: Colors.blue,
                                    hero: '2',
                                    context: context),
                                cantidad: 134,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    size.width < 752 ? 75.2 : size.width * 0.1,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    color: amarillo,
                                    child: Center(
                                      child: Text(
                                        'Hoy',
                                        style: TextStyle(
                                            color: verde,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CardPequenna(
                                titulo: 'Ordenes canceladas',
                                cantidad: 131,
                                colorCard: rojo,
                                colorTitulo: blanco,
                                colorNumero: blanco,
                                image: 'assets/basura.png',
                                notificacion: notificacion(
                                    color: rojo, hero: '3', context: context),
                              ),
                            ],
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CardPequenna(
                                titulo: 'Total de ordenes',
                                cantidad: 500,
                                colorCard: amarillo,
                                colorTitulo: verde,
                                colorNumero: verde,
                                image: 'assets/order.png',
                              ),
                              CardPequenna(
                                titulo: 'Oredenes finalizadas',
                                cantidad: 235,
                                colorCard: verde,
                                colorTitulo: blanco,
                                colorNumero: amarillo,
                                image: 'assets/tick.png',
                                notificacion: notificacion(
                                    color: verde, context: context),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    size.width < 752 ? 75.2 : size.width * 0.1,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    color: amarillo,
                                    child: Center(
                                      child: Text(
                                        'Hoy',
                                        style: TextStyle(
                                            color: verde,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CardPequenna(
                                titulo: 'Ordenes en transito',
                                colorCard: Colors.blue,
                                colorTitulo: blanco,
                                colorNumero: blanco,
                                image: 'assets/reloj.png',
                                notificacion: notificacion(
                                    color: Colors.blue,
                                    hero: '2',
                                    context: context),
                                cantidad: 134,
                              ),
                              CardPequenna(
                                titulo: 'Ordenes canceladas',
                                cantidad: 131,
                                colorCard: rojo,
                                colorTitulo: blanco,
                                colorNumero: blanco,
                                image: 'assets/basura.png',
                                notificacion: notificacion(
                                    color: rojo, hero: '3', context: context),
                              ),
                            ],
                          ),
                        ],
                      ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: stackAcciones(
                  context: context,
                  colorAccion: verde,
                  texoAccion: 'Consultar'),
            ),
            SizedBox(
              height: 15,
            ),
            Container(child: buscar == 1 ? _ordenar(context) : null),
          ],
        ),
      ),
    );
  }

  Widget notificacion({BuildContext context, Color color, String hero}) {
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
              heroTag: hero,
              elevation: 5,
              onPressed: () {},
              backgroundColor: color ?? verde,
              splashColor: amarillo,
            ),
          ),
        ));
  }

  Widget stackAcciones(
      {BuildContext context,
      Color colorAccion,
      Color colorTextoAccion,
      String texoAccion,
      Color colorIconoAccion,
      String image,
      String ruta}) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Container(
          width: _size.width > 447 ? 178.8 : _size.width * 0.4,
          height: _size.width > 447 ? 117.1 : _size.width * 0.25,
          // color: Colors.black,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _size.width > 439 ? 109.75 : _size.width * 0.25,
                    height: _size.width > 439 ? 81.215 : _size.width * 0.185,
                    child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              color: colorIconoAccion ?? verde,
                              width:
                                  _size.width > 439 ? 43.9 : _size.width * .1,
                              image: AssetImage(
                                image ?? 'assets/notification.png',
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(ruta);
                        },
                        child: Container(
                          width:
                              _size.width > 447 ? 156.45 : _size.width * 0.35,
                          height: _size.width > 447 ? 44.7 : _size.width * 0.1,
                          child: Card(
                              elevation: 3,
                              shadowColor: Colors.grey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    texoAccion ?? '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: _size.width > 447
                                            ? 13.41
                                            : _size.width * 0.03,
                                        color: colorTextoAccion ?? verde,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      topRight: Radius.circular(25))),
                              color: colorAccion ?? amarillo),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _ordenar(BuildContext context) {
    return Column(
      children: [
        Text('Ingrese el Numero de Orden'),
        SizedBox(
          height: 30,
        ),
        Container(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                child: Card(
                  child: TextFormField(
                    // maxLength: 1,
                    // enableInteractiveSelection: false,
                    autofocus: true,
                    controller: a1Controller,
                    focusNode: a1Focus,
                    onFieldSubmitted: (value) => b2Focus.requestFocus(),

                    // maxLengthEnforced: true,
                    // maxLength: 1,
                    // maxLengthEnforced: false,
                    // maxLengthEnforced: fu  1,
                    //  autofocus:a1Controller.text.isEmpty?true:false ,

                    textAlign: TextAlign.center,
                    decoration: InputDecoration(

                        // helperMaxLines: 1,
                        border: InputBorder.none,
                        hintText: 'A'),
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text('-'),
              SizedBox(
                width: 4,
              ),
              Container(
                height: 40,
                width: 40,
                child: Card(
                  child: TextFormField(
                    onFieldSubmitted: (value) => c3Focus.requestFocus(),
                    controller: b2Controller,

                    focusNode: b2Focus,
                    // maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '0'),
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                height: 40,
                width: 40,
                child: Card(
                  child: TextFormField(
                    onFieldSubmitted: (value) => d4Focus.requestFocus(),
                    // autofocus:b2 != null?true:false ,
                    controller: c3Controller,
                    // maxLength: 1,
                    focusNode: c3Focus,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '0'),
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                height: 40,
                width: 40,
                child: Card(
                  child: TextFormField(
                    // onFieldSubmitted: (value) =>d4Focus.requestFocus(),
                    focusNode: d4Focus,

                    controller: d4Controller,
                    // maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '0'),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(width: 200, child: Divider()),
        _movimientos(context)
      ],
    );
  }

  Widget _movimientos(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('detallesDeLaOrdenAdmin');
      },
      child: Container(
        height: _size.height * .2,
        width: _size.width * .99,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: _size.height / 1.1,
                    width: _size.width / 1.1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: _size.width / 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: _size.height,
                                    color: amarillo,
                                    // height: ma,
                                    width: 2,
                                  ),
                                  Container(
                                    height: _size.height,
                                    color: amarillo,
                                    // height: ma,
                                    width: 2,
                                  )
                                ],
                              ),
                              SingleChildScrollView(child: item(context)),
                              Column(
                                children: [
                                  Container(
                                    color: Color.fromRGBO(248, 248, 248, 1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          // color:amarillo,
                                          height: _size.width / 9,
                                          width: _size.width / 1.3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Fecha',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey)),
                                              Text('Accion',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey)),
                                              Text('STATUS',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget item(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Column(children: [
          SizedBox(
            height: _orientacion == Orientation.portrait
                ? _size.height / 15
                : _size.height / 4,
          ),
          datos(context),
        ]),
      ],
    );
  }

  Widget datos(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('D-002'),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text('Leonardo'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    'Cancelada',
                    style: TextStyle(color: rojo),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: _size.height / 30,
            )
          ],
        ),
        indicador(context)
      ],
    );
  }

  Widget indicador(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: verde,
              radius: 5,
              // width: 300,
              // height: 10,
            ),
            CircleAvatar(
              backgroundColor: verde,
              radius: 5,
              // width: 300,
              // height: 10,
            ),
          ],
        ),
        SizedBox(
          height: _size.height / 15,
        )
      ],
    );
  }
}
