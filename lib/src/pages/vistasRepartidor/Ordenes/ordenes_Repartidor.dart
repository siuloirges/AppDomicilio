import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/Ordenes/model/respuestaOrdenesRepartidor.dart';
// import 'model/RespPedidoAliado.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("###,###,###", "es-co");
PeticionesHttpProvider _http = new PeticionesHttpProvider();
PreferenciasUsuario _pref = new PreferenciasUsuario();
Funciones funciones = new Funciones();

class OrdenesRepartidor extends StatefulWidget {
  OrdenesRepartidor({Key key}) : super(key: key);

  @override
  _OrdenesRepartidorState createState() => _OrdenesRepartidorState();
}

class _OrdenesRepartidorState extends State<OrdenesRepartidor> {
  PageController pageController = new PageController();
  ScrollController scrollController = new ScrollController();
  int getGeneralPage = 0;
  Size size;
  Map element;
  int indice = 0;

  String ruta;
  @override
  void dispose() {
    indice = 0;
    pedido.dispose();

    // pedido.setGeneralPage=0;
    super.dispose();
  }

  PedidoRepartidorProvider pedido;
  @override
  Widget build(BuildContext context) {
    pedido = Provider.of<PedidoRepartidorProvider>(context);
    _pref.activo = 'true';

    if (element == null) {
      element = ModalRoute.of(context).settings.arguments;
      getGeneralPage = element['page'];
      indice = element['indice'];
       if(element['page']==0){

     }else{
      setPage();
     }
    }

    ruta = "repartidor_id=${_pref.user_id}";

    final style = Colors.grey[350];
    final styleActive = Colors.green;
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.replay_outlined),
            onPressed: () {
              pedido.reload();
              indice = 0;
            },
          )
        ],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Pedidos',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: amarillo,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              getGeneralPage == 0
                  ? 'Pendientes - ${pedido?.getPglobalResp['total'] ?? ''}'
                  : getGeneralPage == 1
                      ? 'En transito - ${pedido?.getTglobalResp['total'] ?? ''}'
                      : getGeneralPage == 2
                          ? 'Entregadas - ${pedido?.getEglobalResp['total'] ?? ''}'
                          : 'Canceladas - ${pedido?.getCglobalResp['total'] ?? ''}',
              style: TextStyle(
                  fontSize: 20, color: verde, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            //  color:blanco,
            //  height: 20,
            width: size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 3,
                  width: 50,
                  color: getGeneralPage == 0 ? styleActive : style,
                ),
                Container(
                  height: 3,
                  width: 50,
                  color: getGeneralPage == 1 ? styleActive : style,
                ),
                Container(
                  height: 3,
                  width: 50,
                  color: getGeneralPage == 2 ? styleActive : style,
                ),
                Container(
                  height: 3,
                  width: 50,
                  color: getGeneralPage == 3 ? styleActive : style,
                ),
              ],
            ),
          ),
          Expanded(
              child: PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {});
              getGeneralPage = value;
            },
            scrollDirection: Axis.horizontal,
            children: [
              Module(
                  whenLoading: pedido.getPglobalResp['data'] == null,
                  whenVoid: pedido.getPglobalResp['data'] == 'vacio',
                  //  peticion:!pedido.getGpeticion==false,
                  tipo: 'P',
                  ruta: ruta,
                  indice: indice),
              Module(
                  whenLoading: pedido.getTglobalResp['data'] == null,
                  whenVoid: pedido.getTglobalResp['data'] == 'vacio',
                  //  peticion:!pedido.getGpeticion==false,
                  tipo: 'T',
                  ruta: ruta,
                  indice: indice),
              Module(
                  whenLoading: pedido.getEglobalResp['data'] == null,
                  whenVoid: pedido.getEglobalResp['data'] == 'vacio',
                  //  peticion:!pedido.getGpeticion==false,
                  tipo: 'E',
                  ruta: ruta,
                  indice: indice),
              Module(
                  whenLoading: pedido.getCglobalResp['data'] == null,
                  whenVoid: pedido.getCglobalResp['data'] == 'vacio',
                  //  peticion:!pedido.getGpeticion==false,
                  tipo: 'C',
                  ruta: ruta,
                  indice: indice),

              //  Autorizadas(),
              //  Preparadas(),
              //  EnTransito(),
              //  Entregadas(),
              //  Canceladas(),
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  //  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                height: 60,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                        pageController.previousPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.decelerate);
                      },
                      child: Container(
                        height: 50,
                        width: size.width / 3,
                        color: Colors.transparent,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                        pageController.nextPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.decelerate);
                      },
                      child: Container(
                        height: 50,
                        width: size.width / 3,
                        color: Colors.transparent,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
   setPage()async{
    //  for(element['page'];getGeneralPage<element['page'];getGeneralPage++){
        
    //  
    await Future.delayed(Duration( milliseconds: 500));
     pageController.animateToPage(element['page'], duration: Duration(seconds: 1), curve: Curves.decelerate);
      getGeneralPage= element['page'];
       setState(() {
           
         });
  }
}

