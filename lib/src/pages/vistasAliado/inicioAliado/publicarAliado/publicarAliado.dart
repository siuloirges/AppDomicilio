import 'package:flutter/material.dart';
import 'package:traelo_app/src/pages/vistasAliado/inicioAliado/publicarAliado/models/respAliadoModel.dart';
// import 'package:traelo_app/src/pages/vistasCliente/inicio/model/respCategoriaModel.dart';
// import 'package:traelo_app/src/pages/vistasCliente/inicio/model/respCategoriaModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

// import 'models/respAliadoModel.dart';

class PublicarAliado extends StatefulWidget {
  // const PublicarAliado({Key key}) : super(key: key);
  @override
  _PublicarAliadoState createState() => _PublicarAliadoState();
}

class _PublicarAliadoState extends State<PublicarAliado> {
  PeticionesHttpProvider http = PeticionesHttpProvider();
//  Funciones funciones = new Funciones();
  // Funciones funciones = new Funciones();
// PeticionesHttpProvider _http = new PeticionesHttpProvider();
  PreferenciasUsuario pref = new PreferenciasUsuario();
  Funciones funciones = new Funciones();
  bool peticiones = false;

  List<Widget> globalRespCategoria = [];

  Size size;
  bool esatdo = false;
  @override
  void dispose() {
    esatdo = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (peticiones == false) {
      peticiones = true;
      pedir(context);
    }
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: () {
              restar();
            },
          ),
        ],
        elevation: 0,
        iconTheme: IconThemeData(color: negro),
        backgroundColor: amarillo,
        title: Text(
          'Publica tu aliado',
          style: TextStyle(color: negro),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: GridView.count(
              crossAxisCount: 2,
              children: globalRespCategoria,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: size.width,
                  color: verde,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      'Seleccione las Categorias en las que su Aiado se mostrara.',
                      style:
                          TextStyle(color: blanco, fontWeight: FontWeight.bold),
                    )),
                  )),
              // Container(width: size.width,
              // height: 70,
              // color: verde,
              // child: RaisedButton(onPressed: (){},
              // color: verde,
              // child: Center(child: Text('GUARDAR',style:TextStyle(

              //   color: blanco,fontSize: 20  ) , ) ,),
              // ),
              // )
            ],
          ),
        ],
      ),
    );
  }

  restar() {
    peticiones = false;
    globalRespCategoria = [];
    setState(() {});
  }

  pedir(context) async {
    try {
      dynamic resp = await http.getMethod(
        context: context,
        table: 'AliadoCategorias?aliado=1',
        token: pref.token,
      );
      if (resp['message'] == "expiro") {
        await funciones.closeSection(context);
        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
      }

      if (resp['message'] == "true") {
        List<Widget> widgets = [];
        final model = respAliadoCategoriaModelFromJson(resp['resp']);
        print(model.data.data);
        model.data.data.forEach((element) async {
          widgets.add(categoria(
              estado: false,
              texto: '${element.titulo}',
              estadoG: "${element.estado}",
              idCategoria: element.id,
              imagen: element.urlImagen,
              aliadoCategoriaId: element.aliadoCategoriaId));
        });
        setState(() {
          globalRespCategoria = widgets;
        });
      } else {}
    } catch (e) {
      return alerta(context, titulo: 'Error', contenido: '$e', code: false);
    }
  }

  categoria(
      {String texto,
      String estadoG,
      int idCategoria,
      int aliadoCategoriaId,
      String imagen,
      bool estado = false
      }) {
    print(estadoG);

    if (estadoG == '1') {
      estado = true;
    }
    if (estadoG == '0') {
      estado = false;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
     
          submitCategoria(
              context: context,
              aliadoCategoriaId: aliadoCategoriaId,
              estado: estado,
              estadoG: estadoG,
              idCategoria: idCategoria,
              texto: texto);
            
        },
        child: Container(
          decoration: ShapeDecoration(
              // color:estado == false?  Colors.teal[300]:Colors.teal[400],
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: estado == false ? Colors.transparent : blanco,
                      width: 8),
                  borderRadius: BorderRadius.circular(1000))),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Center(
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    width: 300,
                    height: 300,
                    image: NetworkImage('${storage+imagen}'),
                    placeholder: AssetImage(
                      'assets/logo_mano.png',
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Container(
                  width: 300,
                  height: 300,
                  color: estado == true ? Colors.black54 : Colors.black45,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$texto',
                      style:
                          TextStyle(color: blanco, fontWeight: FontWeight.bold),
                    ),
                   Checkbox(
                        value: estado,
                        checkColor: Colors.teal,
                        activeColor: Colors.white,
                        onChanged: (value) {
                        
                          submitCategoria(
                              context: context,
                              aliadoCategoriaId: aliadoCategoriaId,
                              estado: estado,
                              estadoG: estadoG,
                              idCategoria: idCategoria,
                              texto: texto);
                     
                        }
                        ),
                  ],
                ),
              ),
            ],
          ),
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  submitCategoria(
      {context,
      String texto,
      String estadoG,
      int idCategoria,
      int aliadoCategoriaId,
      bool estado}) async {
   load(context);
    if (estadoG == 'null') {
      print("estado " + estadoG);

      try {
        estado = !estado;

        var resp = await http.postMethod(
            table: 'AliadoCategorias',
            context: context,
            token: pref.token,
            body: {
              "estado": estado == false ? "0" : "1",
              "id_aliado": "${pref.id_aliado}",
              "id_categoria": "${idCategoria}"
            });
        if (resp['message'] == "expiro") {
          Navigator.of(context).pushReplacementNamed('IniciarSesion');
          alerta(context,
              titulo: 'alerta',
              code: false,
              contenido:
                  'Tiempo de conexion agotado, inicie sesion nuevamente.');
          await funciones.closeSection(context);
        }
        if (resp['message'] == 'true') {
          setState(() {
            peticiones = false;
          });
          Navigator.pop(context);
          // Navigator.of(context).pushNamed('PublicarAliado');
        }
        if (resp['message'] == 'false') {
          setState(() {
            estado = !estado;
          });
          return alerta(context,
              titulo: 'Error', contenido: 'error de conexion', code: false);
        }
      } catch (e) {
        return alerta(context, titulo: 'error', contenido: '$e', code: false);
      }
    }

    if (estadoG == '0' || estadoG == '1') {
     
      try {
        estado = !estado;

        print("- estado " + estadoG);
        var resp = await http.putMethod(
            id: aliadoCategoriaId,
            table: 'AliadoCategorias',
            context: context,
            token: pref.token,
            body: {
              "estado": estado == false ? "0" : "1",
              "id_aliado": "${pref.id_aliado}",
              "id_categoria": "${idCategoria}"
            });
        if (resp['message'] == 'expiro') {
          
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed('IniciarSesion');
        }
        if (resp['message'] == 'true') {
          setState(() {
            peticiones = false;
          });
           Navigator.pop(context);
          //  Navigator.of(context).pushNamed('PublicarAliado');
        }
        if (resp['message'] == 'false') {
          setState(() {
            estado = !estado;
          });
          return alerta(context,
              titulo: 'error', contenido: 'error de conexion', code: false);
        }
      } catch (e) {
        return alerta(context, titulo: 'error', contenido: '$e', code: false);
      }
    }
  }
}

