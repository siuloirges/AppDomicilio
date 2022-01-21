import 'package:flutter/material.dart';

import '../../Global.dart';

class CardPequenna extends StatelessWidget {
  final num cantidad;
  final String titulo;
  final Color colorCard;
  final Color colorNumero;
  final Color colorTitulo;
  final Positioned notificacion;
  final String image;
  final String heroTag;
  final Function ontap;
  final bool aliado;
  final bool asistente;
  final bool repartidor;
  final Color colorFloat;
  final Widget cantidadMod;
  const CardPequenna(
      {Key key,
      this.cantidad,
      this.titulo,
      this.colorCard,
      this.colorNumero,
      this.colorTitulo,
      this.image,
      this.notificacion,
      this.heroTag, this.ontap, this.aliado=false, this.colorFloat, this.cantidadMod, this.asistente=false, this.repartidor=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                  // color: Colors.grey,
                  width:aliado == false?   _size.width > 589 ? 173.235 : _size.width / 3.4: _size.width > 520 ? 173.235 : _size.width / 2.5  ,
                  height: aliado == false?  _size.width > 589 ? 39.26 : _size.width / 15:_size.width > 589 ? 39.26 : _size.width / 12    ),
              ClipRRect(
                
                borderRadius: BorderRadius.circular(8),
                child: GestureDetector(
                  onTap:ontap ,
                                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                  height: _size.width > 589
                                      ? 29.45
                                      : _size.width / 20),
                          Text(
                                titulo ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: _size.width > 589
                                        ? 14.725
                                        : _size.width * 0.025,
                                    fontWeight: FontWeight.bold,
                                    color: colorTitulo ?? Colors.black),
                              )
                              // Text('Hoy',style: TextStyle(fontWeight: FontWeight.bold,color:blanco),)
                            ],
                          ),
                          SizedBox(
                            height: _size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             asistente == false?     Text('${cantidad ?? '0'}',
                                  style: TextStyle(
                                      fontSize: _size.width > 589
                                          ? 45.3
                                          : _size.width / 13,
                                      fontWeight: FontWeight.bold,
                                      color: colorNumero ?? Colors.black)):cantidadMod,
                            ],
                          )
                        ],
                      ),
                      color: colorCard ?? verde,
                      width: aliado == false?  _size.width > 589 ? 173.23 : _size.width / 3.4  :  _size.width > 520 ? 208 : _size.width / 2.5 ,
                      height:aliado == false? _size.width > 589 ? 184.06 : _size.width / 3.2: _size.width > 520 ? 208 : _size.width / 2.5 ),
                ),
              ),
            ],
          ),
          Positioned(
              left:aliado == false?  _size.width > 589 ? 59.49 : _size.width / 9.9 : _size.width > 589 ? 59.49 : _size.width / 8  ,
              top: _size.width > 589 ? 14.725 : _size.width / 40,
              child: Container(
                height: aliado == false  ? _size.width > 589 ? 58.9 : _size.width * 0.10 : _size.width > 500 ? 75 : _size.width * 0.15  ,
                width: aliado == false  ? _size.width > 589 ? 58.9 : _size.width * 0.10 : _size.width > 500 ? 75 : _size.width * 0.15  ,
                child: FittedBox(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000)),
                    child: CircleAvatar(
                      backgroundColor: colorFloat??  blanco,
                      child:image!=null? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(image,
                            //fit: BoxFit.cover,
                            width:_size.width > 589 ? 41.23 : _size.width * 0.07),
                      ):Container(),
                      // splashColor: amarillo,
                    ),
                  ),
                ),
              )),
          notificacion ?? Container()
        ],
      ),
    );
  }
}

