import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:traelo_app/src/utils/Widgets/drawer.dart';

class PagesSoporte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        elevation: 0,
        backgroundColor: amarillo,
        title: Text(
          'Soporte',
          style: TextStyle(color: verde),
        ),
        // leading: Builder(
        //   builder: (context) {
        //     return GestureDetector(
        //       child: Image.asset('assets/menu.png'),
        //       onTap: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //     );
        //   },
        // ),
      ),
      // drawer: MenuDesplegable(),
      body: SingleChildScrollView(
        child: Container(
            //color: Colors.blue,
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                'BIENVENIDO AL',
                style: TextStyle(
                  fontSize: orientation == Orientation.portrait
                      ? size.width * 0.0625
                      : size.width * 0.0325,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(155, 155, 155, 1),
                ),
              ),
              Text(
                'AREA DE SOPORTE',
                style: TextStyle(
                  fontSize: orientation == Orientation.portrait
                      ? size.width * 0.08
                      : size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: verde,
                ),
              ),
              Text(
                'AL REPARTIDOR',
                style: TextStyle(
                  fontSize: orientation == Orientation.portrait
                      ? size.width * 0.07
                      : size.width * 0.04,
                  color: verde,
                ),
              ),
              SizedBox(
                height: size.height * 0.055,
              ),
              Text(
                'ESCOGE EL CANAL',
                style: TextStyle(
                  fontSize: orientation == Orientation.portrait
                      ? size.width * 0.0625
                      : size.width * 0.0325,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(155, 155, 155, 1),
                ),
              ),
              Text(
                'AL CUAL COMUNICARAS TU PROBLEMA',
                style: TextStyle(
                  fontSize: orientation == Orientation.portrait
                      ? size.width * 0.04
                      : size.width * 0.01,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(155, 155, 155, 1),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              orientation == Orientation.portrait
                  ? Column(
                      children: [
                        CardFila1(
                          sizeImagen: 0.18,
                          sizeReferents: 0.38,
                          sizeText: 0.035,
                          sizeSizedBox: 0.05,
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        CardFila2(
                          sizeImagen: 0.18,
                          sizeReferents: 0.38,
                          sizeText: 0.035,
                          sizeSizedBox: 0.05,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardFila1(
                          sizeReferents: 0.18,
                          sizeText: 0.02,
                          sizeImagen: 0.09,
                          sizeSizedBox: 0.03,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        CardFila2(
                          sizeReferents: 0.18,
                          sizeText: 0.02,
                          sizeImagen: 0.09,
                          sizeSizedBox: 0.03,
                        ),
                      ],
                    ),
              SizedBox(
                height: size.height * 0.09,
              ),
              Container(
                child: Image.asset(
                  'assets/logoC.png',
                  width: size.width * 0.5,
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class Tarjetas extends StatelessWidget {
  final double sizeReferent;
  final String image;
  final String text;
  final double sizeTexto;
  final double sizeImage;
  final String ruta;
  final Function ontap;

  const Tarjetas(
      {Key key,
      @required this.image,
      @required this.text,
      @required this.sizeReferent,
      @required this.sizeTexto,
      @required this.sizeImage,
      this.ruta,
      this.ontap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * sizeReferent,
      height: size.width * sizeReferent,
      child: GestureDetector(
        onTap: ontap ??
            () {
              Navigator.of(context).pushNamed(ruta ?? '');
            },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: amarillo,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  image,
                  width: size.width * sizeImage,
                  height: size.width * sizeImage,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * sizeTexto,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardFila1 extends StatelessWidget {
  final double sizeReferents;
  final double sizeText;
  final double sizeImagen;
  final double sizeSizedBox;

  const CardFila1({
    Key key,
    @required this.sizeReferents,
    @required this.sizeText,
    @required this.sizeImagen,
    @required this.sizeSizedBox,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tarjetas(
          ruta: 'GeneraUnTicketRepartidor',
          text: 'GENERA UN TICKET',
          image: 'assets/correo-electronico.png',
          sizeReferent: sizeReferents,
          sizeTexto: sizeText,
          sizeImage: sizeImagen,
          //height: alto,
        ),
        SizedBox(width: size.width * sizeSizedBox),
        Tarjetas(
          text: 'WHATSAPPP',
          image: 'assets/whatsapp.png',
          sizeReferent: sizeReferents,
          sizeTexto: sizeText,
          sizeImage: sizeImagen,
          ontap: () {
            launchURL(numero: '3044155592');
          },
          //height: alto,
        ),
      ],
    );
  }

  launchURL({String numero}) async {
    String url = 'https://wa.me/+57' + numero;
    // const url =
    // 'https://api.whatsapp.com/send?phone=573016430128&text=Hola%2C%20*MOSERCON*%20Necesito%20Info%20MOSERCON%20%E2%80%93%20Moto%20Servicio%20de%20Confianza%20https%3A%2F%2Fwww.mosercon.com.co';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo dirigir a WhatsApp ';
    }
  }
}

class CardFila2 extends StatelessWidget {
  final double sizeReferents;
  final double sizeText;
  final double sizeImagen;
  final double sizeSizedBox;

  const CardFila2({
    Key key,
    @required @required this.sizeReferents,
    @required this.sizeText,
    @required this.sizeImagen,
    @required this.sizeSizedBox,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tarjetas(
          sizeTexto: sizeText,
          text: 'LINEA TELEFONICA',
          image: 'assets/telefono.png',
          sizeReferent: sizeReferents,
          sizeImage: sizeImagen,
        ),
        SizedBox(width: size.width * sizeSizedBox),
        Tarjetas(
          sizeTexto: sizeText,
          text: 'TRAELOO PAGE\n SOPORTE',
          image: 'assets/logo_mano.png',
          sizeReferent: sizeReferents,
          sizeImage: sizeImagen,
        ),
      ],
    );
  }
}
