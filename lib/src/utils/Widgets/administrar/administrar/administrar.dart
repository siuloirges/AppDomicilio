import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/administrar/tarjetaStack/tarjetaStack.dart';
import 'package:traelo_app/src/utils/Widgets/cardPequenna/cardPequenna.dart';

class Administrar extends StatelessWidget {
  final num cantidad1;
  final num cantidad2;
  final num cantidad3;
  final String tituloCard1;
  final String tituloCard2;
  final String tituloCard3;
  final String imageCard;
  final bool notificar1;
  final bool notificar2;
  final bool notificar3;
  final String ruta1;
  final String ruta2;
  final String ruta3;
  final bool crear;

  const Administrar({
    Key key,
    this.tituloCard1,
    this.tituloCard2,
    this.tituloCard3,
    this.cantidad1,
    this.cantidad2,
    this.cantidad3,
    this.imageCard,
    this.ruta1,
    this.ruta2,
    this.ruta3,
    this.notificar1 = false,
    this.notificar2 = false,
    this.notificar3 = false,
    this.crear = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: _size.height * 0.05),
          Text(
            'Detalles',
            style: TextStyle(
                color: verde, fontSize: 25, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: _size.width > 589
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceAround,
            children: [
              CardPequenna(
                  notificacion: notificar1 == true
                      ? notificacion(context: context, herotag: 'btn1')
                      : null,
                  heroTag: 'bt1',
                  cantidad: cantidad1 ?? 0,
                  titulo: tituloCard1 ?? '',
                  colorCard: amarillo,
                  colorNumero: verde,
                  colorTitulo: verde,
                  image: imageCard ?? 'assets/company.png'),
              _size.width > 589
                  ? SizedBox(
                      width: 28,
                    )
                  : Container(),
              CardPequenna(
                  notificacion: notificar2 == true
                      ? notificacion(context: context, herotag: 'btn2')
                      : null,
                  heroTag: 'bt2',
                  cantidad: cantidad2 ?? 0,
                  titulo: tituloCard2 ?? '',
                  colorCard: verde,
                  colorNumero: amarillo,
                  colorTitulo: Colors.white,
                  image: imageCard ?? 'assets/notificationp.png'),
              _size.width > 589
                  ? SizedBox(
                      width: 28,
                    )
                  : Container(),
              CardPequenna(
                  notificacion: notificar3 == true
                      ? notificacion(
                          context: context, herotag: 'btn3', color: rojo)
                      : null,
                  heroTag: 'bt3',
                  cantidad: cantidad3 ?? 0,
                  titulo: tituloCard3 ?? '',
                  colorCard: Colors.grey,
                  colorNumero: Colors.white,
                  colorTitulo: Colors.white,
                  image: imageCard ?? 'assets/notificationp.png')
            ],
          ),
          SizedBox(height: _size.height * 0.14),
          crear == false
              ? Row(
                 mainAxisAlignment: _size.width > 589
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceAround,
                  children: [
                    TarjetaStack(
                        image: 'assets/actualizar.png',
                        ruta: ruta3,
                        colorIconoAccion: verde,
                        colorAccion: verde,
                        colorTextoAccion: blanco,
                        texoAccion: 'ACTUALIZAR'),
                        _size.width > 589
                  ? SizedBox(
                      width: 150,
                    )
                  : Container(),
                    TarjetaStack(
                        image: 'assets/garrapata2.png',
                        ruta: ruta2,
                        colorIconoAccion: verde,
                        colorAccion: verde,
                        colorTextoAccion: Colors.white,
                        texoAccion: 'CONSULTAR'),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(height: _size.height * 0.05),
                    TarjetaStack(
                        image: 'assets/editar.png',
                        ruta: ruta1,
                        colorIconoAccion: amarillo,
                        texoAccion: 'CREAR'),
                  ],
                )
        ],
      ),
    );
  }

  Widget notificacion({BuildContext context, Color color, String herotag}) {
    final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return Positioned(
        left:  _size.width>589?101.55:  _size.width / 05.8,
            
        top:  _size.width>589? 14.725: _size.width / 40,
            
        child: Container(
          height:  _size.width>589? 19.437: _size.width * 0.033,
            
          width:   _size.width>589?19.437  : _size.width * 0.033,
              
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: herotag,
              elevation: 5,
              onPressed: () {},
              backgroundColor: color ?? verde,
              splashColor: amarillo,
            ),
          ),
        ));
  }
}
