import 'dart:convert';
import 'dart:io';
import 'dart:ui';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
// import 'package:provider/provider.dart';
// import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/FormularioProductosAliado/Widget/CrearPrecioWidegt.dart';
import 'package:traelo_app/src/pages/vistasAliado/productosAliado/models/productoModel.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/models/respGetProductos.dart';
import 'package:traelo_app/src/pages/vistasAliado/productosAliado/provider/productoprovider.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/models/productoModel.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/provider/productoprovider.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/editarProductosAliado/Widget/CrearPrecioWidegt.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/BarraVerde.dart';
import 'package:traelo_app/src/utils/model/respGetProductos.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/provider/productoprovider.dart';
import 'Widget/AgragarImagenWidget.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

// import 'package:traelo_app/src/utils/validaciones_utils.dart';

class EditarProductoAliado extends StatefulWidget {
  @override
  _EditarProductoAliadoState createState() => _EditarProductoAliadoState();
}

class _EditarProductoAliadoState extends State<EditarProductoAliado> {
  var formKey = GlobalKey<FormState>();
  Validaciones validar = new Validaciones();
  ProductoProvider productosProvider = new ProductoProvider();
  PreferenciasUsuario pref = new PreferenciasUsuario();
  TextEditingController nombreProductoController = new TextEditingController();
  TextEditingController descripcionProductoController =
      new TextEditingController();
  TextEditingController codigoController = new TextEditingController();

  TextEditingController valorProductoController = new TextEditingController();
  TextEditingController valorPromocionController = new TextEditingController();
  // TextEditingController cantidadController = new TextEditingController();

  FocusNode nombreProductoFocus = new FocusNode();
  FocusNode descripcionProductoFcus = new FocusNode();
  FocusNode codigoFocus = new FocusNode();
  FocusNode valorProductoFocus = new FocusNode();
  FocusNode valorPromocionFocus = new FocusNode();
  // FocusNode cantidadFocus = new FocusNode();
  // ProductosProvider productosProvider = new ProductosProvider();

