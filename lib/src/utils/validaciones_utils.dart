import 'package:flutter/material.dart';

class Validaciones {
  
  bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void mostrarCargando(BuildContext context){
     showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
}
void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
          title: Text('Algo salio mal'),
          content: Text(mensaje),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            )
          ],
        );
      });
}

void mensajeValForm(BuildContext context, List<Widget> validacion) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
           shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
          title: Text('Algo salio mal'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: validacion,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}

void alertaInfo(BuildContext context, String mensaje, String estado) {
  // flutter defined function
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
        title: new Text("Informaci??n"),
        content: new Text(mensaje.toString()),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Salir",),
            onPressed: () {
              if (estado == 'false') {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, estado);
              }
            },
          ),
        ],
      );
    },
  );
}

String validateEmail(String value) {
  if (value.isEmpty) {
    return 'El campo Email no puede estar vac??o!';
  }
  // Regex para validaci??n de email
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);
  if (regExp.hasMatch(value)) {
    return null;      
  }

  return 'El Email suministrado no es v??lido. Intente otro correo electr??nico';

}

String validatePassword(String value) {
  if (value.isEmpty) {
    return 'El campo Contrase??a no puede estar vac??o';
  }
  // Use cualquier tama??o de contrase??a que usted quiera aqu??
  if (value.length < 8) {
    return 'El tama??o de la contrase??a debe ser m??s de 8 car??cteres';
  }
  return null;
}
  String validateRepetPassword(String value, String password) {
    //print("valorrr $value passsword ${passwordCtrl.text}");
    if (value != password) {
      return "Las contrase??as no coinciden";
    } else if (value.length < 8) {
      return 'El tama??o de la contrase??a debe ser m??s de 8 car??cteres';
    }
    return null;
  }
 String validateName(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "El campo es necesario";
  } else if (!regExp.hasMatch(value)) {
    return "El campo debe de ser a-z y A-Z";
  }
  return null;
}
 String validateGenerico(String value) {
 
  if (value.length == 0) {
    return "El campo es necesario";
  }
  return null;
}
 String validatePrecioSgerido(String value) {
 
  if (value.length == 0) {
    return "El campo es necesario";
  } else if (value.length <= 3) {
     return 'El tama??o del campo debe ser m??s de 3 car??cteres';
  }
  return null;
}
String validateNumerico(String value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "El numero es necesario";
  } else if (!regExp.hasMatch(value)) {
    return "La cedula debe de ser solo numeros";
  }
  return null;
}

}