//------------------|Page 0|-------------------------------------------------------
class Module extends StatefulWidget {
  // bool peticion;
  String tipo;
  bool whenLoading;
  bool whenVoid;
  String ruta;
  int indice;
  // Widget bodyWidget;

  Module({
    Key key,
    //  this.peticion,
    this.indice,
    this.ruta,
    this.tipo,
    this.whenLoading,
    this.whenVoid,
    //  this.bodyWidget,
  }) : super(key: key);

  @override
  ModuleState createState() => ModuleState();
}

class ModuleState extends State<Module> {
  Size size;
  bool peticion;
  PedidoRepartidorProvider pedido;
  TextEditingController motivoController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    switch (widget.tipo) {
      case 'P':
        {
          peticion = pedido?.getPpeticion ?? false;
        }
        break;
      case 'T':
        {
          peticion = pedido?.getTpeticion ?? false;
        }
        break;
      case 'E':
        {
          peticion = pedido?.getEpeticion ?? false;
        }
        break;
      case 'C':
        {
          peticion = pedido?.getCpeticion ?? false;
        }
        break;
      default:
        {}
        break;
    }

    pedido = Provider.of<PedidoRepartidorProvider>(context);

    if (peticion == false) {
      switch (widget.tipo) {
        case 'P':
          {
            pedido.setPpeticion = true;
          }
          break;
        case 'T':
          {
            pedido.setTpeticion = true;
          }
          break;
        case 'E':
          {
            pedido.setEpeticion = true;
          }
          break;
        case 'C':
          {
            pedido.setCpeticion = true;
          }
          break;
        default:
          {}
          break;
      }
      pedir();
    }

