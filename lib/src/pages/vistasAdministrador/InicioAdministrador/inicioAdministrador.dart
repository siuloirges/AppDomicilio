import "package:flutter/material.dart";
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/cardPequenna/cardPequenna.dart';
import 'package:traelo_app/src/utils/Widgets/drawer/drawer.dart';
import 'package:traelo_app/src/utils/preferencias.dart';

class IniciAdministrador extends StatefulWidget {
  @override
  _IniciAdministradorState createState() => _IniciAdministradorState();
}

class _IniciAdministradorState extends State<IniciAdministrador> {
  PreferenciasUsuario pref = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    if (pref.ultima_pagina != 'inicioadministrador') {
      pref.ultima_pagina = 'inicioadministrador';
    }
    Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                setState(() {});
              })
        ],
        leading: Builder(builder: (context) {
          return IconButton(
              icon: Image(
                  // width: _size.width / 80,
                  image: AssetImage('assets/menu.png')),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        elevation: 0,
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hola, ',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              '${pref.nombre}',
              style:
                  TextStyle(color: Colors.black, fontSize: size.width * 0.05),
            ),
          ],
        ),
        centerTitle: true,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            //color: Colors.red,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.width > 766 ? 76.6 : size.width * 0.1,
                    ),
                    CircleAvatar(
                        backgroundColor: verde,
                        child: pref.url_foto_perfil != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    storage + pref.url_foto_perfil),
                                radius: size.width > 766
                                    ? 53.62
                                    : size.width * 0.07,
                                backgroundColor: Colors.white)
                            : Container(),
                        radius: size.width > 766 ? 55.978 : size.width * 0.073),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                height: size.width > 486 ? 43.74 : size.width * 0.09,
                width: size.width > 486 ? 121.5 : size.width * 0.25,
                // color: Colors.grey,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: size.width > 486
                                    ? 34.02
                                    : size.width * 0.07,
                                width: 90,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: verde,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text('Perfil',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('PerfilAdministrador');
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     CircleAvatar(
                    //       radius: size.width > 486 ? 38.88 : size.width * 0.08,
                    //       backgroundColor: blanco,
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
              SizedBox(
                width: size.width > 700 ? 35 : size.width * 0.05,
              )
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      drawer: MenuDesplegable(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  BuildOrdenesButtonHoy(
                    size: size,
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              buildCards(context),
              SizedBox(
                height: 50,
              ),
              BuildAnticiposPagos(
                size: size,
              ),
            ],
          ),
          BuildPQR(size: size)
        ],
      ),
    );
  }
}

Widget buildCards(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Row(
    mainAxisAlignment: size.width > 589
        ? MainAxisAlignment.center
        : MainAxisAlignment.spaceAround,
    children: [
      CardPequenna(
        colorNumero: amarillo,
        titulo: 'NUEVAS',
        colorTitulo: blanco,
      ),
      size.width > 589
          ? SizedBox(
              width: 28,
            )
          : Container(),
      CardPequenna(
        colorNumero: amarillo,
        titulo: 'PENDIENTES',
        colorTitulo: blanco,
      ),
      size.width > 589
          ? SizedBox(
              width: 28,
            )
          : Container(),
      CardPequenna(
        colorNumero: amarillo,
        titulo: 'FINALIZADAS',
        colorTitulo: blanco,
      )
    ],
  );
}

class BuildOrdenesButtonHoy extends StatelessWidget {
  const BuildOrdenesButtonHoy({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size.width > 700 ? 63 : size.width * 0.09),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ORDENES',
              style: TextStyle(
                  color: verde,
                  fontSize: size.width > 700 ? 35 : size.width * 0.05,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: size.width > 700 ? 210 : size.width * 0.3,
            ),
            Container(
                child: Container(
                    height: size.width > 700 ? 35 : size.width * 0.05,
                    width: size.width > 700 ? 155 : size.width * 0.22,
                    child: RaisedButton(
                      onPressed: () {},
                      color: amarillo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('HOY',
                          style: TextStyle(
                              color: verde,
                              fontSize:
                                  size.width > 700 ? 14 : size.width * 0.02,
                              fontWeight: FontWeight.bold)),
                    ))),
          ],
        ),
      ],
    );
  }
}

