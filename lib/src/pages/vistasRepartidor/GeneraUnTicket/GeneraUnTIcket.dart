import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';

class GeneraUnTicketRepartidor extends StatelessWidget {
  // const GeneraUnTicketRepartidor({Key key}) : super(key: key);
  TextEditingController nombreController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController asuntoController = new TextEditingController();
  TextEditingController mensajeController = new TextEditingController();
  PreferenciasUsuario _pref = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    nombreController.text = _pref.nombre;
    telefonoController.text = _pref.telefono;
    Size size = MediaQuery.of(context).size;
    Orientation orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        title: Text(
          'Soporte',
          style: TextStyle(color: verde),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
              height: orientacion == Orientation.portrait
                  ? size.height * 0.07
                  : size.width * 0.08),
          Text(
            'Genera un Ticket',
            style: TextStyle(
                fontSize: 12, color: Color.fromRGBO(155, 155, 155, 1)),
          ),
          SizedBox(
            height: orientacion == Orientation.portrait
                ? size.height * 0.035
                : size.height * 0.045,
          ),
          generarNombre(context),
          SizedBox(
            height: size.height * 0.045,
          ),
          generarTelefono(context),
          SizedBox(
            height: size.height * 0.045,
          ),
          generarAsunto(context),
          SizedBox(
            height: size.height * 0.045,
          ),
          generarMensaje(context),
          generarBoton(context),
          SizedBox(
              height: orientacion == Orientation.portrait
                  ? size.height * 0.045
                  : size.height * 0.25),
          Image(
              image: AssetImage(
                'assets/logoC.png',
              ),
              width: 200),
          SizedBox(
            height: size.height * 0.045,
          ),
        ],
      )),
    );
  }

  Widget generarNombre(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nombre',
          ),
          TextFormField(
            controller: nombreController,
            decoration: InputDecoration(hintText: 'Su Nombre'),
          ),
        ],
      ),
    );
  }

  Widget generarTelefono(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Telefono'),
          TextFormField(
            controller: telefonoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Su Telefono'),
          ),
        ],
      ),
    );
  }

  Widget generarAsunto(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Asunto'),
          TextFormField(
            controller: asuntoController,
            decoration: InputDecoration(hintText: 'Problema del Ingreso'),
          ),
        ],
      ),
    );
  }

  Widget generarMensaje(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mensaje'),
          TextFormField(
            controller: mensajeController,
            maxLines: 7,
            decoration: InputDecoration(hintText: 'Deje su mensaje'),
          ),
        ],
      ),
    );
  }

  Widget generarBoton(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
            width: 150,
            height: 40,
            child: RaisedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Column(
                          children: [
                            Image(
                                image: AssetImage('assets/tick.png'),
                                width: size.width * 0.08),
                            Text(
                              'SU ticket ha Sido Exitoso',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: StadiumBorder(),
                                color: verde,
                                child: Text(
                                  'Listo',
                                  style: TextStyle(
                                      color: blanco,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.05),
                                ))
                          ],
                        ),
                      );
                    });
              },
              color: amarillo,
              elevation: 4,
              shape: StadiumBorder(),
              child: Text(
                'ENVIAR',
                style: TextStyle(color: verde, fontSize: 12),
              ),
            )),
      ],
    );
  }

  Widget movimientos(BuildContext context) {
    return Card();
  }
}
