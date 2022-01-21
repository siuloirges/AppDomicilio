import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';

// ignore: must_be_immutable
class Populares extends StatelessWidget {
  int variable = 0;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        title: Text(
          "Contactanos!",
          style: TextStyle(
            color: verde,
            fontSize: 15.0,
          ),
        ),
        elevation: 0.0,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: variable,
      //   backgroundColor: Colors.white,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         title: Text('Inicio'),
      //         activeIcon: Icon(Icons.home)),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.work),
      //         title: Text('Cartera'),
      //         activeIcon: Icon(Icons.work)),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle),
      //         title: Text('Perfil'),
      //         activeIcon: Icon(Icons.account_circle)),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: orientation == Orientation.portrait
            ? gridview(context: context, columnas: 2)
            : gridview(context: context, columnas: 3)
      ),
    );
  }

// Widget texto(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(40.0),
//     child: Center(
//         child: Text('Genera Un Ticket',
//             style: TextStyle(
//               color: Colors.grey,
//             ))),
//   );{}
// }

  Widget proveedor(
      {BuildContext context, String titulo, String subtitulo, Color fondo}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('proveedor');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              width: orientation == Orientation.portrait
                  ? size.width * 0.45
                  : size.width * 0.28,
              height: orientation == Orientation.portrait
                  ? size.height * 0.28
                  : size.height * 0.50,
              decoration: BoxDecoration(
                  color: fondo, borderRadius: BorderRadius.circular(8.0)),
            ),
            Positioned(
              left: 5.5,
              bottom: 0.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                        width: orientation == Orientation.portrait
                            ? size.width * 0.40
                            : size.width * 0.225,
                        height: orientation == Orientation.portrait
                            ? size.height * 0.05
                            : size.height * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only())),
                    Text(titulo,
                        style: TextStyle(
                          fontSize: orientation == Orientation.portrait
                              ? size.width * 0.04
                              : size.width * 0.023,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      subtitulo,
                      style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? size.width * 0.02
                            : size.width * 0.0115,
                      ),
                    )
                  ],
                ),
                width: orientation == Orientation.portrait
                    ? size.width * 0.405
                    : size.width * 0.264,
                height: orientation == Orientation.portrait
                    ? size.height * 0.1
                    : size.height * 0.18,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.only()),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget gridview({ BuildContext context, int columnas} ) {
    return GridView.count(
      crossAxisCount: columnas,
      children: <Widget>[
        proveedor(
            context: context,
            titulo: 'Delicones',
            subtitulo: 'Crespo',
            fondo: Colors.black),
        proveedor(
            context: context,
            titulo: 'Delicones',
            subtitulo: 'Crespo',
            fondo: Colors.green),
        proveedor(
            context: context,
            titulo: 'Delicones',
            subtitulo: 'Crespo',
            fondo: Colors.grey),
        proveedor(
            context: context,
            titulo: 'Delicones',
            subtitulo: 'Crespo',
            fondo: amarillo),
        proveedor(
            context: context,
            titulo: 'Delicones',
            subtitulo: 'Crespo',
            fondo: verde),
        proveedor(
            context: context,
            titulo: 'Delicones',
            subtitulo: 'Crespo',
            fondo: rojo),
        proveedor(
            context: context,
            titulo: 'Delicones',
            subtitulo: 'Crespo',
            fondo: verdeClaro),
        proveedor(
            context: context,
            titulo: 'Delicones',
            subtitulo: 'Crespo',
            fondo: gris),
        proveedor(
            context: context,
            titulo: 'Delicones',
            subtitulo: 'Crespo',
            fondo: scaffold)
      ],
    );
  }


}