class BuildPQR extends StatelessWidget {
  const BuildPQR({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: size.width * 0.7,
                    height: size.height * 0.015,
                    //color: verde,
                  ),
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Container(
                        color: amarillo,
                        child: Container(
                          width: size.width * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BuildRaisenButton(
                                    dato: 20,
                                    etiqueta: 'NUEVAS',
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  BuildRaisenButton(
                                    dato: 8,
                                    etiqueta: 'PENDIENTES',
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  BuildRaisenButton(
                                    dato: 15,
                                    etiqueta: 'FINALIZADAS',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.18,
                  child: RaisedButton(
                    color: verde,
                    elevation: 5,
                    onPressed: () {},
                    child: Text(
                      'PQR',
                      style: TextStyle(
                        color: blanco,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    splashColor: amarillo,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BuildAnticiposPagos extends StatelessWidget {
  const BuildAnticiposPagos({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SOLICITUDES',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: verde,
              fontWeight: FontWeight.bold,
              fontSize: size.width > 700 ? 31.5 : size.width * 0.045),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: size.width > 700 ? 84 : size.width * 0.12,
                  height: size.width > 700 ? 84 : size.width * 0.12,
                  child: FloatingActionButton(
                    heroTag: 'bt4',
                    child: Text(
                      "5",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: size.width > 700 ? 35 : size.width * 0.05,
                      ),
                    ),
                    onPressed: () {},
                    backgroundColor: blanco,
                  ),
                ),
                SizedBox(
                  height: size.width > 700 ? 8.4 : size.width * 0.012,
                ),
                Text(
                  'ANTICIPOS',
                  style: TextStyle(
                    color: rojo,
                    fontSize: size.width > 700 ? 28 : size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              width: size.width > 700 ? 210 : size.width * 0.3,
              height: size.width > 700 ? 56 : size.width * 0.08,
              child: Card(
                color: verde,
                child: Center(
                  child: Text(
                    'VER SOLICITUDES',
                    style: TextStyle(
                      color: amarillo,
                      fontSize: size.width > 700 ? 17.5 : size.width * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: size.width > 700 ? 84 : size.width * 0.12,
                  height: size.width > 700 ? 84 : size.width * 0.12,
                  child: FloatingActionButton(
                    child: Text(
                      "15",
                      style: TextStyle(
                        color: verde,
                        fontSize: size.width > 700 ? 35 : size.width * 0.05,
                      ),
                    ),
                    onPressed: () {},
                    backgroundColor: blanco,
                  ),
                ),
                SizedBox(
                  height: size.width * 0.012,
                ),
                Text(
                  'PAGOS',
                  style: TextStyle(
                    color: verde,
                    fontSize: size.width > 700 ? 28 : size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class BuildCards extends StatelessWidget {
  const BuildCards({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardPequenna(
          heroTag: 'bt1',
          titulo: "NUEVAS",
          colorTitulo: blanco,
          colorCard: verde,
          cantidad: 50,
          colorNumero: amarillo,
          image: 'assets/notificationp.png',
        ),
        SizedBox(
          width: size.width * 0.02,
        ),
        CardPequenna(
          heroTag: 'bt2',
          titulo: "PENDIENTES",
          colorTitulo: blanco,
          colorCard: verde,
          cantidad: 35,
          colorNumero: amarillo,
          image: 'assets/reloj.png',
        ),
        SizedBox(
          width: size.width * 0.02,
        ),
        CardPequenna(
          heroTag: 'bt3',
          titulo: "FINALIZADAS",
          colorTitulo: blanco,
          colorCard: verde,
          cantidad: 60,
          colorNumero: amarillo,
          image: 'assets/tick.png',
        ),
      ],
    );
  }
}

class BuidAppBar extends StatelessWidget {
  const BuidAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          elevation: 0,
          backgroundColor: amarillo,
          title: Text(
            'Hola, Yohan',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: Builder(
            builder: (context) {
              return GestureDetector(
                child: Image.asset('assets/menu.png'),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class BuildRaisenButton extends StatelessWidget {
  final int dato;
  final String etiqueta;
  const BuildRaisenButton({
    Key key,
    @required this.dato,
    @required this.etiqueta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width * 0.15,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 5,
              color: blanco,
              onPressed: () {},
              child: Text(
                '$dato',
                style: TextStyle(
                  color: verde,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.055,
                ),
              )),
        ),
        Text(etiqueta,
            style: TextStyle(
              fontSize: size.width * 0.022,
              color: verde,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
