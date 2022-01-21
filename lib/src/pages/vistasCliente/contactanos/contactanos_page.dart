import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';

class Contactanos extends StatelessWidget {
  int variable = 0;
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[camposDeTexto(context)],
        ),
      ),
    );
  }
}

// Widget texto(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(40.0),
//     child: Center(
//         child: Text('Genera Un Ticket',
//             style: TextStyle(
//               color: Colors.grey,
//             ))),
//   );
// }

Widget camposDeTexto(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.03,
        ),
        Center(
            child: Text('Genera Un Ticket',
                style: TextStyle(
                  color: Colors.grey,
                ))),
        SizedBox(
          height: size.height * 0.03,
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: "Problema de Ingreso",
              labelText: 'Asunto',
              border: InputBorder.none,
              labelStyle: TextStyle(color: Colors.black)),
        ),
        Divider(),
        TextFormField(
          decoration: InputDecoration(
              hintText: "Deje su mensaje",
              labelText: 'Mensaje',
              border: InputBorder.none,
              labelStyle: TextStyle(color: Colors.black)),
        ),

        SizedBox(   height: size.height*0.2,  ),
        boton(context)
      ],
    ),
  );
}

 Widget boton(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
     height: orientation == Orientation.portrait
                    ? size.height * 0.055
                    : size.height * 0.09 ,
     width: orientation == Orientation.portrait
                    ? size.width * 0.5
                    : size.width * 0.25,
      child: RaisedButton(
          
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Text(
            'ENVIAR',
            style: TextStyle(fontSize: orientation == Orientation.portrait
                    ? size.height * 0.020
                    : size.height * 0.030 , color: verde),
          ),
          color: amarillo,
          onPressed: () {}),
    );
  }