    return Container(
        child: widget.whenLoading == true
            ? Center(
                child: loading(),
              )
            : widget.whenVoid == true
                ? Center(
                    child: Text(
                    'Vacio',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ))
                : body());
  }

  body() {
    switch (widget.tipo) {
      case 'P':
        {
          return pageP();
        }
        break;
      case 'T':
        {
          return pageT();
        }
        break;
      case 'E':
        {
          return pageE();
        }
        break;
      case 'C':
        {
          return pageC();
        }
        break;
      default:
        {}
        break;
    }
  }

  pedir() async {
    print('-------|Page ${widget.tipo}|-------');
    String estado;
    int currenPage;

    switch (widget.tipo) {
      case 'P':
        {
          currenPage = pedido.getPcurrenPage;
        }
        break;
      case 'T':
        {
          currenPage = pedido.getTcurrenPage;
        }
        break;
      case 'E':
        {
          currenPage = pedido.getEcurrenPage;
        }
        break;
      case 'C':
        {
          currenPage = pedido.getCcurrenPage;
        }
        break;
      default:
        {}
        break;
    }

    switch (widget.tipo) {
      case 'P':
        {
          estado = 'preparada';
        }
        break;
      case 'T':
        {
          estado = 'en_transito';
        }
        break;
      case 'E':
        {
          estado = 'entregada';
        }
        break;
      case 'C':
        {
          estado = 'cancelada';
        }
        break;
      default:
        {}
        break;
    }

    Map _resp = await _http.getMethod(
        context: context,
        table: 'pedido?${widget.ruta}&estado=$estado&page=$currenPage',
        token: _pref.token);
    if (_resp['message'] == "expiro") {
      await funciones.closeSection(context);
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('IniciarSesion');
      return alerta(context,
          titulo: 'alerta',
          code: false,
          contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
    }

    if (_resp['message'] == 'false') {
      return alerta(context, code: false, contenido: 'Error');
    }

    if (_resp['message'] == 'true') {
      var respPedidosAliado;
      try {
        respPedidosAliado = respPedidosRepartidor(_resp['resp']);
        //TODO IMPLEMENTAR MODELO
      } catch (error) {
        return alerta(
          context,
          code: false,
          contenido: 'Error model $error ${_resp['resp']}',
        );
      }
      //  respPedidosAliado.data.data = respGlobal;
      if (respPedidosAliado?.data?.data?.length == 0) {
        switch (widget.tipo) {
          case 'P':
            {
              pedido.setPglobalResp(respPedidosAliado.data.data, true,
                  respPedidosAliado.data.total);
            }
            break;
          case 'T':
            {
              pedido.setTglobalResp(respPedidosAliado.data.data, true,
                  respPedidosAliado.data.total);
            }
            break;
          case 'E':
            {
              pedido.setEglobalResp(respPedidosAliado.data.data, true,
                  respPedidosAliado.data.total);
            }
            break;
          case 'C':
            {
              pedido.setCglobalResp(respPedidosAliado.data.data, true,
                  respPedidosAliado.data.total);
            }
            break;
          default:
            {}
            break;
        }
      } else {
        switch (widget.tipo) {
          case 'P':
            {
              pedido.setPglobalResp(respPedidosAliado.data.data, false,
                  respPedidosAliado.data.total);
            }
            break;
          case 'T':
            {
              pedido.setTglobalResp(respPedidosAliado.data.data, false,
                  respPedidosAliado.data.total);
            }
            break;
          case 'E':
            {
              pedido.setEglobalResp(respPedidosAliado.data.data, false,
                  respPedidosAliado.data.total);
            }
            break;
          case 'C':
            {
              pedido.setCglobalResp(respPedidosAliado.data.data, false,
                  respPedidosAliado.data.total);
            }
            break;
          default:
            {}
            break;
        }
      }
    }
  }

  ordenCardP(element, index) {
    // int key = index*2;
    return Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
        child: Dismissible(
          background: Container(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'En transito',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.near_me, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          direction: DismissDirection.startToEnd,
          onDismissed: (value) async {
            Map _resp = await _http.putMethod(
              body: {
                "roll": _pref.rol,
                "estado": "en_transito",
                "generada": "",
                "autorizada": "",
                "preparada": "",
                "en_transito": "1",
                "entregada": "",
                "cancelada": ""
              },
              context: context,
              token: _pref.token,
              table: 'pedido',
              id: element.id,
            );

            if (_resp['message'] == "expiro") {
              await funciones.closeSection(context);
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('IniciarSesion');
              return alerta(context,
                  titulo: 'alerta',
                  code: false,
                  contenido:
                      'Tiempo de conexion agotado, inicie sesion nuevamente.');
            }

            if (_resp['message'] == 'false') {
              pedido.reload();
              return alerta(context, code: false, contenido: 'Error');
            }

            if (_resp['message'] == 'true') {}
          },
          key: UniqueKey(),
          child: Card(
            color:
                widget.indice == element.id ? Colors.amberAccent[100] : blanco,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            // color: Colors.redAccent,
                            child: Text('Cliente: ${element.cliente.nombre}',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: negro,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1),
                          ),
                          Container(
                            width: 150,
                            // color: Colors.redAccent,
                            child: Text('ID: ${element.numeroPedido}',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: verde,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1),
                          ),
                          Container(
                            width: 150,
                            // color: Colors.redAccent,
                            child: Text('${element.direccion.direccion}',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(
                                        index + index, 111, index * 03, 0.5)),
                                maxLines: 2),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        // mainAxisAlignment: Mai,
                        children: [
                          Text(
                              '\$${formatter.format(int.parse(element.precioTotal))}'),
                          Text('${element.estado}',
                              style: TextStyle(fontSize: 10, color: verde)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        alerta(context,
                            code: true,
                            contenido: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.call,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Telefono sucursal:'),
                                    ],
                                  ),
                                  Text('        ${element.sucursal.telefono}'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //  Icon(Icons.map,size: 25,),

                                  SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.map,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Direccion sucursal:'),
                                    ],
                                  ),
                                  Text('        ${element.sucursal.direccion}'),

                                  //  Text('Direccion sucursal: ${element.sucursal.direccion}'),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.call,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Telefono Cliente:'),
                                    ],
                                  ),
                                  Text('        ${element.cliente.telefono}'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //  Icon(Icons.map,size: 25,),

                                  SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.map,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Direccion Cliente:'),
                                    ],
                                  ),
                                  Text(
                                      '        ${element.direccion.direccion}'),
                                ],
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 15.0,
                        ),
                        child: Container(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.assignment,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color.fromRGBO(
                                    index + index, 181, index * 03, 0.5))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  ordenCardT(element, index) {
    // int key = index*2;
    return Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
        child: Dismissible(
          background: Container(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Entragada',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.done, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          direction: DismissDirection.startToEnd,
          onDismissed: (value) async {
            Map _resp = await _http.putMethod(
              body: {
                "roll": _pref.rol,
                "estado": "entregada",
                "generada": "",
                "autorizada": "",
                "preparada": "",
                "en_transito": "",
                "entregada": "1",
                "cancelada": ""
              },
              context: context,
              token: _pref.token,
              table: 'pedido',
              id: element.id,
            );

            if (_resp['message'] == "expiro") {
              await funciones.closeSection(context);
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('IniciarSesion');
              return alerta(context,
                  titulo: 'alerta',
                  code: false,
                  contenido:
                      'Tiempo de conexion agotado, inicie sesion nuevamente.');
            }

            if (_resp['message'] == 'false') {
              pedido.reload();
              return alerta(context, code: false, contenido: 'Error');
            }

            if (_resp['message'] == 'true') {}
          },
          key: UniqueKey(),
          child: GestureDetector(
            child: Card(
              color: widget.indice == element.id
                  ? Colors.amberAccent[100]
                  : blanco,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Container(
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              // color: Colors.redAccent,
                              child: Text('Cliente: ${element.cliente.nombre}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: negro,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1),
                            ),
                            Container(
                              width: 150,
                              // color: Colors.redAccent,
                              child: Text('ID: ${element.numeroPedido}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: verde,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1),
                            ),
                            Container(
                              width: 150,
                              // color: Colors.redAccent,
                              child: Text('${element.direccion.direccion}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Color.fromRGBO(
                                          index + index, 111, index * 03, 0.5)),
                                  maxLines: 2),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          // mainAxisAlignment: Mai,
                          children: [
                            Text(
                                '\$${formatter.format(int.parse(element.precioTotal))}'),
                            Text('${element.estado}',
                                style: TextStyle(fontSize: 10, color: verde)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          alerta(context,
                              code: true,
                              contenido: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Telefono sucursal:'),
                                      ],
                                    ),
                                    Text(
                                        '        ${element.sucursal.telefono}'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    //  Icon(Icons.map,size: 25,),

                                    SizedBox(
                                      width: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.map,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Direccion sucursal:'),
                                      ],
                                    ),
                                    Text(
                                        '        ${element.sucursal.direccion}'),

                                    //  Text('Direccion sucursal: ${element.sucursal.direccion}'),
                                    SizedBox(
                                      height: 20,
                                    ),

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Telefono Cliente:'),
                                      ],
                                    ),
                                    Text('        ${element.cliente.telefono}'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    //  Icon(Icons.map,size: 25,),

                                    SizedBox(
                                      width: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.map,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Direccion Cliente:'),
                                      ],
                                    ),
                                    Text(
                                        '        ${element.direccion.direccion}'),
                                  ],
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                          ),
                          child: Container(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.assignment,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color.fromRGBO(
                                      index + index, 181, index * 03, 0.5))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  ordenCardE(element, index) {
    // int key = index*2;
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Card(
        color: widget.indice == element.id ? Colors.amberAccent[100] : blanco,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Container(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        // color: Colors.redAccent,
                        child: Text('Cliente: ${element.cliente.nombre}',
                            style: TextStyle(
                                fontSize: 17,
                                color: negro,
                                fontWeight: FontWeight.bold),
                            maxLines: 1),
                      ),
                      Container(
                        width: 150,
                        // color: Colors.redAccent,
                        child: Text('ID: ${element.numeroPedido}',
                            style: TextStyle(
                                fontSize: 10,
                                color: verde,
                                fontWeight: FontWeight.bold),
                            maxLines: 1),
                      ),
                      Container(
                        width: 150,
                        // color: Colors.redAccent,
                        child: Text('${element.direccion.direccion}',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(
                                    index + index, 111, index * 03, 0.5)),
                            maxLines: 2),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    // mainAxisAlignment: Mai,
                    children: [
                      Text(
                          '\$${formatter.format(int.parse(element.precioTotal))}'),
                      Text('${element.estado}',
                          style: TextStyle(fontSize: 10, color: verde)),
                    ],
                  ),
                ),
                GestureDetector(
                         onTap: (){
                             alerta(context,code: true,
                             contenido: SingleChildScrollView(
                                child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(height: 2,),
                                   Row(
                                     children: [
                                       Icon(Icons.call,size: 25,),
                                       SizedBox(width: 5,),
                                      Text('Telefono sucursal:'),
                                     ],
                                   ),
                                  Text('        ${element.sucursal.telefono}'),
                                   SizedBox(height: 5,),
                                  //  Icon(Icons.map,size: 25,),
                                  
                                   SizedBox(width: 5,),
                                   Row(
                                     children: [
                                       Icon(Icons.map,size: 25,),
                                       SizedBox(width: 5,),
                                      Text('Direccion sucursal:'),
                                     ],
                                   ),
                                      Text('        ${element.sucursal.direccion}'),
                                
                                  //  Text('Direccion sucursal: ${element.sucursal.direccion}'),
                                   SizedBox(height: 20,),

                                   Row(
                                     children: [
                                       Icon(Icons.call,size: 25,),
                                       SizedBox(width: 5,),
                                      Text('Telefono Cliente:'),
                                     ],
                                   ),
                                  Text('        ${element.cliente.telefono}'),
                                   SizedBox(height: 5,),
                                  //  Icon(Icons.map,size: 25,),
                                  
                                   SizedBox(width: 5,),
                                   Row(
                                     children: [
                                       Icon(Icons.map,size: 25,),
                                       SizedBox(width: 5,),
                                      Text('Direccion Cliente:'),
                                     ],
                                   ),
                                      Text('        ${element.direccion.direccion}'),
                                
                                  
                                 ],
                               ),
                             )
                             );
                           },
                         child: Padding(
                           padding: const EdgeInsets.only(right:15.0,),
                           child: Container(
                             width: 50,
                             height: 50,
                             child: Icon(Icons.assignment,color: Colors.white,),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(100),
                             color: Color.fromRGBO(index+index, 181, index*03, 0.5)
                             )
                           ),
                         ),
                       ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ordenCardC(element, index) {
    // int key = index*2;
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Card(
        color: widget.indice == element.id ? Colors.amberAccent[100] : blanco,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Container(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        // color: Colors.redAccent,
                        child: Text('Cliente: ${element.cliente.nombre}',
                            style: TextStyle(
                                fontSize: 17,
                                color: negro,
                                fontWeight: FontWeight.bold),
                            maxLines: 1),
                      ),
                      Container(
                        width: 150,
                        // color: Colors.redAccent,
                        child: Text('ID: ${element.numeroPedido}',
                            style: TextStyle(
                                fontSize: 10,
                                color: verde,
                                fontWeight: FontWeight.bold),
                            maxLines: 1),
                      ),
                      Container(
                        width: 150,
                        // color: Colors.redAccent,
                        child: Text('${element.direccion.direccion}',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(
                                    index + index, 111, index * 03, 0.5)),
                            maxLines: 2),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    // mainAxisAlignment: Mai,
                    children: [
                      Text(
                          '\$${formatter.format(int.parse(element.precioTotal))}'),
                      Text('${element.estado}',
                          style: TextStyle(fontSize: 10, color: verde)),
                    ],
                  ),
                ),
               GestureDetector(
                         onTap: (){
                             alerta(context,code: true,
                             contenido: SingleChildScrollView(
                                child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(height: 2,),
                                   Row(
                                     children: [
                                       Icon(Icons.call,size: 25,),
                                       SizedBox(width: 5,),
                                      Text('Telefono sucursal:'),
                                     ],
                                   ),
                                  Text('        ${element.sucursal.telefono}'),
                                   SizedBox(height: 5,),
                                  //  Icon(Icons.map,size: 25,),
                                  
                                   SizedBox(width: 5,),
                                   Row(
                                     children: [
                                       Icon(Icons.map,size: 25,),
                                       SizedBox(width: 5,),
                                      Text('Direccion sucursal:'),
                                     ],
                                   ),
                                      Text('        ${element.sucursal.direccion}'),
                                
                                  //  Text('Direccion sucursal: ${element.sucursal.direccion}'),
                                   SizedBox(height: 20,),

                                   Row(
                                     children: [
                                       Icon(Icons.call,size: 25,),
                                       SizedBox(width: 5,),
                                      Text('Telefono Cliente:'),
                                     ],
                                   ),
                                  Text('        ${element.cliente.telefono}'),
                                   SizedBox(height: 5,),
                                  //  Icon(Icons.map,size: 25,),
                                  
                                   SizedBox(width: 5,),
                                   Row(
                                     children: [
                                       Icon(Icons.map,size: 25,),
                                       SizedBox(width: 5,),
                                      Text('Direccion Cliente:'),
                                     ],
                                   ),
                                      Text('        ${element.direccion.direccion}'),
                                       SizedBox(height: 10,),
                                   Row(
                                     children: [
                                       Icon(Icons.auto_delete_rounded,size: 25,),
                                       SizedBox(width: 5,),
                                      Text('Motivo de anulacion'),
                                     ],
                                   ),
                                      Text('        ${element.motivoAnulacion}'),
                                
                                  
                                 ],
                               ),
                             )
                             );
                           },
                         child: Padding(
                           padding: const EdgeInsets.only(right:15.0,),
                           child: Container(
                             width: 50,
                             height: 50,
                             child: Icon(Icons.assignment,color: Colors.white,),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(100),
                             color: Color.fromRGBO(index+index, 181, index*03, 0.5)
                             )
                           ),
                         ),
                       ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pageP() {
    List<Widget> widgets = [];
    int index = 0;
    pedido.getPglobalResp['data'].forEach((element) {
      widgets.add(ordenCardP(element, index));
      index++;
    });

    return SingleChildScrollView(
      // controller: pedido.getGscrollcontroller,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: widgets
            ..add(pedido.getPglobalResp['fin']
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No hay mas pedidos',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )
                : FlatButton(
                    child: Text('Ver mas '),
                    onPressed: () {
                      pedido.setPcurrenPage();
                    },
                  ))),
    );
  }

  pageT() {
    List<Widget> widgets = [];
    int index = 0;
    pedido.getTglobalResp['data'].forEach((element) {
      widgets.add(ordenCardT(element, index));
      index++;
    });

    return SingleChildScrollView(
      // controller: pedido.getGscrollcontroller,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: widgets
            ..add(pedido.getTglobalResp['fin']
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No hay mas pedidos',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )
                : FlatButton(
                    child: Text('Ver mas '),
                    onPressed: () {
                      pedido.setTcurrenPage();
                    },
                  ))),
    );
  }

  pageE() {
    List<Widget> widgets = [];
    int index = 0;
    pedido.getEglobalResp['data'].forEach((element) {
      widgets.add(ordenCardE(element, index));
      index++;
    });

    return SingleChildScrollView(
      // controller: pedido.getGscrollcontroller,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: widgets
            ..add(pedido.getEglobalResp['fin']
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No hay mas pedidos',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )
                : FlatButton(
                    child: Text('Ver mas '),
                    onPressed: () {
                      pedido.setEcurrenPage();
                    },
                  ))),
    );
  }

  pageC() {
    List<Widget> widgets = [];
    int index = 0;
    pedido.getCglobalResp['data'].forEach((element) {
      widgets.add(ordenCardC(element, index));
      index++;
    });

    return SingleChildScrollView(
      // controller: pedido.getGscrollcontroller,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: widgets
            ..add(pedido.getCglobalResp['fin']
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No hay mas pedidos',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )
                : FlatButton(
                    child: Text('Ver mas'),
                    onPressed: () {
                      pedido.setCcurrenPage();
                    },
                  ))),
    );
  }
}

