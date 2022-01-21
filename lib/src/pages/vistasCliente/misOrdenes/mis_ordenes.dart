
import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/vistasCliente/misOrdenes/models/respPedidosCliente.dart';
// import 'model/RespPedidoAliado.dart';
import 'package:intl/intl.dart';

 final formatter = new NumberFormat("###,###,###", "es-co");
PeticionesHttpProvider _http = new PeticionesHttpProvider();
PreferenciasUsuario _pref = new PreferenciasUsuario();
Funciones funciones =new Funciones();

class MisOrdenes extends StatefulWidget {
  MisOrdenes({Key key}) : super(key: key);

  @override
  _MisOrdenesState createState() => _MisOrdenesState();
}

class _MisOrdenesState extends State<MisOrdenes> {

  PageController  pageController = new PageController ();
  ScrollController scrollController = new ScrollController();
  int getGeneralPage=0;
  Size size;
  Map element;
  int indice=0;
  
  String ruta;
  @override
  void dispose() { 
    indice=0;
    pedido.dispose();

    // pedido.setGeneralPage=0;
    super.dispose();
  }

  PedidosClienteProvider pedido;
  @override
  Widget build(BuildContext context) {
    pedido = Provider.of<PedidosClienteProvider>(context);
    _pref.activo='true';

    if(element==null){
     element = ModalRoute.of(context).settings.arguments;
    //  getGeneralPage=element['page'];
     indice=element['indice'];
     if(element['page']==0){

     }else{
      setPage();
     }
     

    }

    ruta = "cliente_id=${_pref.user_id}";


   

    final style = Colors.grey[350];
    final styleActive = Colors.green;
    size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [

          IconButton(icon:Icon(Icons.replay_outlined),onPressed: (){
            pedido.reload();
            indice=0;
          },)

        ],
        centerTitle: true,
        iconTheme:IconThemeData(color: Colors.black) ,
        elevation: 0,title: Text('Pedidos',style: TextStyle(color: Colors.black),),backgroundColor: amarillo,),
     
