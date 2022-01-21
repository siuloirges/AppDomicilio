import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
// import 'package:traelo_app/src/utils/Widgets/elevacion_container.dart';

class OrdenAntojos extends StatelessWidget {
  Size size ;
  @override
  Widget build(BuildContext context) {
     size = MediaQuery.of(context).size;
    // Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    // int variable = 0;
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[cards(context)],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(19, 166, 7, 1)),
        backgroundColor: Color.fromRGBO(255, 241, 1, 1),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Orden Antojos",
              style: TextStyle(
                color: Color.fromRGBO(19, 166, 7, 1),
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
    );
  }

  Widget cards(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        cardsDosTextos(context),
        tarjetaTiempo(context),
        cardUnTexto(context:context,pedido: '1 Coca Cola 3 Litros Y Un Ponqué Bimbosad' ),
        tarjetaDomicilio(context: context, precio: '2220'),
        cardUnTextoYPrecio(context: context, precio: '5235'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.015,
              ),
              Text('Agregar un metodo de pago',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize:
                          size.width < 212 ? 12 : size.width < 256 ? 15 : 18)),
            ],
          ),
        ),
        metodoDePago(context),
        tarjetaFormaDePago(context: context, precio: '616'),
        botonFinalizar(context)
      ],
    );
  }

  Widget cardsDosTextos(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return Column(children: <Widget>[
      SizedBox(
        height: size.height * 0.008,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 17),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.015,
            ),
            Text('Negocio ',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
      Container(
        width: size.width,
        height: size.height < 509
            ? 50
            : size.height > 635 ? 60 : size.height * 0.09,
        color: Colors.white,
        child: Card(
          margin: const EdgeInsets.only(left: 0, right: 0, top: 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //  SizedBox( width: size.width*0.010, ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Negocio',
                        style: TextStyle(fontSize: 14),
                      ),
                      Container(
                        width: size.width < 195
                            ? 88
                            : size.width < 245
                                ? 138
                                : size.width < 295 ? 188 : 238,
                        child: Text('Despensa La Rochela',
                            style: TextStyle(
                                fontSize: 9,
                                color: Color.fromRGBO(103, 96, 95, 1))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget tarjetaTiempo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 19.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Servicio a Domicilio ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  )),
            ],
          ),
        ),
        Container(
          width: size.width,
          height: size.height < 509
              ? 40
              : size.height > 635 ? 50 : size.height * 0.08,
          color: Colors.white,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.all(0.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Tiempo estimado',
                        style: TextStyle(fontSize: 11),
                      ),
                      Text('40 Min',
                          style: TextStyle(
                            fontSize: 12,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

// Widget tarjetaMisOrdenes({BuildContext context}) {
//     final size = MediaQuery.of(context).size;
//     final orientacion = MediaQuery.of(context).orientation;

//     return Container(
//       width: size.width,
//       height: orientacion == Orientation.portrait
//           ? size.height * 0.08
//           : size.height * 0.18,
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               //  SizedBox( width: size.width*0.010, ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 3.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'ID Orden: D-001',
//                       style: TextStyle(
//                           fontSize: orientacion == Orientation.portrait
//                               ? size.height * 0.020
//                               : size.height * 0.036),
//                     ),
//                     Text('En Camino',
//                          style: TextStyle(
//                       fontSize: orientacion == Orientation.portrait
//                           ? size.height * 0.015
//                           : size.height * 0.026,
//                       color: Color.fromRGBO(103, 96, 95, 1))),

//                   ],
//                 ),
//               ),

//             ],
//           ),
//       ),
//     );
//   }

  Widget tarjetaDomicilio({BuildContext context, String precio}) {
    final size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          height: size.height < 509
              ? 50
              : size.height > 635 ? 60 : size.height * 0.09,
          color: Colors.white,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //  SizedBox( width: size.width*0.010, ),
                  Row(
                    children: [
                      Image(
                          image: AssetImage(
                            'assets/delivery-man.png',
                          ),
                          width: size.width < 203
                              ? 30
                              : size.width <= 243 ? 35 : 35),
                      SizedBox(
                        width: size.width * 0.015,
                      ),
                      Text(
                        'Domcilio',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12),
                      ),
                    ],
                  ),

                  Text(
                    '\$ ' + precio,
                    style: TextStyle(
                        fontSize:
                            precio.length >= 9 && size.width < 229 ? 10 : 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tarjetaFormaDePago({BuildContext context, String precio}) {
    final size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;

    return Container(
      width: size.width,
      height:
          size.height < 509 ? 50 : size.height > 635 ? 60 : size.height * 0.09,
      color: Colors.white,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //  SizedBox( width: size.width*0.010, ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forma de Pago ',
                    style: TextStyle(fontSize: 8),
                  ),
                  SizedBox(
                      height: orientacion == Orientation.portrait
                          ? size.height * 0.008
                          : size.height * 0.015),
                  Row(
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/money-1.png',
                        ),
                        width: 17,
                      ),
                      SizedBox(width: size.width * 0.005),
                      Text(
                        'Efectivo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.020,
              ),

              Text(
                precio + '\$',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: precio.length >= 9 && size.width < 207 ? 10 : 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget botonFinalizar(BuildContext context) {

    // Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: size.height < 573 ? 30 : size.height * 0.06,
        width: size.width * 0.9,
        child: RaisedButton(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Text(
              'FINALIZAR',
              style: TextStyle(fontSize: 18, color: verde),
            ),
            color: amarillo,
            onPressed: () {
              Navigator.of(context).pushNamed('');
            }),
      ),
    );
  }

  Widget cardUnTexto({BuildContext context,String pedido  }) {
    // Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 19.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Pedido Realizado',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                )),
          ],
        ),
      ),
      GestureDetector(
        child: Container(
          height: size.height < 509
              ? 40
              : size.height > 635 ? 50 : size.height * 0.08,
          width: size.width,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    pedido, 
                    style: TextStyle(fontSize: pedido.length>38 &&size.width<270 ?10:   13),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget cardUnTextoYPrecio({BuildContext context, String precio}) {
    Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          height: size.height < 509
              ? 50
              : size.height > 635 ? 60 : size.height * 0.09,
          color: Colors.white,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //  SizedBox( width: size.width*0.010, ),
                  Text(
                    'Comision',
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
                  ),

                  Text(
                    '\$ ' + precio,
                    style: TextStyle(
                        fontSize:
                            precio.length >= 9 && size.width < 229 ? 10 : 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //
  Widget metodoDePago(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 35,
                width: size.width < 205 ? 80 : 90,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                            image: AssetImage(
                              'assets/money.png',
                            ),
                            width: size.width < 205 ? 12 : 15),
                        SizedBox(width: size.width < 205 ? 0 : 3),
                        Text(
                          'Efectivo',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pushNamed('');
                    }),
              ),
              Container(
                height: 35,
                width: size.width < 205 ? 80 : 90,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Image(
                      image: AssetImage(
                        'assets/PAYU_LOGO_LIME.png',
                      ),
                      width: size.width * 0.38,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pushNamed('');
                    }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 35,
              width: size.width < 207 ? 150 : 230,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: AssetImage(
                            'assets/Bancolombianew.png',
                          ),
                          width: 25),
                      Text(
                        size.width < 214
                            ? 'Transf. Bancaria '
                            : 'Transferencia Bancaria ',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed('');
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