//--------------------------|Provider|--------------------------------

class PedidoRepartidorProvider extends ChangeNotifier {
//  bool _activo = false;
//   get getActivo=>_activo;
//   set setActivo(value){
//     _activo = true;
//   }

//----------------------|Page 2|-------------------------------------------

  bool _peticionP = false;
  dynamic _respGlobalP = [];
  int _currenPageP = 1;
  bool _finPageP = false;
  int totalP;
  // ScrollController scrollGcontroller= new ScrollController();

  // get getGscrollcontroller => scrollGcontroller;
  get getPpeticion => _peticionP;
  get getPglobalResp =>
      {"fin": _finPageP, "data": _respGlobalP, "total": totalP};
  get getPcurrenPage => _currenPageP;

  set setPpeticion(estado) {
    _peticionP = estado;
    // notifyListeners();
  }

  setPglobalResp(List dato, bool vooid, int total) {
    totalP = total;
    if (vooid) {
      if (_currenPageP > 1) {
        _finPageP = true;
      } else {
        _respGlobalP = 'vacio';
      }
    } else {
      if (_currenPageP <= 1) {
        _respGlobalP = [];
        dato.forEach((element) {
          _respGlobalP.add(element);
        });
        _finPageP = false;
        //  _currenPageG++;
      } else {
        dato.forEach((element) {
          _respGlobalP.add(element);
        });
        _finPageP = false;
        //  _currenPageG++;
      }
    }

    notifyListeners();
  }