      body: 
       Column(
         children: [

           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(getGeneralPage==0?'Nuevas - ${pedido?.getGglobalResp['total']??''}':getGeneralPage==1?'Autorizadas - ${pedido?.getAglobalResp['total']??''}':getGeneralPage==2?'Preparadas - ${pedido?.getPglobalResp['total']??''}':getGeneralPage==3?'En transito - ${pedido?.getTglobalResp['total']??''}':getGeneralPage==4?'Entregadas - ${pedido?.getEglobalResp['total']??''}':'Canceladas - ${pedido?.getCglobalResp['total']??''}',style: TextStyle(fontSize: 20,color: verde,fontWeight: FontWeight.bold),),
           ),
           Container(

             width: size.width*1,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 
                Container(height: 2.5,width: 50,color:getGeneralPage==0?styleActive:style,),
                Container(height: 3,width: 50,color:getGeneralPage==1?styleActive:style,),
                Container(height: 3,width: 50,color:getGeneralPage==2?styleActive:style,),
                Container(height: 3,width: 50,color:getGeneralPage==3?styleActive:style,),
                Container(height: 3,width: 50,color:getGeneralPage==4?styleActive:style,),
                Container(height: 3,width: 50,color:getGeneralPage==5?styleActive:style,),

               ],
             ),
           ),

           Expanded(child: PageView(
             controller:pageController ,
             
             onPageChanged: (value){
               setState(() {
                 
               });
              getGeneralPage=value;
             },
             scrollDirection: Axis.horizontal,
             children: [
               
               Module(
                 whenLoading:pedido.getGglobalResp['data']==null,
                 whenVoid:pedido.getGglobalResp['data']=='vacio',
                //  peticion:!pedido.getGpeticion==false,
                 tipo: 'G',
                 ruta:ruta,
                 indice:indice
               ),
               Module(
                 whenLoading:pedido.getAglobalResp['data']==null,
                 whenVoid:pedido.getAglobalResp['data']=='vacio',
                //  peticion:!pedido.getGpeticion==false,
                 tipo: 'A',
                 ruta: ruta,
                 indice:indice
               ),
               Module(
                 whenLoading:pedido.getPglobalResp['data']==null,
                 whenVoid:pedido.getPglobalResp['data']=='vacio',
                //  peticion:!pedido.getGpeticion==false,
                 tipo: 'P',
                 ruta: ruta,
                 indice:indice
               ),
               Module(
                 whenLoading:pedido.getTglobalResp['data']==null,
                 whenVoid:pedido.getTglobalResp['data']=='vacio',
                //  peticion:!pedido.getGpeticion==false,
                 tipo: 'T',
                 ruta: ruta,
                 indice:indice
               ),
               Module(
                 whenLoading:pedido.getEglobalResp['data']==null,
                 whenVoid:pedido.getEglobalResp['data']=='vacio',
                //  peticion:!pedido.getGpeticion==false,
                 tipo: 'E',
                 ruta: ruta,
                 indice:indice
               ),
               Module(
                 whenLoading:pedido.getCglobalResp['data']==null,
                 whenVoid:pedido.getCglobalResp['data']=='vacio',
                //  peticion:!pedido.getGpeticion==false,
                 tipo: 'C',
                 ruta: ruta,
                 indice:indice
               ),
             
              //  Autorizadas(),
              //  Preparadas(),
              //  EnTransito(),
              //  Entregadas(),
              //  Canceladas(),
             ],
           )),

          Padding(
            padding: const EdgeInsets.only(left:0.0,right:0),
            child: Container(
             decoration:  BoxDecoration(
                color: Colors.green,
              //  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
             ),
              height: 60,
              width:size.width,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    
                  });
                  pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.decelerate);
                  
                },
                child: Container(
                    height: 50,
                  width :size.width/3,
                  color:Colors.transparent,
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    
                  });
                  pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.decelerate);
                },
                child: Container(
                  height: 50,
                   width :size.width/3,
                  color:Colors.transparent,
                  child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                ),
              )
              ],)
            ),
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
  PedidosClienteProvider pedido;
  TextEditingController motivoController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
     switch(widget.tipo) { 
         case 'G': {peticion = pedido?.getGpeticion??false;} 
         break; 
         case 'A': {peticion = pedido?.getApeticion??false;} 
         break; 
         case 'P': {peticion = pedido?.getPpeticion??false;} 
         break; 
         case 'T': {peticion = pedido?.getTpeticion??false;} 
         break; 
         case 'E': {peticion = pedido?.getEpeticion??false;} 
         break; 
         case 'C': {peticion = pedido?.getCpeticion??false;} 
         break; default: { } break; 
      } 
    
     pedido = Provider.of<PedidosClienteProvider>(context);

    if(peticion==false){
      
      switch(widget.tipo) { 
         case 'G': {pedido.setGpeticion=true;} 
         break; 
         case 'A': {pedido.setApeticion=true;} 
         break; 
         case 'P': {pedido.setPpeticion=true;} 
         break; 
         case 'T': {pedido.setTpeticion=true;} 
         break; 
         case 'E': {pedido.setEpeticion=true;} 
         break; 
         case 'C': {pedido.setCpeticion=true;} 
         break; default: { } break; 
      } 
      pedir();
    }
    
    return Container(
      child:widget.whenLoading == true?Center(child: loading(),)
      :widget.whenVoid==true
      ?Center(child: Text('Vacio',style
      :TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),))
      :body()
    );
  }

  body(){
    switch(widget.tipo) { 
     case 'G': { return pageG();}
     break; 
     case 'A': {return pageA();} 
     break; 
     case 'P': {return pageP();} 
     break; 
     case 'T': {return pageT();} 
     break; 
     case 'E': {return pageE();} 
     break; 
     case 'C': {return pageC();}  
     break; default: { } break; 
    } 
  }

  

  pedir()async{
    print('-------|Page ${widget.tipo}|-------');
     String estado;
     int currenPage;
     
     switch(widget.tipo) { 
         case 'G': {currenPage=pedido.getGcurrenPage;} 
         break; 
         case 'A': {currenPage=pedido.getAcurrenPage;} 
         break; 
         case 'P': {currenPage=pedido.getPcurrenPage;} 
         break; 
         case 'T': {currenPage=pedido.getTcurrenPage;} 
         break; 
         case 'E': {currenPage=pedido.getEcurrenPage;} 
         break; 
         case 'C': {currenPage=pedido.getCcurrenPage;} 
         break; default: { } break; 
      } 

     switch(widget.tipo) { 
         case 'G': {estado='generada';} 
         break; 
         case 'A': {estado='autorizada';} 
         break; 
         case 'P': {estado='preparada';} 
         break; 
         case 'T': {estado='en_transito';} 
         break; 
         case 'E': {estado='entregada';} 
         break; 
         case 'C': {estado='cancelada';} 
         break; default: { } break; 
    } 

    Map _resp = await _http.getMethod(context: context,table: 'pedido?${widget.ruta}&estado=$estado&page=$currenPage',token: _pref.token);
     if (_resp['message'] == "expiro") {
      await funciones.closeSection(context);
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('IniciarSesion');
     return alerta(context,
          titulo: 'alerta',
          code: false,
          contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
    }
    
    if(_resp['message']=='false'){
    
      return alerta(context,code: false,contenido: 'Error');
    
    }

    if(_resp['message']=='true'){
    
      var respPedidosAliado;
      try{
        respPedidosAliado = respPedidosClienteFromJson(_resp['resp']);
      }catch(error){
       return alerta(context,code: false,contenido: 'Error model $error ${_resp['resp']}',);
      }
      //  respPedidosAliado.data.data = respGlobal;
      if(respPedidosAliado?.data?.data?.length==0){
        switch(widget.tipo) { 
         case 'G': { pedido.setGglobalResp(respPedidosAliado.data.data,true,respPedidosAliado.data.total); } 
         break; 
         case 'A': { pedido.setAglobalResp(respPedidosAliado.data.data,true,respPedidosAliado.data.total);} 
         break; 
         case 'P': { pedido.setPglobalResp(respPedidosAliado.data.data,true,respPedidosAliado.data.total);} 
         break; 
         case 'T': { pedido.setTglobalResp(respPedidosAliado.data.data,true,respPedidosAliado.data.total);} 
         break; 
         case 'E': { pedido.setEglobalResp(respPedidosAliado.data.data,true,respPedidosAliado.data.total);} 
         break; 
         case 'C': { pedido.setCglobalResp(respPedidosAliado.data.data,true,respPedidosAliado.data.total);} 
         break; default: { } break; 
      } 
       
      }else{
        switch(widget.tipo) { 
         case 'G': { pedido.setGglobalResp(respPedidosAliado.data.data,false,respPedidosAliado.data.total); } 
         break; 
         case 'A': { pedido.setAglobalResp(respPedidosAliado.data.data,false,respPedidosAliado.data.total);} 
         break; 
         case 'P': { pedido.setPglobalResp(respPedidosAliado.data.data,false,respPedidosAliado.data.total);} 
         break; 
         case 'T': { pedido.setTglobalResp(respPedidosAliado.data.data,false,respPedidosAliado.data.total);} 
         break; 
         case 'E': { pedido.setEglobalResp(respPedidosAliado.data.data,false,respPedidosAliado.data.total);} 
         break; 
         case 'C': { pedido.setCglobalResp(respPedidosAliado.data.data,false,respPedidosAliado.data.total);} 
         break; default: { } break; 
      } 
      }
    }
  }

   ordenCardG(element,index){
   return  Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: GestureDetector(
          onDoubleTap: (){
            alerta(context,
            
            code: false,
            contenido:element.repartidorId==null? 'Telefono sucursal: ${element.sucursal.telefono}\nDireccion sucursal: ${element.sucursal.direccion}':'Telefono sucursal: ${element.sucursal.telefono}\nDireccion sucursal: ${element.sucursal.direccion}\n\nTelefono repartidor: ${element.sucursal.telefono??'sin telefono'}'
            );          },
                  child: Card(
            color: widget.indice==element.id?Colors.amberAccent[100]:blanco,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: Container(

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
                            child: Text('Cliente: ${element.sucursal.nombre}',style: TextStyle(fontSize: 17,color:negro,fontWeight: FontWeight.bold),maxLines: 2),),
                          Container(
                            width: 150,
                            // color: Colors.redAccent,
                            child: Text('ID: ${element.id}',style: TextStyle(fontSize: 10,color:verde,fontWeight: FontWeight.bold) ,maxLines: 2),),
                          
                          Container(
                            
                            width: 100,
                            // color: Colors.redAccent,
                            child: Text('${element.sucursal.direccion}',style: TextStyle(fontSize: 10,color:Color.fromRGBO(index+index, 111, index*03, 0.5)),overflow:TextOverflow.ellipsis ,maxLines: 2),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        // mainAxisAlignment: Mai,
                        children: [
                          Text('\$${formatter.format(int.parse(element.precioTotal))}'),
                          
                          Text('${element.estado}',style: TextStyle(fontSize: 10,color:verde)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        return alerta(context,code: false, contenido:'¿Quieres cancelar el pedido?',
                        acciones: RaisedButton(
                          child: Text('Si!',style: TextStyle(color: Colors.white),),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),
                          color: Colors.redAccent,
                          onPressed: ()async{
                             Navigator.pop(context);
                             alerta(context,code: true,
                                 contenido: Column(
                                   children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Motivo de anulación'
                                      ),
                                      autofocus: true,
                                      controller: motivoController,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        color: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100)
                                        ),
                                        child: Text('Aceptar',style: TextStyle(color: Colors.white)),
                                        onPressed: () async{
                                         
                                           load(context);
                                          Map _resp=await _http.putMethod(
                                            body:{
                                                "roll":_pref.rol,
                                                "estado":"cancelada",
                                                "generada": "",
                                                "autorizada":"" ,
                                                "preparada" :"",
                                                "en_transito":"",
                                                "entregada" :"",
                                                "cancelada" :"1",
                                                "motivo_anulacion":"${motivoController.text}"
                                            },
                                            context: context,
                                            token: _pref.token,
                                            table: 'pedido',
                                            id:element.id ,
                                          );
                                          Navigator.pop(context);

                                          motivoController.text='';
                                           if (_resp['message'] == "expiro") {
                                             await funciones.closeSection(context);
                                             Navigator.pop(context);
                                             Navigator.pop(context);
                                             Navigator.of(context).pushReplacementNamed('IniciarSesion');
                                             return alerta(context,
                                             titulo: 'alerta',
                                             code: false,
                                             contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
                                           }
                                           
                                           if(_resp['message']=='false'){
                                            
                                             pedido.reload();       
                                             Navigator.pop(context);
                                             return alerta(context,code: false,contenido: 'Error');
                                           
                                           }

                                           if(_resp['message']=='true'){
                                            
                                            pedido.reload();
                                            Navigator.pop(context);
                                           }
                                          
                                        },
                                      ),
                                    )
                                   ],
                                 )
                                 );
                                  
                          }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right:10.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Icon(Icons.clear,color: Colors.white,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          color: Colors.redAccent
                          )
                        ),
                      ),
                    ),
                    // Container(
                    //   width: 10,
                    //   height: 90,
                    //   decoration: BoxDecoration(
                       
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
        )
      );
  }
   ordenCardA(element,index){
    // int key = index*2;
   return  Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Card(
          color: widget.indice==element.id?Colors.amberAccent[100]:blanco,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(

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
                child: Text('${element.numeroPedido}',style: TextStyle(fontSize: 15,color:verde,fontWeight: FontWeight.bold),overflow:TextOverflow.ellipsis ,maxLines: 1),),
              Container(
                
                width: 150,
                // color: Colors.redAccent,
                child: Text('${element.direccion.direccion}',style: TextStyle(fontSize: 10,color:Colors.grey),overflow:TextOverflow.ellipsis ,maxLines: 2),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: Mai,
            children: [
              Text('\$${formatter.format(int.parse(element.precioTotal))}'),
              
              Text('${element.estado}',style: TextStyle(fontSize: 10,color:verde)),
            ],
          ),
        ),
        Container(
          width: 10,
          height: 75,
          decoration: BoxDecoration(
            gradient: RadialGradient(radius: 21,colors: [Color.fromRGBO(index+index, 111, index*03, 0.5),Color.fromRGBO(index+index, 111, index*03, 0.5)])
          ),
        )
       ],
      ),
     ),
    )
   );
  }
   ordenCardP(element,index){
    // int key = index*2;
   return  Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Card(
          color: widget.indice==element.id?Colors.amberAccent[100]:blanco,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(

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
                child: Text('${element.numeroPedido}',style: TextStyle(fontSize: 15,color:verde,fontWeight: FontWeight.bold),overflow:TextOverflow.ellipsis ,maxLines: 1),),
              Container(
                
                width: 150,
                // color: Colors.redAccent,
                child: Text('${element.direccion.direccion}',style: TextStyle(fontSize: 10,color:Colors.grey),overflow:TextOverflow.ellipsis ,maxLines: 2),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: Mai,
            children: [
              Text('\$${formatter.format(int.parse(element.precioTotal))}'),
              
              Text('${element.estado}',style: TextStyle(fontSize: 10,color:verde)),
            ],
          ),
        ),
        Container(
          width: 10,
          height: 75,
          decoration: BoxDecoration(
            gradient: RadialGradient(radius: 21,colors: [Color.fromRGBO(index+index, 111, index*03, 0.5),Color.fromRGBO(index+index, 111, index*03, 0.5)])
          ),
        )
       ],
      ),
     ),
    )
   );
  }
   ordenCardT(element,index){
    // int key = index*2;
    return  Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Card(
          color: widget.indice==element.id?Colors.amberAccent[100]:blanco,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(

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
                child: Text('${element.numeroPedido}',style: TextStyle(fontSize: 15,color:verde,fontWeight: FontWeight.bold),overflow:TextOverflow.ellipsis ,maxLines: 1),),
              Container(
                
                width: 150,
                // color: Colors.redAccent,
                child: Text('${element.direccion.direccion}',style: TextStyle(fontSize: 10,color:Colors.grey),overflow:TextOverflow.ellipsis ,maxLines: 2),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: Mai,
            children: [
              Text('\$${formatter.format(int.parse(element.precioTotal))}'),
              
              Text('${element.estado}',style: TextStyle(fontSize: 10,color:verde)),
            ],
          ),
        ),
        Container(
          width: 10,
          height: 75,
          decoration: BoxDecoration(
            gradient: RadialGradient(radius: 21,colors: [Color.fromRGBO(index+index, 111, index*03, 0.5),Color.fromRGBO(index+index, 111, index*03, 0.5)])
          ),
        )
       ],
      ),
     ),
    )
   );
  }
   ordenCardE(element,index){
    // int key = index*2;
    return  Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Card(
          color: widget.indice==element.id?Colors.amberAccent[100]:blanco,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(

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
                child: Text('${element.numeroPedido}',style: TextStyle(fontSize: 15,color:verde,fontWeight: FontWeight.bold),overflow:TextOverflow.ellipsis ,maxLines: 1),),
              Container(
                
                width: 150,
                // color: Colors.redAccent,
                child: Text('${element.direccion.direccion}',style: TextStyle(fontSize: 10,color:Colors.grey),overflow:TextOverflow.ellipsis ,maxLines: 2),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: Mai,
            children: [
              Text('\$${formatter.format(int.parse(element.precioTotal))}'),
              
              Text('${element.estado}',style: TextStyle(fontSize: 10,color:verde)),
            ],
          ),
        ),
        Container(
          width: 10,
          height: 75,
          decoration: BoxDecoration(
            gradient: RadialGradient(radius: 21,colors: [Color.fromRGBO(index+index, 111, index*03, 0.5),Color.fromRGBO(index+index, 111, index*03, 0.5)])
          ),
        )
       ],
      ),
     ),
    )
   );
  }
   ordenCardC(element,index){
    // int key = index*2;
    return  Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Card(
          color: widget.indice==element.id?Colors.amberAccent[100]:blanco,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(

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
                child: Text('${element.cliente.nombre}',style: TextStyle(fontSize: 15,color:negro,fontWeight: FontWeight.bold),overflow:TextOverflow.ellipsis ,maxLines: 1),),
              Container(
                width: 150,
                // color: Colors.redAccent,
                child: Text('${element.numeroPedido}',style: TextStyle(fontSize: 10,color:verde,fontWeight: FontWeight.bold),overflow:TextOverflow.ellipsis ,maxLines: 1),),
              Container(
                
                width: 150,
                // color: Colors.redAccent,
                child: Text('${element?.motivoAnulacion??"Anulado"}',style: TextStyle(fontSize: 10,color:Colors.grey),overflow:TextOverflow.ellipsis ,maxLines: 2),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: Mai,
            children: [
              Text('\$${formatter.format(int.parse(element.precioTotal))}'),
              
              Text('${element.estado}',style: TextStyle(fontSize: 10,color:rojo)),
            ],
          ),
        ),
        Container(
          width: 10,
          height: 85,
          decoration: BoxDecoration(
            gradient: RadialGradient(radius: 21,colors: [Colors.redAccent,Color.fromRGBO(index+index, 111, index*03, 0.5)])
          ),
        )
                ],
              ),
            ),
          )
      );
  }

  pageG(){
    
    List<Widget> widgets=[]; 
    int index=0;
    pedido.getGglobalResp['data'].forEach((element) {
        widgets.add(
         ordenCardG(element,index)
        );

        index++;
    });

     return SingleChildScrollView(
      // controller: pedido.getGscrollcontroller,
      child: Column(
        
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
       children: widgets..add(
         pedido.getGglobalResp['fin']
         ?Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('No hay mas pedidos',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
         )
         :FlatButton(child: Text('Ver mas'),onPressed: (){pedido.setGcurrenPage();},))
      ),
    );

  }

  pageA(){
    
    List<Widget> widgets=[]; 
    int index=0;
    pedido.getAglobalResp['data'].forEach((element) {
        widgets.add(
           ordenCardA(element,index)
        );
      index++;
    });

     return SingleChildScrollView(
      // controller: pedido.getGscrollcontroller,
      child: Column(
        
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
       children: widgets..add(
         pedido.getAglobalResp['fin']
         ?Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('No hay mas pedidos',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
         )
         :FlatButton(child: Text('Ver mas'),onPressed: (){pedido.setAcurrenPage();},))
      ),
    );

  }
  pageP(){
    
    List<Widget> widgets=[]; 
    int index=0;
    pedido.getPglobalResp['data'].forEach((element) {
        widgets.add(
           ordenCardP(element,index)
        );
      index++;
    });
     return SingleChildScrollView(
      // controller: pedido.getGscrollcontroller,
      child: Column(
        
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
       children: widgets..add(
         pedido.getPglobalResp['fin']
         ?Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('No hay mas pedidos',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
         )
         :FlatButton(child: Text('Ver mas '),onPressed: (){pedido.setPcurrenPage();},))
      ),
    );

  }
  pageT(){
    
    List<Widget> widgets=[]; 
    int index=0;
    pedido.getTglobalResp['data'].forEach((element) {
        widgets.add(
           ordenCardT(element,index)
        );
      index++;
    });

     return SingleChildScrollView(
      // controller: pedido.getGscrollcontroller,
      child: Column(
        
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
       children: widgets..add(
         pedido.getTglobalResp['fin']
         ?Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('No hay mas pedidos',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
         )
         :FlatButton(child: Text('Ver mas '),onPressed: (){pedido.setTcurrenPage();},))
      ),
    );

  }
  pageE(){
    
    List<Widget> widgets=[]; 
    int index=0;
    pedido.getEglobalResp['data'].forEach((element) {
        widgets.add(
           ordenCardE(element,index)
        );
      index++;
    });

     return SingleChildScrollView(
      // controller: pedido.getGscrollcontroller,
      child: Column(
        
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
       children: widgets..add(
         pedido.getEglobalResp['fin']
         ?Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('No hay mas pedidos',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
         )
         :FlatButton(child: Text('Ver mas '),onPressed: (){pedido.setEcurrenPage();},))
      ),
    );

  }
  pageC(){
    
    List<Widget> widgets=[]; 
    int index=0;
    pedido.getCglobalResp['data'].forEach((element) {
        widgets.add(
           ordenCardC(element,index)
        );
      index++;
    });

     return SingleChildScrollView(
      // controller: pedido.getGscrollcontroller,
      child: Column(
        
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
       children: widgets..add(
         pedido.getCglobalResp['fin']
         ?Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('No hay mas pedidos',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
         )
         :FlatButton(child: Text('Ver mas'),onPressed: (){pedido.setCcurrenPage();},))
      ),
    );

  }
}