  File perfilImage;
  bool mostrar = true;
  var size;
  var orientacion;
  var formatter;
  Map<String, dynamic> element;
  String estadoProducto = 'visible';
  String estadoPromocion = 'no';
  int valorProducto = 0;
  int valorPromocion = 0;
  bool is_combo = false;
  bool ifController = false;
  @override
  Widget build(BuildContext context) {
    element = ModalRoute.of(context).settings.arguments;
    formatter = new NumberFormat("###,###,###", "es-co");
    // valorProductoController.text = valorProducto.toString();
    // valorPromocionController.text = valorPromocion.toString();
    size = MediaQuery.of(context).size;
    // orientacion = MediaQuery.of(context).orientation;

    if (element['producto'] != null && ifController == false) {
      // dynamic precio = element['producto'].precio??'';
      // dynamic precioPromo = element['producto'].precioPromo??'';
      if (element['producto'].titulo != '' ||
          element['producto'].titulo != null) {
        nombreProductoController.text = element['producto'].titulo;
      }
      if (element['producto'].descripcion != '' ||
          element['producto'].descripcion != null) {
        descripcionProductoController.text = element['producto'].descripcion;
      }
      if (element['producto'].codigo != '' ||
          element['producto'].codigo != null) {
        codigoController.text = element['producto'].codigo;
      }
      // if(element['producto'].existencia.toString()!='0'||element['producto'].codigo!=null){cantidadController.text =  element['producto'].existencia.toString(); }
      if (element['producto'].precio != '' ||
          element['producto'].precio != null) {
        valorProducto = int.parse(element['producto'].precio);
        valorProductoController.text = valorProducto.toString();
      }
      if (element['producto'].precioPromo != '' ||
          element['producto'].precioPromo != null) {
        valorPromocion = int.parse(element['producto'].precioPromo);
        valorPromocionController.text = valorPromocion.toString();
      }
      if (element['producto'].disponibilidad != '' ||
          element['producto'].disponibilidad != null) {
        estadoProducto =
            element['producto'].disponibilidad != 0 ? "visible" : "no visible";
      }
      if (element['producto'].isPromo != '' ||
          element['producto'].isPromo != null) {
        estadoPromocion = element['producto'].isPromo != 0 ? "si" : "no";
      }
      if (element['producto'].isCombo != '' ||
          element['producto'].isCombo != null) {
        is_combo = element['producto'].isCombo != 0 ? true : false;
      }

      ifController = true;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 241, 1, 1),
        title: Text(
          element['page'] == 'Nuevo'
              ? 'Nuevo Producto'
              : element['page'] == 'Editar'
                  ? 'Editar Producto'
                  : 'Formulario Producto',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              BarraVerde(
                texto: 'Datas del nuevo producto',
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: AddImagen(
                  foto: perfilImage,
                ),
              ),

              crearNombreDelProducto(context),

              descripcion(context),

              codigo(context),

              // cantidad(context),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  precioProducto(
                    textoSuperior: "Valor Producto",
                    context: context,
                    activo: estadoPromocion == "si" ? false : true,
                  ),
                  boton(
                      colorBoton: estadoProducto == "visible" ? verde : rojo,
                      textoBoton: '$estadoProducto',
                      onpress: estadoProducto == "visible"
                          ? () {
                              setState(() {
                                estadoProducto = 'no visible';
                              });
                            }
                          : () {
                              setState(() {
                                estadoProducto = 'visible';
                              });
                            },
                      texto: 'Visibilidad'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  precioPromo(
                    context: context,
                    textoSuperior: 'Valor promocion',
                    textoSuperiorBoton: 'Visibilidad',
                    activo: estadoPromocion == "si" ? true : false,
                  ),
                  boton(
                      colorBoton: estadoPromocion == "si" ? verde : rojo,
                      textoBoton: '$estadoPromocion',
                      onpress: estadoPromocion == "si"
                          ? () {
                              estadoPromocion = 'no';
                              // valorProducto.toString() = valorProductoController.text ;
                              setState(() {
                                valorProductoFocus.requestFocus();
                              });
                            }
                          : () {
                              estadoPromocion = 'si';
                              // valorPromocionController.text =
                              //     valorPromocion.toString();
                              setState(() {
                                valorPromocionFocus.requestFocus();
                              });
                            },
                      texto: 'Promocion'),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿ Es un combo ?',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        // height: 20,
                        decoration: ShapeDecoration(
                            color: gris,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100))),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text('${is_combo == true ? "si" : "no"}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Checkbox(
                                // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                activeColor: verde,
                                value: is_combo,
                                onChanged: (value) {
                                  setState(() {
                                    is_combo = !is_combo;
                                  });
                                }),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 25, top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    crearBoton(
                      onpress: () {
                        Navigator.pop(context);
                      },
                      context: context,
                      colorBoton: rojo,
                      colorTexto: Colors.white,
                      nombreBoton: 'CANCELAR',
                    ),
                    SizedBox(
                        width: orientacion == Orientation.portrait
                            ? size.width * 0.07
                            : size.width * 0.05),
                    crearBoton(
                      onpress: () {
                        submit();
                      },
                      context: context,
                      colorBoton: amarillo,
                      colorTexto: verde,
                      nombreBoton: 'GUARDAR',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget crearNombreDelProducto(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Nombre del Producto',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          TextFormField(
            validator: (value) => validar.validateGenerico(value),
            focusNode: nombreProductoFocus,
            controller: nombreProductoController,
            decoration: InputDecoration(
              hintText: 'Hamburguesa',
            ),
            onFieldSubmitted: (value) {
              descripcionProductoFcus.requestFocus();
            },
          ),
          // Divider(color: Colors.grey)
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Widget descripcion(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Descripcion',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          TextFormField(
            validator: (value) {
              return validar.validateGenerico(value);
            },
            focusNode: descripcionProductoFcus,
            controller: descripcionProductoController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Pan + Carne + Queso + Lechuga',
            ),
          ),
          // Divider(color: Colors.grey)
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Widget codigo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('codigo',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          TextFormField(
            // validator: (value){
            //   return validar.validateGenerico(value);
            // },
            focusNode: codigoFocus,
            controller: codigoController,

            // maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Opcional',
            ),
            //    onFieldSubmitted: (value){
            //    cantidadFocus.requestFocus();
            //  },
          ),
          // Divider(color: Colors.grey)
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  // Widget cantidad(BuildContext context) {

  //   return Padding(
  //     padding: const EdgeInsets.only(right: 20.0, left: 20.0),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Text('cantidad',style: TextStyle(fontSize:13,fontWeight: FontWeight.bold)),
  //           ],
  //         ),
  //         TextFormField(

  //           // validator: (value){
  //             // return validar.validateNumerico(value);
  //           // },
  //           focusNode:cantidadFocus ,
  //           controller: cantidadController,

  //           // maxLines: 2,
  //           decoration: InputDecoration(hintText: 'Opcional',),

  //         ),
  //         // Divider(color: Colors.grey)
  //         SizedBox(height:15,)
  //       ],
  //         ),
  //   );
  // }