  setPcurrenPage() {
    _currenPageP++;
    _peticionP = false;
    notifyListeners();
  }

//----------------------|Page 3|--------------------------------------------

  int totalT;
  bool _peticionT = false;
  dynamic _respGlobalT = [];
  int _currenPageT = 1;
  bool _finPageT = false;
  // ScrollController scrollGcontroller= new ScrollController();

  // get getGscrollcontroller => scrollGcontroller;
  get getTpeticion => _peticionT;
  get getTglobalResp =>
      {"fin": _finPageT, "data": _respGlobalT, "total": totalT};
  get getTcurrenPage => _currenPageT;

  set setTpeticion(estado) {
    _peticionT = estado;
    // notifyListeners();
  }

  setTglobalResp(List dato, bool vooid, int total) {
    totalT = total;

    if (vooid) {
      if (_currenPageT > 1) {
        _finPageT = true;
      } else {
        _respGlobalT = 'vacio';
      }
    } else {
      if (_currenPageT <= 1) {
        _respGlobalT = [];
        dato.forEach((element) {
          _respGlobalT.add(element);
        });
        _finPageT = false;
        //  _currenPageG++;
      } else {
        dato.forEach((element) {
          _respGlobalT.add(element);
        });
        _finPageT = false;
        //  _currenPageG++;
      }
    }

    notifyListeners();
  }

