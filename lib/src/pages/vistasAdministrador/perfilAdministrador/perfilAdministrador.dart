import 'package:flutter/material.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/InicioAdministrador/inicioAdministrador.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';


class PerfilAdministrador extends StatelessWidget {
  // const PerfilAdministrador({Key key}) : super(key: key);
  PreferenciasUsuario _pref = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              appbarStack(context),
              SizedBox(
                height: _size.height * 0.045,
              ),
              Text(
                '${_pref.nombre} ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: _orientacion == Orientation.portrait
                        ? _size.width * 0.09
                        : _size.width * 0.05),
              ),
              SizedBox(
                  height: _orientacion == Orientation.portrait
                      ? _size.height * 0.04
                      : _size.width * 0.05),
              _orientacion == Orientation.portrait
                  ? generarDatosPerfilVertical(
                      context: context,
                      correo: '${_pref.email}',
                      telefono: '${_pref.telefono}')
                  : generarDatosperfilHorizontal(
                      context: context,
                      correo: '${_pref.email}',
                      telefono: '${_pref.telefono}'),
              SizedBox(
                  height: _orientacion == Orientation.portrait
                      ? _size.height * 0.04
                      : _size.width * 0.05),
            ],
          ),
        ),
      ),
    );
  }



  Widget appbarStack(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        AppBar(
          title: Text('Perfil',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: blanco,
          elevation: 0,
          iconTheme: IconThemeData(color: verde),
        ),
        Column(
          children: [
            SizedBox(
              height: _orientacion == Orientation.portrait
                  ? _size.height * 0.045
                  : _size.height * 0.095,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: _orientacion == Orientation.portrait
                        ? _size.width * 0.39
                        : _size.width * 0.2,
                    height: _orientacion == Orientation.portrait
                        ? _size.width * 0.07
                        : _size.width * 0.038,
                    child: RaisedButton(
                        child: Text(
                          'Administrador',
                          style: TextStyle(
                              color: blanco,
                              fontSize: _orientacion == Orientation.portrait
                                  ? _size.width * 0.043
                                  : _size.width * 0.026),
                        ),
                        onPressed: () {},
                        color: verde,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(13),
                                topLeft: Radius.circular(13))))),
              ],
            ),
          ],
        ),
        fotoDePerfil(context)
      ],
    );
  }

  Widget fotoDePerfil(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: _orientacion == Orientation.portrait
                      ? _size.height * 0.055
                      : _size.height * 0.115,
                ),
                CircleAvatar(
                    backgroundColor: verde,
                    child: _pref.url_foto_perfil != null?CircleAvatar(
                        backgroundImage: NetworkImage(storage+_pref.url_foto_perfil),
                        radius: _orientacion == Orientation.portrait
                            ? _size.width * 0.138
                            : _size.width * 0.09,
                        backgroundColor: Colors.white):Container(),
                    radius: _orientacion == Orientation.portrait
                        ? _size.width * 0.143
                        : _size.width * 0.093),
              ],
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: _orientacion == Orientation.portrait
                  ? _size.width * 0.375
                  : _size.width * 0.23,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: _orientacion == Orientation.portrait
                        ? _size.width * 0.37
                        : _size.width * 0.22,
                    height: _orientacion == Orientation.portrait
                        ? _size.width * 0.075
                        : _size.width * 0.038,
                    child: RaisedButton.icon(
                      icon: Icon(Icons.edit,
                          color: blanco,
                          size: _orientacion == Orientation.portrait
                              ? _size.width * 0.045
                              : _size.width * 0.022),
                      label: Text(
                        'Editar Perfil',
                        style: TextStyle(
                            color: blanco,
                            fontSize: _orientacion == Orientation.portrait
                                ? _size.width * 0.04
                                : _size.width * 0.022),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('EditarPerfilAdministrador');
                      },
                      color: verde,
                      shape: StadiumBorder(),
                    ))
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget generarDatosPerfilVertical(
      {BuildContext context, String correo, String telefono}) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: _size.width * 0.1,
            ),
            FloatingActionButton(
                heroTag: 'btn1',
                onPressed: () {},
                backgroundColor: blanco,
                elevation: 4,
                child: Image(
                  width: _orientacion == Orientation.portrait
                      ? _size.width * 0.065
                      : _size.width * 0.035,
                  image: AssetImage('assets/correo-electronico.png'),
                )),
            SizedBox(
                width: _orientacion == Orientation.portrait
                    ? _size.width * 0.04
                    : _size.width * 0.03),
            Text(correo,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: _orientacion == Orientation.portrait
                        ? _size.width * 0.04
                        : _size.width * 0.023))
          ],
        ),
        SizedBox(
          height: _orientacion == Orientation.portrait
              ? _size.height * 0.055
              : _size.height * 0.115,
        ),
        Row(
          children: [
            SizedBox(
              width: _size.width * 0.1,
            ),
            FloatingActionButton(
                heroTag: 'btn2',
                onPressed: () {},
                backgroundColor: blanco,
                elevation: 4,
                child: Image(
                  width: _orientacion == Orientation.portrait
                      ? _size.width * 0.065
                      : _size.width * 0.035,
                  image: AssetImage('assets/telefono.png'),
                )),
            SizedBox(
                width: _orientacion == Orientation.portrait
                    ? _size.width * 0.04
                    : _size.width * 0.03),
            Text(telefono,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: _orientacion == Orientation.portrait
                        ? _size.width * 0.05
                        : _size.width * 0.028))
          ],
        ),
        SizedBox(
          height: _orientacion == Orientation.portrait
              ? _size.height * 0.055
              : _size.height * 0.115,
        ),
      ],
    );
  }

  Widget generarDatosperfilHorizontal(
      {BuildContext context, String correo, String telefono}) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            FloatingActionButton(
                onPressed: () {},
                backgroundColor: blanco,
                elevation: 4,
                child: Image(
                  width: _orientacion == Orientation.portrait
                      ? _size.width * 0.065
                      : _size.width * 0.035,
                  image: AssetImage('assets/correo-electronico.png'),
                )),
            SizedBox(
                width: _orientacion == Orientation.portrait
                    ? _size.width * 0.04
                    : _size.width * 0.03),
            Text(correo,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: _orientacion == Orientation.portrait
                        ? _size.width * 0.04
                        : _size.width * 0.023))
          ],
        ),
        Row(
          children: [
            FloatingActionButton(
                onPressed: () {},
                backgroundColor: blanco,
                elevation: 4,
                child: Image(
                  width: _orientacion == Orientation.portrait
                      ? _size.width * 0.065
                      : _size.width * 0.035,
                  image: AssetImage('assets/telefono.png'),
                )),
            SizedBox(
                width: _orientacion == Orientation.portrait
                    ? _size.width * 0.04
                    : _size.width * 0.03),
            Text(telefono,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: _orientacion == Orientation.portrait
                        ? _size.width * 0.05
                        : _size.width * 0.028))
          ],
        ),
      ],
    );
  }
}