// class Categoria extends StatefulWidget {

//   String texto;
//   String estadoG ;
//   int idCategoria;
//   String imagen;

//  int aliadoCategoriaId;
//   Categoria({Key key, this.texto, this.estadoG,this.idCategoria , this.aliadoCategoriaId,this.imagen }) : super(key: key);

//   @override
//   _CategoriaState createState() => _CategoriaState();
// }

// class _CategoriaState extends State<Categoria> {
//   // PublicarAliado = publicarAliado =new PublicarAliado();
//   bool estado = false;
//    Funciones funciones = new Funciones();
//   PreferenciasUsuario _prefs = new PreferenciasUsuario();
//   PeticionesHttpProvider peticion = new PeticionesHttpProvider();
//   @override
//   Widget build(BuildContext context) {
//     print(widget.estadoG);
//     if(widget.estadoG=='1'){
//       estado = true;
//     }
//     if(widget.estadoG=='0'){
//       estado = false;
//     }
//     return Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: GestureDetector(
//          onTap: () async {submit();},
//                 child: Container(

//            decoration: ShapeDecoration(
//               // color:estado == false?  Colors.teal[300]:Colors.teal[400],
//              shape: RoundedRectangleBorder(
//                side: BorderSide( color:estado ==false  ?Colors.transparent: blanco,width:  8   ),
//                borderRadius: BorderRadius.circular(1000))
//            ),
//            child: Stack(
//              children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(1000),
//                      child: Center(
//                   child: FadeInImage(
//                     fit: BoxFit.cover,
//                     width: 300,
//                     height: 300,
//                     image:NetworkImage('${widget.imagen}'),
//                     placeholder: AssetImage('assets/logo_mano.png',),
//                   ),
//                 ),
//               ),
//               ClipRRect(
//                  borderRadius: BorderRadius.circular(1000),
//                     child: Container(
//                    width: 300,
//                    height: 300,
//                     color:estado==true?Colors.black54:Colors.black45,
//                 ),
//               ),
//                Center(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [

