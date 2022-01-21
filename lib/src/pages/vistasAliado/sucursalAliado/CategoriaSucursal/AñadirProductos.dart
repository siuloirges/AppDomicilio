import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/validaciones_utils.dart';

class FormularioAnadirProducto extends StatefulWidget {
  @override
  _FormularioAnadirProductoState createState() => _FormularioAnadirProductoState();
}

class _FormularioAnadirProductoState extends State<FormularioAnadirProducto> {

  @override
  void dispose() { 
    existenciaController.dispose();
    seleccionado =null;
    focus.dispose();
    
    super.dispose();
  }
  
  PeticionesHttpProvider http = new PeticionesHttpProvider();
  Validaciones validaciones = new Validaciones();
 var formKey = GlobalKey<FormState>();
 TextEditingController existenciaController = new TextEditingController();
 FocusNode focus = new FocusNode();
 PreferenciasUsuario pref =new PreferenciasUsuario(); 
  Funciones funciones = new Funciones();
 Map element;
 dynamic seleccionado;  
  @override
  Widget build(BuildContext context) {
    // print(pref.token);
    // print(existenciaController.text);
    element = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    // print(element);
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // actions: [IconButton(icon:Icon(Icons.replay),onPressed: (){
        // //  rest();
        // },)],
        backgroundColor: amarillo,
        title: Text('Añadir Producto',style:TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: verde),
        
      ),
      body:element!=null? Stack(children: [

       Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Container(
               height: size.height/1.33,
          child:ListView.builder(

              itemCount: element['productos'].length,
              itemBuilder: (BuildContext context,int i){
              
               return GestureDetector(
        onTap: (){
          
          seleccionado = {

           "nombre":"${element['productos'][i].titulo}",
           "id_producto":"${element['productos'][i].id}",
           "id_categoria":"${element['id_categoria']}",
           "id_sucursal":"${element['id_sucursal']}",
           "id_aliado":"${pref.id_aliado}",
          

          };
        
          existenciaController.text = ''; 
           // print('---------------.'+existenciaController.text.toString()+'.--------------');
          setState(() {
            
          });
        },
        child: Container(
          color:Colors.transparent,
          child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
             children: [
               Container(
                 decoration: ShapeDecoration(color: Colors.red,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              
                 height: 100,
                 width: 100,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                  element['productos'][i].isPromo==1?Container(
                     decoration: ShapeDecoration(color: Colors.redAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17),))),
                     child: Center(child: Text('Promo',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),),
                     // color: Colors.white,
                     height: 25,
                     width: 100,
                   ):Container(),
                 ],),
               ),
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(5.0),
                       child: Text('${element['productos'][i].titulo}',style: TextStyle(fontWeight: FontWeight.bold,),),
                     ),
                     Padding(padding: const EdgeInsets.all(5.0),child: Text( element['productos'][i].isPromo==0?'Precio: \$${element['productos'][i].precio}':'Precio Promo: \$${element['productos'][i].precioPromo}'),),
                     Padding(padding: const EdgeInsets.all(5.0),child: Text(  element['productos'][i].isPromo==1? 'Es un combo':'',style: TextStyle(color: Colors.green),),),
                     // Text('${_globalResp[i].descripcion}'),
                   ]
                 ),
               ),

             ],
           ),
       ),
        ),
               );
              },
      )
    ),
    
           ],
         ),

      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          seleccionado!=null? cantidad():Container(),


          seleccionado==null? Container(
             color: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Seleccione un producto',style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),)),
            ),
          ):Container(
             color: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  FlatButton(onPressed: (){
                    existenciaController.text = 'indefinido';
                  }, child: Text('Marcar dantidad indefinida',style: TextStyle(color: Colors.redAccent,fontWeight:FontWeight.bold))),
                  Center(child: Text('Digite la cantidad del producto',style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),)),
                ],
              ),
            ),
          ),
          guardar(context,size),
           
        ],
      )
    ],):Container(
      child: Center(child: Text('No hay productos creados',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),),
    ),
    );

  }

  cantidad(){
    return Form(
      key: formKey,
          child: Column(
        children: [
           Container(
              color: Colors.black87,
              child: TextFormField(
                
                focusNode: focus,
                autofocus: true,
                controller: existenciaController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                validator: (value)=>validaciones.validateGenerico(value),
                decoration: InputDecoration(
                  errorBorder: InputBorder.none,
                  // errorBorder
                  // fillColor: Colors.white,
                  // hoverColor: Colors.white,
                  //  focusColor: Colors.white,
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold

                  ),
                  suffixIcon:IconButton(icon:Icon(Icons.close,color: blanco),onPressed: (){
                   existenciaController.text = '';
                   seleccionado = null;
                   setState(() {
                     
                   });

                  }),
                  prefix: seleccionado!=null? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(decoration: ShapeDecoration(color: Colors.red,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),width:40,height:40,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${seleccionado['nombre']}',style: TextStyle(fontSize: 10),),
                        )
                      ],
                    ),
                  ):null,
                 border: InputBorder.none,
                 hintStyle: TextStyle(color: Colors.white),
                ),
                 style: TextStyle(color: Colors.white),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
           
        ],
      ),
    );
  }

    Widget guardar(context,Size size){
    return Row(

      // mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Column(
          children: [
          
            Container(
              width: size.width,
              height: size.height/10,
              color: Colors.teal,
              child: RaisedButton(
                elevation: 0,
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color:verde,
                child: Text('Añadir',style: TextStyle(color: Colors.white), ),
                onPressed: (){
                  submit(context);
                }
              ),
            ),
          ],
        ),
      ],
    );
  }
  submit(context )async{
try{
    if(seleccionado==null){return alerta(context,contenido: 'Seleccione un producto',code :false);}
    if(!formKey.currentState.validate()){return null;}
  //  print("-------."+seleccionado['existencia']+".-------");
  //  print('---------------. '+"${existenciaController.text}"+' .--------------');
   dynamic _respuesta = await http.postMethod(context: context,body: {

    "nombre":"${seleccionado['nombre']}",
    "id_producto":"${seleccionado['id_producto']}",
    "id_categoria":"${seleccionado['id_categoria']}",
    "id_sucursal":"${seleccionado['id_sucursal']}",
    "id_aliado":"${seleccionado['id_aliado']}",
    "existencia":"${existenciaController.text}"

  },table: 'existencia',token: pref.token,);
  if (_respuesta['message'] == "expiro") {
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      }
   if(_respuesta['message']=='true'){
    existenciaController.text = '';
    seleccionado = null;
    setState(() {
      
    });
    Navigator.pop(context);
    return '';
   }
   if(_respuesta['message']=='false'){
     return alerta(context,contenido:_respuesta['data'],code:false );
   }



 }catch(e){
  alerta(context,contenido:e.toString(),code:false );
 }


  }
 
}