import 'package:flutter/material.dart';

class ShowVaccines extends StatefulWidget{
  const ShowVaccines({Key? key}) : super(key: key);


   @override
  State<ShowVaccines> createState ()=> VaccinePage();
}

class VaccinePage extends State<ShowVaccines> {

  @override
  Widget build(BuildContext context) {
    final  _message = ModalRoute.of(context)!.settings.arguments;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Vaccines'),
        centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
               Card(
              child: ListTile(
                leading: Icon(Icons.baby_changing_station_sharp),
                title: Text("Pneumonia"),
                isThreeLine: false,
                
              ),
            ),    
            Card(
              child: ListTile(
                leading: Icon(Icons.baby_changing_station_sharp),
                title: Text("IPV"),
                isThreeLine: false,
             
              ),
            ), 
            Card(
              child: ListTile(
                leading: Icon(Icons.baby_changing_station_sharp),
                title: Text("Measles"),
                isThreeLine: false,
                
              ),
            ), 
            Card(
              child: ListTile(
                leading: Icon(Icons.baby_changing_station_sharp),
                title: Text("Dtw"),
                isThreeLine: false,
                
              ),
            ), 
            Card(
              child: ListTile(
                leading: Icon(Icons.baby_changing_station_sharp),
                title: Text("Polio"),
                isThreeLine: false,
                
              ),
            ), 
            Card(
              child: ListTile(
                leading: Icon(Icons.baby_changing_station_sharp),
                title: Text("Yellow Fever"),
                isThreeLine: false,
              
              ),
            ), 
            // Card(
            //   child: ListTile(
            //     leading: Icon(Icons.baby_changing_station_sharp),
            //     title: Text("Pneumonia"),
            //     isThreeLine: false,
          
          
            //   ),
            // ), 
            // Card(
            //   child: ListTile(
            //     leading: Icon(Icons.baby_changing_station_sharp),
            //     title: Text("Pneumonia"),
            //     subtitle: Text('Pneumoccoal conjugate'),
            //     isThreeLine: false,
               
            //   ),
            // ),   
            ],
          ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              print("hey");
            },
            child: Icon(Icons.add),
          ),
    );
    throw UnimplementedError();
  }
  
}