//                      Text(
//                        '${widget.texto}',
//                        style: TextStyle(
//                          color: blanco,
//                          fontWeight: FontWeight.bold
//                        ),
//                      ),
//                      Checkbox(
//                value:estado,
//                checkColor: Colors.teal,
//              activeColor:Colors.white,
//                 onChanged: (value)async{
//                submit();
//           }),
//                    ],
//                  ),
//                ),
//              ],
//            ),
//            width:  100,
//            height: 100,
//          ),
//        ),
//      );
//   }
//   submitCategoria()async{

//       if(widget.estadoG =='null'){

//        print("estado "+widget.estadoG);

//         try{

//           estado = !estado;

//           var resp = await  peticion.postMethod(

//           table: 'AliadoCategorias',
//           context: context,
//           token:_prefs.token,
//           body: {
//            "estado": estado == false ? "0":"1",
//            "id_aliado":"${_prefs.id_aliado}",
//            "id_categoria":"${widget.idCategoria}"
//           }
//          );
//          if (resp['message'] == "expiro") {
//         Navigator.of(context).pushReplacementNamed('IniciarSesion');
//         alerta(context,
//             titulo: 'alerta',
//             code: false,
//             contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
//         await funciones.closeSection(context);
//       }
//           if( resp['message'] == 'true' ){

//           Navigator.pop(context);
//           Navigator.of(context).pushNamed('PublicarAliado');
//           }
//           if(resp['message'] =='false' ){
//             setState(() {
//                estado = !estado;
//             });
//            return alerta(context,titulo: 'Error',contenido: 'error de conexion',code:false);
//           }

//         }catch(e){
//             return alerta(context,titulo: 'error',contenido: '$e',code:false);
//         }

//       }

//       if(widget.estadoG == '0'||widget.estadoG == '1'){

//         try{

//           estado = !estado;

//           print("- estado "+widget.estadoG);
//           var resp = await  peticion.putMethod(
//           id:widget.aliadoCategoriaId,
//           table: 'AliadoCategorias',
//           context: context,
//           token:_prefs.token,
//           body: {
//            "estado": estado == false ? "0":"1",
//            "id_aliado":"${_prefs.id_aliado}",
//            "id_categoria":"${widget.idCategoria}"
//           }
//          );
//           if( resp['message'] == 'true' ){
//            Navigator.pop(context);
//            Navigator.of(context).pushNamed('PublicarAliado');
//           }
//           if(resp['message'] =='false' ){
//             setState(() {
//                estado = !estado;
//             });
//              return alerta(context,titulo: 'error',contenido: 'error de conexion',code:false);
//           }

//         }catch(e){
//           return alerta(context,titulo: 'error',contenido: '$e',code:false);
//         }

//       }

//   }
// }
