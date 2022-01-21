import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/login/Model/LoginModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

import 'Provider/LoginProvider.dart';
// import 'package:http/http.dart' as http;

class IniciarSesionPage extends StatefulWidget {
  @override
  _IniciarSesionPageState createState() => _IniciarSesionPageState();
}

class _IniciarSesionPageState extends State<IniciarSesionPage> {
  Validaciones validar = new Validaciones();
  TextEditingController emailConroller = new TextEditingController();
  TextEditingController contrasenaController = new TextEditingController();
  FocusNode emailFocus = new FocusNode();
  FocusNode contrasenaFocus = new FocusNode();
  var formKey = GlobalKey<FormState>();
  bool o = true;
  Size size;
  LoginProvider loginProvider;
  @override
  Widget build(BuildContext context) {
    contrasenaController.text = '12341234';
    final prefs = new PreferenciasUsuario();

    size = MediaQuery.of(context).size;
    loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.transparent),
        elevation: 0,
        backgroundColor: amarillo,
        title: Image(
          image: AssetImage('assets/logo.png'),
          // color: verde,
          width: 50,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: size.width < 248
                  ? const EdgeInsets.all(30.0)
                  : const EdgeInsets.all(40.0),
              child: Container(
                // height: 500,
                width: 400,
                decoration: ShapeDecoration(
                    color: size.width > 500 ? gris : Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                          child: Text(
                        'Inicio Sesión',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: verde),
                      )),
                      SizedBox(
                        height: size.height * 0.060,
                      ),
                      crearEmail(),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      crearContrasena(),
                      SizedBox(
                        height: size.height * 0.10,
                      ),
                      FlatButton(
                          onPressed: () {},
                          child: Text(
                            size.width < 220
                                ? '¿Olvido la contraseña?'
                                : '¿Olvidaste la contraseña?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: verde),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      crearBotonIniciar(context),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      crearBotonRegistrarse(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget crearEmail() {
    return Container(
      width: size.width > 400 ? 320 : size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(size.width < 227 ? 'Correo' : 'Correo Electronico'),
          TextFormField(
            validator: (value) => validar.validateEmail(value),
            controller: emailConroller,
            focusNode: emailFocus,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.alternate_email_outlined),
              hintText: 'Correo@ejemplo.com',
            ),
            onFieldSubmitted: (value) {
              contrasenaFocus.requestFocus();
            },
          ),
        ],
      ),
    );
  }

  Widget crearContrasena() {
    return Container(
      width: size.width > 400 ? 320 : size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contraseña'),
          TextFormField(
            validator: (value) => validar.validatePassword(value),
            controller: contrasenaController,
            focusNode: contrasenaFocus,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: o == true
                    ? Icon(Icons.remove_red_eye)
                    : Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    o = !o;
                  });
                },
              ),
              hintText: '* * * * * *',
            ),
            obscureText: o,
            onFieldSubmitted: (value) {
              submit();
            },
          ),
        ],
      ),
    );
  }

  Widget crearBotonIniciar(BuildContext context) {
    return Container(
        height: size.width > 400 ? 40 : size.height * 0.065,
        width: size.width > 400 ? 320 : size.width,
        child: RaisedButton(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Text(
              'Iniciar Sesion',
              style: TextStyle(fontSize: 12, color: verde),
            ),
            color: amarillo,
            onPressed: submit));
  }

  Widget crearBotonRegistrarse(BuildContext context) {
    return Container(
      height: size.width > 400 ? 40 : size.height * 0.065,
      width: size.width > 400 ? 320 : size.width,
      child: RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Text(
            'Registrarse',
            style: TextStyle(
                // fontSize: size.width * 0.030,
                fontSize: 12,
                color: Colors.white),
          ),
          color: verde,
          onPressed: () {
            Navigator.of(context).pushNamed('SeleccionRegistro');
          }),
    );
  }

  void submit() {
    if (!formKey.currentState.validate()) {
      return null;
    }

    load(context);
    loginProvider.login(
      context,
      user: LoginModel(
        username: emailConroller.text.trim(),
        password: contrasenaController.text.trim(),
      ),
    );
    emailConroller.text = '';
    contrasenaController.text = '';
    // print('');
    // Navigator.of(context).popAndPushNamed('Inicio');
  }
}