  setTcurrenPage() {
    _currenPageT++;
    _peticionT = false;
    notifyListeners();
  }

//----------------------|Page 4|--------------------------------------------

  int totalE;
  bool _peticionE = false;
  dynamic _respGlobalE = [];
  int _currenPageE = 1;
  bool _finPageE = false;
  // ScrollController scrollGcontroller= new ScrollController();

  // get getGscrollcontroller => scrollGcontroller;
  get getEpeticion => _peticionE;
  get getEglobalResp =>
      {"fin": _finPageE, "data": _respGlobalE, "total": totalE};
  get getEcurrenPage => _currenPageE;

  set setEpeticion(estado) {
    _peticionE = estado;
    // notifyListeners();
  }

  setEglobalResp(List dato, bool vooid, int total) {
    totalE = total;
    if (vooid) {
      if (_currenPageE > 1) {
        _finPageE = true;
      } else {
        _respGlobalE = 'vacio';
      }
    } else {
      if (_currenPageE <= 1) {
        _respGlobalE = [];
        dato.forEach((element) {
          _respGlobalE.add(element);
        });
        _finPageE = false;
        //  _currenPageG++;
      } else {
        dato.forEach((element) {
          _respGlobalE.add(element);
        });
        _finPageE = false;
        //  _currenPageG++;
      }
    }

    notifyListeners();
  }

