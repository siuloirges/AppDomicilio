import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';

class PerfilPage extends StatelessWidget {
  PreferenciasUsuario pref = PreferenciasUsuario();
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                image(context),
                contenido(context),
              ],
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: size.height / 8,
          //   decoration: BoxDecoration(color: Colors.transparent),
          // ),
          pop(context),
        ],
      ),
    );
  }

  Widget pop(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: amarillo),
          backgroundColor: Colors.transparent,
          title: Text(
            'Perfil',
            style: TextStyle(color: amarillo),
          ),
        )
      ],
    );
  }

  Widget image(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [

                Container(
                  child: Image(
                      fit: BoxFit.cover,
                      height: size.height * 0.3,
                      width: double.infinity,
                      image: NetworkImage(storage+pref.url_foto_perfil??'')),
                ),

                Column(
                  children: [
                    Image.asset(
                      'assets/Rectangle.png',
                      height: size.height * 0.3,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ],
                )

              ],
            ),
            Container(
              color: Colors.transparent,
              height: size.height * 0.05,
            )
          ],
        ),
        Container(
          height: size.height * 0.3,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  '${pref.nombre}',
                  style:
                  TextStyle(color: amarillo, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${pref.telefono }',
                  style: TextStyle(color: blanco),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              // SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.277,
            ),
            Center(
              child: Container(
                height: 25,
                width: size.width > 400 ? 190 : size.width * 0.45,
                child: RaisedButton(
                  color: verde,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: size.width > 250 ? 10 : 0,
                      ),
                      Text(
                          size.width > 330
                              ? "Editar Pefil"
                              : size.width > 215
                                  ? 'Editar'
                                  : '',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('EditarPerfil',arguments: {
                      "data":{
                        "nombre":pref.nombre,
                        "email":pref.email,
                        "telefono":pref.telefono
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget contenido(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.015,
              ),
              Text('Mis Ordenes ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: size.width * 0.035,
                  )),
            ],
          ),
        ),
        tarjetaGrande(context),
        SizedBox(
          height: size.height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.015,
              ),
              Text('Mis Ordenes ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: size.width * 0.035,
                  )),
            ],
          ),
        ),
        tarjetaMenor(context),
        tarjetaGrande(context),
        tarjetaMenor(context),
        tarjetaGrande(context),
      ],
    );
  }

  Widget tarjetaGrande(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.125,
          color: Colors.white,
          child: Card(
            margin: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //  SizedBox( width: size.width*0.010, ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Delicones',
                            style: TextStyle(
                              fontSize: size.height * 0.020,
                            ),
                          ),
                          Text('Crespo Mz 8 Lt12',
                              style: TextStyle(
                                  fontSize: size.height * 0.015,
                                  color: Color.fromRGBO(103, 96, 95, 1)))
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: [
                          Text(
                            '10:23 AM',
                            style: TextStyle(
                              fontSize: size.height * 0.014,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.012,
                          ),
                          Text(
                            'Orden N° D-001. ',
                            style: TextStyle(
                                fontSize: size.height * 0.014, color: verde),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.010,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Estado',
                          style: TextStyle(
                              fontSize: size.height * 0.015, color: verde)),
                      Text('Proceso de Entrega',
                          style: TextStyle(
                            fontSize: size.height * 0.014,
                          ))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_forward_ios,
                        size: size.height * 0.015,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tarjetaMenor(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.08,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //  SizedBox( width: size.width*0.010, ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Delicones',
                      style: TextStyle(
                        fontSize: size.height * 0.020,
                      ),
                    ),
                    Text('Crespo Mz 8 Lt12',
                        style: TextStyle(
                            fontSize: size.height * 0.015,
                            color: Color.fromRGBO(103, 96, 95, 1)))
                  ],
                ),
                SizedBox(
                  width: size.width * 0.010,
                ),

                Column(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_forward_ios,
                      size: size.height * 0.015,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
