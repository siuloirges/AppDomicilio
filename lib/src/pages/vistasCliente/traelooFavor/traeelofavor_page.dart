import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';

class Traeelofavor extends StatefulWidget {
  @override
  _AntojosState createState() => _AntojosState();
}

class _AntojosState extends State<Traeelofavor> {
  int precio = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    int variable = 0;

    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            barraVerde(context),
            espacio(context),

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
            campos(
                context: context,
                texto: 'Descipcion del Favor',
                hintText: 'Carta Para Fundacion Los Amberes '),
            espacio(context),

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
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(19, 166, 7, 1)),
        backgroundColor: Color.fromRGBO(255, 241, 1, 1),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Traeloo Favor",
              style: TextStyle(
                color: Color.fromRGBO(19, 166, 7, 1),
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: variable,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Inicio'),
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.work),
              title: Text('Cartera'),
              activeIcon: Icon(Icons.work)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Perfil'),
              activeIcon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }

  Widget barraVerde(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        Container(
          height: orientation == Orientation.portrait
              ? size.width * 0.090
              : size.width * 0.040,
          width: size.width,
          color: verde,
          child: Center(
              child: Text(
            'Información del favor',
            style: TextStyle(
                fontSize: orientation == Orientation.portrait
                    ? size.height * 0.016
                    : size.height * 0.03,
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
    // Orientation orientation = MediaQuery.of(context).orientation;
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
    // Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
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
    // Orientation orientation = MediaQuery.of(context).orientation;
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

  Widget espacio(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return SizedBox(
      height: orientation == Orientation.portrait
          ? size.height * 0.05
          : size.height * 0.06,
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
                  precio += 1000;
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
    // Orientation orientation = MediaQuery.of(context).orientation;
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