  setEcurrenPage() {
    _currenPageE++;
    _peticionE = false;
    notifyListeners();
  }

//----------------------|Page 5|--------------------------------------------

  bool _peticionC = false;
  dynamic _respGlobalC = [];
  int _currenPageC = 1;
  bool _finPageC = false;
  int totalC;
  // ScrollController scrollGcontroller= new ScrollController();

  // get getGscrollcontroller => scrollGcontroller;
  get getCpeticion => _peticionC;
  get getCglobalResp =>
      {"fin": _finPageC, "data": _respGlobalC, "total": totalC};
  get getCcurrenPage => _currenPageC;

  set setCpeticion(estado) {
    _peticionC = estado;
    // notifyListeners();
  }

  setCglobalResp(List dato, bool vooid, int total) {
    totalC = total;
    if (vooid) {
      if (_currenPageC > 1) {
        _finPageC = true;
      } else {
        _respGlobalC = 'vacio';
      }
    } else {
      if (_currenPageC <= 1) {
        _respGlobalC = [];
        dato.forEach((element) {
          _respGlobalC.add(element);
        });
        _finPageC = false;
        //  _currenPageG++;
      } else {
        dato.forEach((element) {
          _respGlobalC.add(element);
        });
        _finPageC = false;
        //  _currenPageG++;
      }
    }

    notifyListeners();
  }