//--------------------------|Provider|--------------------------------

class PedidosClienteProvider extends ChangeNotifier{
 

//  bool _activo = false;
//   get getActivo=>_activo;
//   set setActivo(value){
//     _activo = true;
//   }


 //--------------------|Page 0|------------------------------------------
 
  bool _peticionG=false;
  dynamic _respGlobalG=[];
  int _currenPageG=1;
  bool _finPageG=false;
   int totalG;
  // ScrollController scrollGcontroller= new ScrollController();

  // get getGscrollcontroller => scrollGcontroller;
  get getGpeticion => _peticionG;
  get getGglobalResp => {
    "fin":_finPageG,
    "data":_respGlobalG,
    "total":totalG
  };
 
  get getGcurrenPage => _currenPageG;

  set setGpeticion(estado){
    _peticionG = estado;
    // notifyListeners();
  }
  
   setGglobalResp(List dato,bool vooid, int total){
     totalG=total;
     print('en el set Global '+_currenPageG.toString());
    if (vooid){
      if(_currenPageG>1){
        _finPageG=true;
      }else{
       _respGlobalG='vacio';
      }
    }else{
      if(_currenPageG <= 1){
       _respGlobalG=[];
       dato.forEach((element) {
        _respGlobalG.add(element);
       });
       _finPageG=false;
      //  _currenPageG++;
      }else{
        
       dato.forEach((element) {
        _respGlobalG.add(element);
       });
       _finPageG=false;
      //  _currenPageG++;
      } 
    }
      print('despues de el set Global '+_currenPageG.toString());
    notifyListeners();
  }

