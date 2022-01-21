import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';

class Antojos extends StatefulWidget {
  @override
  _AntojosState createState() => _AntojosState();
}

class _AntojosState extends State<Antojos> {
  int precio = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    int variable = 0;

    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(19, 166, 7, 1)),
        backgroundColor: Color.fromRGBO(255, 241, 1, 1),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mi Orden",
              style: TextStyle(
                color: Color.fromRGBO(19, 166, 7, 1),
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            barraVerde(context),

            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 6,
                right: 6
              ),
              child: campos(
                context: context,
                texto: 'Nombre del Negocio',
              ),
            ),
            Column(
              children: [
                camposUbicacion(
                  hintText: 'Barrio Villa Estrella Mz 10 Lt 40',
                  context: context,
                  texto: size.width < 249 ? 'D. Destino' : 'Direccion Destino',
                  icono: botonUbicacion(
                      context: context,
                      texto: size.width < 215 ? 'Ubica' : 'Ubicar',
                      horizontal: 0.3),
                  horizontal: 0.15,
                  vertical: 0.30,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0,
                left: 6,
                right: 6),
              child: campos(context: context, texto: 'Detalle del Pedido'),
            ),
            SizedBox(
              width: 10,
            ),
            camposUbicacion(
                hintText: 'Mi Trabajo',
                context: context,
                texto: size.width < 249 ? 'D. Origen' : 'Direccion Origen',
                icono: botonUbicacion(
                    context: context,
                    texto: size.width < 325 ? 'U. Actual' : 'Ubicacion Actual',
                    horizontal: 0.37),
                horizontal: 0.18,
                vertical: 0.40),
            SizedBox(
              height: orientation == Orientation.portrait
                  ? size.height * 0.05
                  : size.height * 0.075,
            ),

            presupuesto(context),
            SizedBox(
              height: orientation == Orientation.portrait
                  ? size.height * 0.05
                  : size.height * 0.075,
            ),
            botones(context)

            //
          ],
        ),
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: SingleChildScrollView(),
      ),
      
    );
  }

  Widget barraVerde(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          width: size.width,
          color: verde,
          child: Center(
              child: Text(
            'Información del Mandado',
            style: TextStyle(
                fontSize: 13,
                color: Colors.white),
          )),
        )
      ],
    );
  }

  Widget botonUbicacion({
    BuildContext context,
    String texto,
    double horizontal,
  }) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: size.height < 418 ? 20 : size.height * 0.037,
      width: size.width * horizontal,
      child: RaisedButton(
        color: verde,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(texto,
                style: TextStyle(
                    fontSize: size.width < 245 ? 8 : size.width < 395 ? 10 : 13,
                    color: Colors.white)),
            Icon(Icons.location_on,
                color: amarillo,
                size: size.width < 245 ? 8 : size.width < 395 ? 11 : 14),
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  Widget campos(
      {BuildContext context, String texto, double espacio, String hintText}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(texto),
            ],
          ),
          Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: hintText),
              ),
              Divider(),
            ],
          )
        ],
      ),
    );
  }

  Widget camposUbicacion(
      {BuildContext context,
      String texto,
      Widget icono,
      double horizontal,
      double vertical,
      String hintText}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(texto),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: size.width < 249
                        ? 70
                        : size.width < 339
                            ? size.width * 0.4
                            : size.width * 0.5,
                    child: TextFormField(
                        decoration: InputDecoration(hintText: hintText)),
                  ),
                ],
              )
            ],
          ),
          icono
        ],
      ),
    );
  }

  Widget presupuesto(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Presupuesto')],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onLongPress: () {
                setState(() {
                  precio -= precio;
                });
              },
              onTap: () {
                setState(() {
                  precio -= 100;
                });
              },
              child: Image(
                  width: orientation == Orientation.portrait
                      ? size.width / 13
                      : size.width / 25,
                  image: AssetImage(
                    'assets/Min.png',
                  )),
            ),
            //   Container(
            //     height: orientation == Orientation.portrait
            // ? size.height * 0.03
            // : size.height * 0.05,
            // width:  orientation == Orientation.portrait
            // ? size.width * 0.05
            // : size.width * 0.03,
            //     child: RaisedButton(onPressed: () {

            //       setState(() {
            //         precio += 1000;
            //       });
            //     }),
            //   ),

            SizedBox(
              width: orientation == Orientation.portrait
                  ? size.width * 0.05
                  : size.width * 0.03,
            ),

            Text(' \$${precio.toString()}'),
            SizedBox(
              width: orientation == Orientation.portrait
                  ? size.width * 0.05
                  : size.width * 0.03,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  precio += 551650000;
                });
              },
              child: Image(
                  width: orientation == Orientation.portrait
                      ? size.width / 15
                      : size.width / 25,
                  image: AssetImage('assets/Add.png')),
            ),
            //   Container(

            //     // height: orientation == Orientation.portrait
            // // ? size.height * 0.03
            // // : size.height * 0.05,
            // // width:  orientation == Orientation.portrait
            // // ? size.width * 0.05
            // // : size.width * 0.03,
            //     child: RaisedButton(

            //       shape: Border(
            //         // right: BorderSide(width: 3.0, ),
            //       ),
            //       child:Center(child: Icon(Icons.remove,size: 20,)),
            //       onPressed: () {
            //       setState(() {
            //         precio -= precio;
            //       });

            //     }),
            //   )
          ],
        )
      ],
    );
  }

  Widget botones(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: size.height * 0.045,
            width: size.width < 209 ? size.width * 0.38 : size.width * 0.4,
            child: RaisedButton(
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'SIGUIENTE',
                  style: TextStyle(
                      fontSize:size.width < 209?8: size.width < 257 ? 10 : 12, color: verde),
                ),
                color: amarillo,
                onPressed: () {}),
          ),
          Container(
            height: size.height * 0.045,
            width: size.width < 209 ? size.width * 0.38 : size.width * 0.4,
            child: RaisedButton(
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'CANCELAR',
                  style: TextStyle(
                      fontSize: size.width < 209?8: size.width < 257 ? 10 : 12,
                      color: Colors.white),
                ),
                color: rojo,
                onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
