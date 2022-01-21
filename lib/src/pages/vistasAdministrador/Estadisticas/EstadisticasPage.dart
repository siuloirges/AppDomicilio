import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:traelo_app/src/utils/Global.dart';

class Estadiscas extends StatefulWidget {
  // const Estadiscas({Key key}) : super(key: key);
  @override
  _EstadiscasState createState() => _EstadiscasState();
}

class _EstadiscasState extends State<Estadiscas> {
  dynamic size;
  String _myActivity;
  // String _myActivityResult;
  String selec = 'Filtrar';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
   
  
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: amarillo,
          title: Text('Estadisticas',style: TextStyle(color: verde),),
          elevation: 0,
          iconTheme: IconThemeData(color: verde),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
            fecha(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: estadistica(context:context,title:'Ordenes\n Numero',colores: [amarillo,verde,],dataMap: { 'Meta':250,'Ordenes':500}),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: estadistica(context:context,title:'Ingresos Brutos \n Numero',colores: [amarillo,verde,],dataMap: { 'Meta':500,'Ingresos':500}),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: estadistica(context:context,title:'Egresos\n Numero',colores: [amarillo,rojo,],dataMap: { 'Meta':0,'Egresos':350}),
            ),
           


          ],),
        ),
      ),
    );
  }

 Widget fecha(){
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
               Container(
                 width:size.width/1.5,
                 child: DropDownFormField(
                   
                  titleText: 'Filtro por Fecha',
                  hintText: 'Filtrar',
                  value: _myActivity,
                  onSaved: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  
                  dataSource: [
                    
                    {
                      "display": "Por Dia",
                      "value": "Por Dia",
                    },
                    {
                      "display": "Por mes",
                      "value": "Por mes",
                    },
                    {
                      "display": "Por año",
                      "value": "Por año",
                    },
                   
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
                Column(
                  children: [
                    Container(
                      height: 30,
                      child: RaisedButton(
                        color: amarillo,
                        shape: RoundedRectangleBorder(
                          borderRadius:  BorderRadius.circular(20)
                        ),
                        onPressed: (){},
                        child: Text('Hoy',style: TextStyle(color: verde),),
                      ),
                    ),
                    Row(children: [
                      IconButton(icon: Icon(Icons.arrow_left), onPressed: (){}),
                      IconButton(icon: Icon(Icons.arrow_right), onPressed: (){}),
                    ],)
                  ],
                ),
              ],),
            );
  }

  Widget estadistica({BuildContext context, Map<String, double> dataMap, List<Color> colores,String title}){
   
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 90,
        chartRadius: MediaQuery.of(context).size.width / 3,
        colorList: colores,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 10,
        centerText: "$title",
        legendOptions: LegendOptions(
          // showLegendsInRow: true,
          // legendPosition: LegendPosition.right,
          // showLegends: true,
          // legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
        //   // showChartValueBackground: true,
        //   // showChartValues: true,
          showChartValuesInPercentage: true,
          showChartValuesOutside: true,
        ),
      ),
    );
  }
}