   setGcurrenPage(){
    _currenPageG++;
    _peticionG=false;
    notifyListeners();
  }
  
// ---------------------|Page 1|-------------------------------------------
  
   bool _peticionA=false;
  dynamic _respGlobalA=[];
  int _currenPageA=1;
  bool _finPageA=false;
  int totalA;
  // ScrollController scrollGcontroller= new ScrollController();

  // get getGscrollcontroller => scrollGcontroller;
  get getApeticion => _peticionA;
  get getAglobalResp => {
    "fin":_finPageA,
    "data":_respGlobalA,
    "total":totalA
  };
  get getAcurrenPage => _currenPageA;

  set setApeticion(estado){
    _peticionA = estado;
    // notifyListeners();
  }
  
   setAglobalResp(List dato,bool vooid,int total){
   totalA=total;
    if (vooid){
      if(_currenPageA>1){
        _finPageA=true;
      }else{
       _respGlobalA='vacio';
      }
    }else{
      if(_currenPageA <= 1){
       _respGlobalA=[];
       dato.forEach((element) {
        _respGlobalA.add(element);
       });
       _finPageA=false;
      //  _currenPageG++;
      }else{
        
       dato.forEach((element) {
        _respGlobalA.add(element);
       });
       _finPageA=false;
      //  _currenPageG++;
      } 
    }
      
    notifyListeners();
  }