  Widget crearBoton({
    Function onpress,
    BuildContext context,
    String nombreBoton,
    Color colorBoton,
    Color colorTexto,
  }) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: 35,
      width: orientation == Orientation.portrait
          ? size.width * 0.35
          : size.width * 0.25,
      child: RaisedButton(
        elevation: 2,
        color: colorBoton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Text(nombreBoton,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.width < 241 ? 8 : 10,
                color: colorTexto)),
        onPressed: onpress,
      ),
    );
  }

  Widget boton({
    textoBoton,
    colorBoton,
    Function onpress,
    String texto,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(texto),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            width: size.width > 535 ? 117.7 : size.width * 0.22,
            height: 20,
            child: RaisedButton(
              elevation: 2,
              child: Container(
                width: size.width * 0.22,
                child: Text(
                  textoBoton ?? '',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              onPressed: onpress,
              color: colorBoton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  precioProducto({
    bool activo,
    BuildContext context,
    String textoSuperior,
    String textoSuperiorBoton,
    // var numero,
  }) {
    //  num numero=0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: orientacion == Orientation.portrait
                ? size.width * 0.034
                : size.width * 0.02),
        Container(
          width: size.width * 0.45,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(textoSuperior ?? '',
                      style: TextStyle(
                          fontSize: orientacion == Orientation.portrait
                              ? size.width * 0.027
                              : size.width * 0.017,
                          color: estadoPromocion == "si"
                              ? Colors.grey
                              : Colors.black,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              // estadoPromocion == 'si'
              //     ? Container(
              //         child: Text(valorProducto.toString()),
              //       )
              //     :
              TextFormField(
                controller: valorProductoController,
                focusNode: valorProductoFocus,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly,ThousandsFormatter( formatter: NumberFormat("###,###,###", "es-co"))],
                onChanged: (v) {
                  valorProducto = int.parse(v.replaceAll(new RegExp(r'\.'), ''));
                },
                onFieldSubmitted: (value) {
                  valorPromocionFocus.requestFocus();
                },
              )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Text(
              //         '\$ ${formatter.format(int.parse(valorProducto.toString()))}',
              //         style: TextStyle(
              //             // fontFamily: ,
              //             decoration: estadoPromocion == "si"
              //                 ? TextDecoration.lineThrough
              //                 : TextDecoration.none,
              //             fontSize: orientacion == Orientation.portrait
              //                 ? size.width * 0.028
              //                 : size.width * 0.02,
              //             color: Color.fromRGBO(155, 155, 155, 1))),
              //   ],
              // ),
              // Divider(
              //   color: Colors.grey,
              //   endIndent: size.width * 0.015,
              // ),
            ],
          ),
        ),
        SizedBox(
            width: orientacion == Orientation.portrait
                ? size.width * 0.01
                : size.width * 0.01),
        Row(
          children: [
            GestureDetector(
              onTap: activo == true
                  ? () {
                      setState(() {
                        valorProducto -= 100;
                        valorProductoController.text = valorProducto
                            .toString()
                            .replaceAll(new RegExp(r'\.'), '');
                      });
                    }
                  : () {},
              child: Image(
                  color: activo == true ? null : Colors.transparent,
                  width: orientacion == Orientation.portrait
                      ? size.width / 18
                      : size.width / 23,
                  image: AssetImage('assets/Min.png')),
            ),
            SizedBox(width: size.width * 0.03),
            GestureDetector(
              onLongPress: activo == true
                  ? () {
                      setState(() {
                        valorProducto += 50000;
                      });
                      valorProductoController.text = valorProducto
                          .toString();
                    }
                  : () {},
              onTap: activo == true
                  ? () {
                      setState(() {
                        valorProducto += 1000;
                      });
                      valorProductoController.text = valorProducto
                          .toString();
                    }
                  : () {},
              child: Image(
                  color: activo == true ? null : Colors.transparent,
                  width: orientacion == Orientation.portrait
                      ? size.width / 18
                      : size.width / 23,
                  image: AssetImage('assets/Add.png')),
            )
          ],
        ),
      ],
    );
  }

  precioPromo({
    bool activo,
    BuildContext context,
    String textoSuperior,
    String textoSuperiorBoton,
    // var numero,
  }) {
    //  num numero=0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: orientacion == Orientation.portrait
                ? size.width * 0.034
                : size.width * 0.02),
        Container(
          width: size.width * 0.45,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(textoSuperior ?? '',
                      style: TextStyle(
                          color: estadoPromocion == "no"
                              ? Colors.grey
                              : Colors.black,
                          fontSize: orientacion == Orientation.portrait
                              ? size.width * 0.027
                              : size.width * 0.017,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              TextFormField(
                controller: valorPromocionController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsFormatter(
                      formatter: NumberFormat("###,###,###", "es-co"))
                ],
                //  initialValue:'\$ ${formatter.format(int.parse(valorPromocion.toString()))}',
                onChanged: (v) {
                  valorPromocion = int.parse(v.replaceAll(new RegExp(r'\.'), ''));
                  // setState(() {

                  // });
                },
                // controller: valorPromocionController,
                focusNode: valorPromocionFocus,
                // enabled: estadoPromocion == 'no' ? false : true,
              )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Text(
              //         '\$ ${formatter.format(int.parse(valorPromocion.toString()))}',
              //         style: TextStyle(
              //             fontSize: orientacion == Orientation.portrait
              //                 ? size.width * 0.028
              //                 : size.width * 0.02,
              //             color: Color.fromRGBO(155, 155, 155, 1))),
              //   ],
              // ),
              // Divider(
              //   color: Colors.grey,
              //   endIndent: size.width * 0.015,
              // ),
            ],
          ),
        ),
        SizedBox(
            width: orientacion == Orientation.portrait
                ? size.width * 0.01
                : size.width * 0.01),
        Row(
          children: [
            GestureDetector(
              onTap: activo == true
                  ? () {
                      setState(() {
                        valorPromocion -= 100;
                        valorPromocionController.text =
                            valorPromocion.toString();
                      });
                    }
                  : () {},
              child: Image(
                  color: activo == true ? null : Colors.transparent,
                  width: orientacion == Orientation.portrait
                      ? size.width / 20
                      : size.width / 25,
                  image: AssetImage('assets/Min.png')),
            ),
            SizedBox(width: size.width * 0.03),
            GestureDetector(
              onTap: activo == true
                  ? () {
                      setState(() {
                        valorPromocion += 1000;
                        valorPromocionController.text =
                            valorPromocion.toString();
                      });
                    }
                  : () {},
              child: Image(
                  color: activo == true ? null : Colors.transparent,
                  width: orientacion == Orientation.portrait
                      ? size.width / 20
                      : size.width / 25,
                  image: AssetImage('assets/Add.png')),
            )
          ],
        ),
      ],
    );
  }

  void submit() async {
    // print('ok');
    if (!formKey.currentState.validate()) {
      return null;
    }
    // load(context);

    var resp = await productosProvider.postProducto(context,
        edit: element['producto'] == null ? false : true,
        producto: element['producto'] == null
            ? ProductoModel(
                urlImagenProducto: 'dasdasd',
                titulo: "${nombreProductoController.text}",
                descripcion: '${descripcionProductoController.text}',
                codigo: "${codigoController.text}",
                disponibilidad: estadoProducto == "visible" ? 1 : 0,
                precio: "$valorProducto",
                precioPromo: "$valorPromocion",
                isCombo: is_combo == true ? 1 : 0,
                isPromo: estadoPromocion == "si" ? 1 : 0,
                // existencia:cantidadController.text.isEmpty?'0':cantidadController.text,
                idAliado: pref.id_aliado,
                idCategoriaProducto: 7878,
              )
            : ProductoModel(
                id: element['producto'].id,
                urlImagenProducto: 'dasdasd',
                titulo: "${nombreProductoController.text}",
                descripcion: '${descripcionProductoController.text}',
                codigo: "${codigoController.text}",
                disponibilidad: estadoProducto == "visible" ? 1 : 0,
                precio: "$valorProducto",
                precioPromo: "$valorPromocion",
                isCombo: is_combo == true ? 1 : 0,
                isPromo: estadoPromocion == "si" ? 1 : 0,
                // existencia:cantidadController.text.isEmpty?'0':cantidadController.text,
                idAliado: pref.id_aliado,
                idCategoriaProducto: 7878,
              ));

    Map<dynamic, dynamic> decodedResp = jsonDecode(resp);

    if (decodedResp['message'] == 'The given data was invalid.') {
      Navigator.pop(context);
      print(decodedResp.toString() + '---------------------------------Bad');
      var respModel = errorsFormModelFromJson(resp);
      List<Widget> errors = [];
      respModel.errors.forEach((key, value) {
        errors
          ..add(Text(
            value.join(),
          ))
          ..add(Divider());
      });

      alerta(context,
          contenido: Column(
            children: errors,
          ));
    }
    print(resp);
    if (decodedResp['success'] == true) {
      try {
        var resp = await productosProvider
            .obtenerProducto(context)
            .timeout(Duration(seconds: 10), onTimeout: () {
          throw {
            Navigator.pop(context),
            alerta(context,
                contenido: Text("No hay conexion con el servidor."),
                acciones: Container()),
          };
        });

        Map<dynamic, dynamic> decodedResp = jsonDecode(resp);

        if (decodedResp['success']) {
          var respModel = respProductoFromJson(resp);

          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.of(context).pushNamed('ProductosAliados', arguments: respModel.data);
        }
      } catch (e) {
        Navigator.pop(context);
        return alerta(context, contenido: Text(e), acciones: Container());
      }

      print(decodedResp.toString() + '---------------------------------Good');
    }
  }
}
