import 'package:flutter/material.dart';

import 'package:traelo_app/src/utils/Global.dart';

class BalanceAlliado extends StatefulWidget {
  @override
  _BalanceAlliadoState createState() => _BalanceAlliadoState();
}

class _BalanceAlliadoState extends State<BalanceAlliado> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        title: Text(
          "Balance",
          style: TextStyle(
            color: Colors.black,
            fontSize: orientacion == Orientation.portrait
                ? size.width * 0.045
                : size.width * 0.03,
          ),
        ),
        elevation: 0.0,
      ),
      body: tabBar(context),
    );
  }

  Widget tabBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lado = MediaQuery.of(context).orientation;

    return Column(
      children: [
        SizedBox(
            height: lado == Orientation.portrait
                ? size.height * 0.01
                : size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  page = 0;
                });
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        page == 0
                            ? 'Pendientes por Pagar'
                            : 'Pendientes por Pagar',
                        style:
                            TextStyle(color: page == 0 ? verde : Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: page == 0
                          ? indicador(context)
                          : indicadorGris(context),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  page = 1;
                });
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        page == 1 ? 'Pagadas' : 'Pagadas',
                        style:
                            TextStyle(color: page == 1 ? verde : Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: page == 1
                          ? indicador(context)
                          : indicadorGris(context),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          // color: Colors.amber,
          height: size.height < 296
              ? size.height * 0.5
              : size.height < 383
                  ? size.height * 0.6
                  : size.height * 0.7,

          color: Colors.amber,
          width: double.infinity,
          child: page == 0
              ? page0(context)
              : page == 1
                  ? page1(context)
                  : Container(),
        )
      ],
    );
  }

  page0(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lado = MediaQuery.of(context).orientation;
    return Scaffold(
      // backgroundColor: Colors.black,
      // backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            children: [
              cardGrande(
                context: context,
                precio: '\$ 20,000',
                subtitulo: 'Villa Grande Mz 14 Lt 4',
                titulo: 'Orden D001',
              ),
              cardGrande(
                context: context,
                precio: '\$ 54,00',
                subtitulo: 'Olaya herrera - Cll 12',
                titulo: 'Orden C999',
              ),
              cardGrande(
                context: context,
                precio: '\$ 54,00',
                subtitulo: 'Olaya herrera - Cll 12',
                titulo: 'Orden C999',
              ),
              cardGrande(
                context: context,
                precio: '\$ 54,00',
                subtitulo: 'Olaya herrera - Cll 12',
                titulo: 'Orden C999',
              ),
              cardGrande(
                context: context,
                precio: '\$ 54,00',
                subtitulo: 'Olaya herrera - Cll 12',
                titulo: 'Orden C999',
              ),
              cardGrande(
                context: context,
                precio: '\$ 54,00',
                subtitulo: 'Olaya herrera - Cll 12',
                titulo: 'Orden C999',
              ),
              cardGrande(
                context: context,
                precio: '\$ 54,00',
                subtitulo: 'Olaya herrera - Cll 12',
                titulo: 'Orden C999',
              ),
              cardGrande(
                context: context,
                precio: '\$ 54,00',
                subtitulo: 'Olaya herrera - Cll 12',
                titulo: 'Orden C999',
              ),
              cardGrande(
                context: context,
                precio: '\$ 54,00',
                subtitulo: 'Olaya herrera - Cll 12',
                titulo: 'Orden C999',
              ),
              cardGrande(
                context: context,
                precio: '\$ 54,00',
                subtitulo: 'Olaya herrera - Cll 12',
                titulo: 'Orden C999',
              ),
            ],
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              total(context: context, subtitulo: 'total', titulo: '\$ 74.000'),
            ],
          )
        ],
      ),
    );
  }

  page1(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lado = MediaQuery.of(context).orientation;
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            children: <Widget>[
              cardGrande(
                context: context,
                precio: '\$ 120,000',
                subtitulo: 'San Jose de los Campanos - Cll 5 - M#56-77',
                titulo: 'Orden C991',
              ),
              cardGrande(
                context: context,
                precio: '\$ 254,000',
                subtitulo: 'Los Calamares Mz 2 - Lt 18',
                titulo: 'Orden C889',
              ),
            ],
          ),
        ],
      )),
    );
  }

  Widget indicador(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(microseconds: 500),
      color: verde,
      width: size.width * 0.4,
      height: size.height / 450,
    );
  }

  Widget indicadorGris(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(microseconds: 500),
      color: Colors.grey,
      width: size.width * 0.4,
      height: size.height / 450,
    );
  }

  Widget cardGrande(
      {BuildContext context,
      String precio,
      String titulo,
      String subtitulo,
      Color colorBoton,
      Color colorTexto,
      String nombreBoton}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(children: [
      Container(
        width: orientation == Orientation.portrait ? size.width : size.width,
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                    width: size.width * .8,
                    child: Text(
                      titulo,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 436
                            ? 13.08
                            : size.width > 540
                                ? 16.2
                                : size.width * 0.03,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * .8,
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
        ),
      ),
      Column(
        children: [
          Container(
            width:
                orientation == Orientation.portrait ? size.width : size.width,
            height: 35,
            child: Card(
              color: Color.fromRGBO(251, 251, 251, 1),
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.01),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.8,
                          child: Text(
                            precio,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width < 436
                                    ? 13.08
                                    : size.width > 540
                                        ? 16.2
                                        : size.width * 0.03,
                                color: verde),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    ]);
  }

  Widget total({
    BuildContext context,
    String titulo,
    String subtitulo,
  }) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(children: [
      Container(
        width: orientation == Orientation.portrait ? size.width : size.width,
        height: 70,
        color: Colors.white,
        child: Card(
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(subtitulo,
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(103, 96, 95, 1))),
                Container(
                  width: size.width * 0.8,
                  // color: Colors.grey,
                  child: Text(
                    titulo,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