   setAcurrenPage(){
    _currenPageA++;
    _peticionA=false;
    notifyListeners();
  }
  


//----------------------|Page 2|-------------------------------------------

  bool _peticionP=false;
  dynamic _respGlobalP=[];
  int _currenPageP=1;
  bool _finPageP=false;
  int totalP;
  // ScrollController scrollGcontroller= new ScrollController();

  // get getGscrollcontroller => scrollGcontroller;
  get getPpeticion => _peticionP;
  get getPglobalResp => {
    "fin":_finPageP,
    "data":_respGlobalP,
    "total":totalP
  };
  get getPcurrenPage => _currenPageP;

  set setPpeticion(estado){
    _peticionP = estado;
    // notifyListeners();
  }
  
   setPglobalResp(List dato,bool vooid,int total){
   totalP =total;
    if (vooid){
      if(_currenPageP>1){
        _finPageP=true;
      }else{
       _respGlobalP='vacio';
      }
    }else{
      if(_currenPageP <= 1){
       _respGlobalP=[];
       dato.forEach((element) {
        _respGlobalP.add(element);
       });
       _finPageP=false;
      //  _currenPageG++;
      }else{
        
       dato.forEach((element) {
        _respGlobalP.add(element);
       });
       _finPageP=false;
      //  _currenPageG++;
      } 
    }
      
    notifyListeners();
  }

