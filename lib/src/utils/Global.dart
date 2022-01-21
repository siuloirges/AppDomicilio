import 'package:flutter/material.dart';

//Colores de la App
// String url ='http://192.168.1.72/traeloo_database/public/api';
// String url ='http://192.168.1.71/traeloo_database/public/api';
String url = 'https://traeloo.lulosys.com/api';

String storage = 'https://traeloo.lulosys.com';
// String storage ='http://192.168.1.65/traeloo_database/public';
final verde = Color.fromRGBO(19, 166, 7, 1);
final verdeClaro = Color.fromRGBO(126, 211, 33, 1);
final amarillo = Color.fromRGBO(255, 241, 1, 1);
final rojo = Color.fromRGBO(229, 0, 1, 1);
final gris = Color.fromRGBO(232, 232, 232, 1);
final scaffold = Color.fromRGBO(251, 251, 251, 1);
final negro = Color.fromRGBO(44, 48, 62, 1);
final blanco = Colors.white;

load(BuildContext context, {bool colorSuave = false}) {
  return showDialog(
      // barrierColor:
      // useSafeArea: tue,
      barrierColor: colorSuave == false
          ? Color.fromRGBO(64, 62, 65, 0.9)
          : Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Center(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              child: (CircleAvatar(
                backgroundColor: Colors.white,
                child: Container(
                  // width: 190,
                  // height: 190,
                  child: Center(
                      child: Stack(children: [
                    Center(
                      child: Image(
                          width: 20,
                          height: 20,
                          image: AssetImage(
                            'assets/logoPi.png',
                          )),
                    ),
                    Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        // valueColor: Color(Colors.white),
                        backgroundColor: blanco,
                      ),
                    ),
                  ])),
                ),
              )
                  // Center(
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.white,
                  //     child: Center(
                  //       child: Image(
                  //         //  fit: BoxFit.cover,
                  //         //  color: amarillo,
                  //         width: 200,
                  //         height: 200,
                  //         image: AssetImage(
                  //           'assets/logo_mano.png',
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  ),
            ),
          ),
        );
      });
}

loading() {
  return CircularProgressIndicator(
    backgroundColor: amarillo,
    strokeWidth: 1,
  );
}

thereIsNot({String texto, String imagen, bool color}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
          child: Image.asset(
        '$imagen',
        width: 150,
        height: 150,
        fit: BoxFit.cover,
        color: color == true ? Colors.grey : null,
      )),
      Text(
        '$texto',
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
      Flexible(
        child: Container(
          height: 250,
        ),
      )
    ],
  );
}

alerta(BuildContext context,
    {bool code = true,
    String titulo,
    dynamic contenido,
    Widget acciones,
    bool dismissible,
    bool done,
    Widget onpress,
    Color colorTitulo,
    Color colorContenido,
    bool weight = false}) {
  return showDialog(
      barrierDismissible: dismissible ?? true,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Color.fromRGBO(246, 245, 250, 1),
          title: Container(
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  '${titulo ?? 'Alerta'}',
                  style: TextStyle(color: colorTitulo ?? Colors.grey),
                )),
              )),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Container(
                      width: double.infinity,
                      // height: size.width>450?200: size.height * 0.22,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            code == true
                                ? contenido
                                : Text('$contenido',
                                    style: TextStyle(
                                        color: colorContenido ?? Colors.grey,
                                        fontWeight: weight == false
                                            ? FontWeight.w400
                                            : FontWeight.bold))
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: done == true
                            ? Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          child: Icon(Icons.arrow_back,
                                              color: Colors.white),
                                          width: 50,
                                          height: 50,
                                          decoration: ShapeDecoration(
                                              color: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                        )),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: onpress),
                                ],
                              )
                            : done == false
                                ? Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              child: Icon(Icons.arrow_back,
                                                  color: Colors.white),
                                              width: 50,
                                              height: 50,
                                              decoration: ShapeDecoration(
                                                  color: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                            )),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [acciones ?? Container()],
                                  ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