  setCcurrenPage() {
    _currenPageC++;
    _peticionC = false;
    notifyListeners();
  }

  //-----|Reload|------//

  reload() {
    //---| page 2 |----

    totalP = null;
    _peticionP = false;
    _respGlobalP = null;
    _currenPageP = 1;

    //---| page 3 |----

    totalT = null;
    _peticionT = false;
    _respGlobalT = null;
    _currenPageT = 1;

    //---| page 4 |----
    totalE = null;
    _peticionE = false;
    _respGlobalE = null;
    _currenPageE = 1;

    //---| page 5 |----
    totalC = null;
    _peticionC = false;
    _respGlobalC = null;
    _currenPageC = 1;

    notifyListeners();
  }

  //----DISPOSE-----DISPOSE -----DISPOSE---//
  dispose() {
    totalP = null;
    _peticionP = false;
    _respGlobalP = null;
    _currenPageP = 1;
    totalT = null;
    _peticionT = false;
    _respGlobalT = null;
    _currenPageT = 1;
    totalE = null;
    _peticionE = false;
    _respGlobalE = null;
    _currenPageE = 1;
    totalC = null;
    _peticionC = false;
    _respGlobalC = null;
    _currenPageC = 1;
    _pref.activo = 'false';
  }
}

// "generada",
// "autorizada",
// "preparada",
// "en_transito",
// "entregada",
// "cancelada",