   setPcurrenPage(){
    _currenPageP++;
    _peticionP=false;
    notifyListeners();
  }

//----------------------|Page 3|--------------------------------------------

  int totalT;
  bool _peticionT=false;
  dynamic _respGlobalT=[];
  int _currenPageT=1;
  bool _finPageT=false;
  // ScrollController scrollGcontroller= new ScrollController();

  // get getGscrollcontroller => scrollGcontroller;
  get getTpeticion => _peticionT;
  get getTglobalResp => {
    "fin":_finPageT,
    "data":_respGlobalT,
    "total":totalT
  };
  get getTcurrenPage => _currenPageT;

  set setTpeticion(estado){
    _peticionT = estado;
    // notifyListeners();
  }
  
   setTglobalResp(List dato,bool vooid,int total){
     totalT=total;
   
    if (vooid){
      if(_currenPageT>1){
        _finPageT=true;
      }else{
       _respGlobalT='vacio';
      }
    }else{
      if(_currenPageT <= 1){
       _respGlobalT=[];
       dato.forEach((element) {
        _respGlobalT.add(element);
       });
       _finPageT=false;
      //  _currenPageG++;
      }else{
        
       dato.forEach((element) {
        _respGlobalT.add(element);
       });
       _finPageT=false;
      //  _currenPageG++;
      } 
    }
      
    notifyListeners();
  }

