import 'package:flutter/material.dart';

import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/elevacion_container.dart';

void main() => runApp(BalanceRepartidor());

class BalanceRepartidor extends StatefulWidget {
  @override
  _BalanceRepartidorState createState() => _BalanceRepartidorState();
}

class _BalanceRepartidorState extends State<BalanceRepartidor> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
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
        body: SingleChildScrollView(
            child: Column(
          children: [
          
            tabBar(context),
          ],
        )),
      ),
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
          color: Colors.amber,
          height: lado == Orientation.portrait
              ? size.height * 0.85
              : size.height * 0.75,
          width: double.infinity,
          child: page == 0
              ? page0(context)
              : page == 1 ? page1(context) : Container(),
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          cardPendientesPorPagar(
            context: context,
            precio: '\$ 20,000',
            subtitulo: 'Villa Grande Mz 14 Lt 4',
            titulo: 'Orden D001',
          ),
          cardPendientesPorPagar(
            context: context,
            precio: '\$ 54,00',
            subtitulo: 'Olaya herrera - Cll 12',
            titulo: 'Orden C999',
          ),
          SizedBox(
            height: size.height * 0.3,
          ),
          total(context: context, subtitulo: 'total', titulo: '\$ 74.000'),
          SizedBox(
            height: lado == Orientation.portrait
                ? size.height * 0.020
                : size.height * 0.040,
          ),
        ],
      )),
    );
  }

  page1(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final lado = MediaQuery.of(context).orientation;
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            children: <Widget>[
              cardPagadas(
                context: context,
                precio: '\$ 120,000',
                subtitulo: 'San Jose de los Campanos - Cll 5 - M#56-77',
                titulo: 'Orden C991',
              ),
              cardPagadas(
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

  Widget cardPagadas(
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
        width:
            orientation == Orientation.portrait ? size.width : size.width,
        height: orientation == Orientation.portrait
            ? size.height * 0.130
            : size.height * 0.250,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 
                  Text(
                    titulo,
                    style: TextStyle(
                      
                      fontSize: orientation == Orientation.portrait
                          ? size.height * 0.021
                          : size.height * 0.045,
                    ),
                  ),
                  Container(
                    width:orientation == Orientation.portrait?
                    size.width*0.73:size.width*0.8,
                    child: Text(subtitulo,
                    overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: orientation == Orientation.portrait
                                ? size.height * 0.016
                                : size.height * 0.03,
                            color: Color.fromRGBO(103, 96, 95, 1))),
                  ),
                ],
              ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.check_circle_outline,color: verde,size:orientation == Orientation.portrait?
                      size.width*0.08:size.width*0.045,
                      ),
                   ],
                 )
            ],
          ),
        ),
      ),
      Container(
        width:
            orientation == Orientation.portrait ? size.width : size.width,
        height: orientation == Orientation.portrait
            ? size.height * 0.05
            : size.height * 0.090,
        color: Color.fromRGBO(251, 251, 251, 1),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           
              Row(
                // crossAxisAlignment: CrossAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    precio,
                    style: TextStyle(
                      
                        fontSize: orientation == Orientation.portrait
                            ? size.height * 0.025
                            : size.height * 0.045,
                        color: verde),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Elevacion(),
    ]);
  }
  
  Widget cardPendientesPorPagar(
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
        width:
            orientation == Orientation.portrait ? size.width : size.width,
        height: orientation == Orientation.portrait
            ? size.height * 0.130
            : size.height * 0.250,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             
              Text(
                titulo,
                style: TextStyle(
                  
                  fontSize: orientation == Orientation.portrait
                      ? size.height * 0.021
                      : size.height * 0.045,
                ),
              ),
              Container(
                width:orientation == Orientation.portrait?
                size.width*0.73:size.width*0.8,
                child: Text(subtitulo,
                overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? size.height * 0.016
                            : size.height * 0.03,
                        color: Color.fromRGBO(103, 96, 95, 1))),
              ),
            ],
          ),
        ),
      ),
      Container(
        width:
            orientation == Orientation.portrait ? size.width : size.width,
        height: orientation == Orientation.portrait
            ? size.height * 0.05
            : size.height * 0.090,
        color: Color.fromRGBO(251, 251, 251, 1),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           
              Row(
                // crossAxisAlignment: CrossAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    precio,
                    style: TextStyle(
                      
                        fontSize: orientation == Orientation.portrait
                            ? size.height * 0.025
                            : size.height * 0.045,
                        color: verde),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Elevacion(),
    ]);
  }

  Widget total({
    BuildContext context,
    String titulo,
    String subtitulo,
  }) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Stack(
      children: [
       
        Column(children: [
          Container(
            width:
                orientation == Orientation.portrait ? size.width : size.width,
            height: orientation == Orientation.portrait
                ? size.height * 0.100
                : size.height * 0.150,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(subtitulo,
                      style: TextStyle(
                          fontSize: orientation == Orientation.portrait
                              ? size.height * 0.016
                              : size.height * 0.025,
                          color: Color.fromRGBO(103, 96, 95, 1))),
                  Text(
                    titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: orientation == Orientation.portrait
                          ? size.height * 0.021
                          : size.height * 0.034,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
