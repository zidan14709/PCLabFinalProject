import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(
    home: About(),
    debugShowCheckedModeBanner: false,
  ));
}

//stless
class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/Assets/images/BG.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 30.0, left: 30),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(radius: 40, backgroundImage: AssetImage("lib/Assets/images/MY PHOTO.jpg"),),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Istiyak Hossain Khan", style: TextStyle(fontSize: 25, color: Color.fromARGB(137, 0, 0, 0) , fontFamily: "Roboto"),),
                      Text("Game Developer", style: TextStyle(fontSize: 14,color: Color.fromARGB(115, 0, 0, 0),fontFamily: "Robotor"),)
                    ],
                  )
                ],
              ),
              SizedBox(height: 40,),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.school, size: 30,color: Colors.blue,),
                          SizedBox(width: 15,),
                          Text("B.sc in CSE", style: TextStyle(fontSize: 18,color: Colors.white70,fontFamily: "Robotor"),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.note_add_rounded, size: 30,color: Colors.blue,),
                          SizedBox(width: 15,),
                          Text("Android Portfolio App", style: TextStyle(fontSize: 18,color:Colors.white70,fontFamily: "Robotor"),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_pin, size: 30,color: Colors.blue,),
                          SizedBox(width: 15,),
                          Text("Dhaka, Savar", style: TextStyle(fontSize: 18,color: Colors.white70,fontFamily: "Robotor"),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.email, size: 30,color: Colors.blue,),
                          SizedBox(width: 15,),
                          Text("istiyakzidan854@gmail.com", style: TextStyle(fontSize: 18,color: Colors.white70,fontFamily: "Robotor"),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.phone, size: 30,color: Colors.blue,),
                          SizedBox(width: 15,),
                          Text("+880886717096", style: TextStyle(fontSize: 18,color: Colors.white70,fontFamily: "Robotor"),),
                        ],
                      ),
                  
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Myself Istiyak Hossain Khan, a dedicated game developer for android. Currently, I am studying at DIU pursuing a bachelor degree in department CSE. My future goal is to eshtublish my career in Unity Game Studio.", style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 31, 239, 243),fontFamily: "Robotor"),),
              ),
              SizedBox(height: 60,),
              Text("Created By Istiyak", style: TextStyle(fontSize: 13,color: Colors.black,fontFamily: "Robotor"),),
            ],
          ),
        ),
      ),
    );
  }
}