   setTcurrenPage(){
    _currenPageT++;
    _peticionT=false;
    notifyListeners();
  }

//----------------------|Page 4|--------------------------------------------

  int totalE; 
  bool _peticionE=false;
  dynamic _respGlobalE=[];
  int _currenPageE=1;
  bool _finPageE=false;
  // ScrollController scrollGcontroller= new ScrollController();

  // get getGscrollcontroller => scrollGcontroller;
  get getEpeticion => _peticionE;
  get getEglobalResp => {
    "fin":_finPageE,
    "data":_respGlobalE,
    "total":totalE
  };
  get getEcurrenPage => _currenPageE;

  set setEpeticion(estado){
    _peticionE = estado;
    // notifyListeners();
  }
  
   setEglobalResp(List dato,bool vooid,int total){
   totalE=total;
    if (vooid){
      if(_currenPageE>1){
        _finPageE=true;
      }else{
       _respGlobalE='vacio';
      }
    }else{
      if(_currenPageE <= 1){
       _respGlobalE=[];
       dato.forEach((element) {
        _respGlobalE.add(element);
       });
       _finPageE=false;
      //  _currenPageG++;
      }else{
        
       dato.forEach((element) {
        _respGlobalE.add(element);
       });
       _finPageE=false;
      //  _currenPageG++;
      } 
    }
      
    notifyListeners();
  }

