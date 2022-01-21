import 'package:flutter/material.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/provider/postDirecciones.dart';

class Direccion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
  
   int variable = 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(19, 166, 7, 1)),
        backgroundColor: Color.fromRGBO(255, 241, 1, 1),
        title: Text(
          "Direccion",
          style: TextStyle(
            color: Color.fromRGBO(19, 166, 7, 1),
            fontSize: 15.0,
          ),
        ),
        elevation: 0.0,
      ),
    
      body: stak(context),
    );
  }

  Widget stak(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Color.fromRGBO(232, 232, 232, 1)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: boton(context),
            ),
          
            Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                texto(context),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: tarjetas(context),
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget texto(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Cerca de Mi'),
        ),
        FlatButton(
            onPressed: () {},
            child: Text(
              'Ver Todo',
              style: TextStyle(color: Colors.green),
            ))
      ],
    );
  }

  Widget tarjetas(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
         tarjetasBlancas(context),
         tarjetasBlancas(context),
         tarjetasBlancas(context),
         tarjetasBlancas(context),
         tarjetasBlancas(context),
         tarjetasBlancas(context),
         tarjetasBlancas(context),
         tarjetasBlancas(context),
         tarjetasBlancas(context),
         tarjetasBlancas(context),
         tarjetasBlancas(context),
         tarjetasBlancas(context),
        ],
      ),
    );
  }

  Widget boton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: orientation == Orientation.portrait
          ? size.height * 0.065
          : size.height * 0.11,
      width:
          orientation == Orientation.portrait ? size.width : size.width * 0.55,
      child: RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: Color.fromRGBO(245, 241, 1, 1),
              ),
              Text(
                'Direccion',
                style: TextStyle(
                    fontSize: orientation == Orientation.portrait
                        ? size.height * 0.017
                        : size.height * 0.030,
                    color: Colors.white),
              ),
            ],
          ),
          color: Color.fromRGBO(19, 166, 7, 1),
          onPressed: () {
            Navigator.of(context).pushNamed('');
          }),
    );
  }

  Widget tarjetasBlancas(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: orientation == Orientation.portrait
            ? size.width * 0.45
            : size.width * 0.25,
        height: orientation == Orientation.portrait
            ? size.height * 0.15
            : size.height * 0.27,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