   setEcurrenPage(){
    _currenPageE++;
    _peticionE=false;
    notifyListeners();
  }


//----------------------|Page 5|--------------------------------------------


  bool _peticionC=false;
  dynamic _respGlobalC=[];
  int _currenPageC=1;
  bool _finPageC=false;
  int totalC;
  // ScrollController scrollGcontroller= new ScrollController();

  // get getGscrollcontroller => scrollGcontroller;
  get getCpeticion => _peticionC;
  get getCglobalResp => {
    "fin":_finPageC,
    "data":_respGlobalC,
    "total":totalC
  };
  get getCcurrenPage => _currenPageC;

  set setCpeticion(estado){
    _peticionC = estado;
    // notifyListeners();
  }
  
   setCglobalResp(List dato,bool vooid,int total){
   totalC=total;
    if (vooid){
      if(_currenPageC>1){
        _finPageC=true;
      }else{
       _respGlobalC='vacio';
      }
    }else{
      if(_currenPageC <= 1){
       _respGlobalC=[];
       dato.forEach((element) {
        _respGlobalC.add(element);
       });
       _finPageC=false;
      //  _currenPageG++;
      }else{
        
       dato.forEach((element) {
        _respGlobalC.add(element);
       });
       _finPageC=false;
      //  _currenPageG++;
      } 
    }
      
    notifyListeners();
  }

   setCcurrenPage(){
    _currenPageC++;
    _peticionC=false;
    notifyListeners();
  }


  //-----|Reload|------//

  reload(){
    //---| page 0 |----
     totalG=null;
    _peticionG = false;
    _respGlobalG=null;
    _currenPageG=1;
    _finPageG=false;

    //---| page 1 |----
    totalA=null;
    _peticionA = false;
    _respGlobalA=null;
    _currenPageA=1;
  
    //---| page 2 |----

    totalP=null;
    _peticionP = false;
    _respGlobalP=null;
    _currenPageP=1;

    //---| page 3 |----
   
    totalT=null;
    _peticionT = false;
    _respGlobalT=null;
    _currenPageT=1;
    
     //---| page 4 |----
     totalE=null;
    _peticionE = false;
    _respGlobalE=null;
    _currenPageE=1;
   
    //---| page 5 |----
    totalC=null;
    _peticionC = false;
    _respGlobalC=null;
    _currenPageC=1;
    

   
    notifyListeners();
  }


 //----DISPOSE-----DISPOSE -----DISPOSE---//
  dispose(){
     totalG=null;
    _peticionG = false;
    _respGlobalG=null;
    _currenPageG=1;
    _finPageG=false;
    totalA=null;
    _peticionA = false;
    _respGlobalA=null;
    _currenPageA=1;
    totalP=null;
    _peticionP = false;
    _respGlobalP=null;
    _currenPageP=1;
    totalT=null;
    _peticionT = false;
    _respGlobalT=null;
    _currenPageT=1;
     totalE=null;
    _peticionE = false;
    _respGlobalE=null;
    _currenPageE=1;
    totalC=null;
    _peticionC = false;
    _respGlobalC=null;
    _currenPageC=1;
    _pref.activo='false';

  }

}




// "generada",
// "autorizada",
// "preparada",
// "en_transito",
// "entregada",
// "cancelada",