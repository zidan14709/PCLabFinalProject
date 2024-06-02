import 'package:flutter/material.dart';
import 'package:portfolio/Fragment/CalculatorScreen%20(3).dart';
// import 'package:portfolio/Fragment/AddQuestionScreen.dart';
// import 'package:portfolio/Fragment/AddQuestionScreen.dart';
import 'package:portfolio/Fragment/Portfolio.dart';
import 'package:portfolio/Fragment/QuizScreen.dart';
import 'package:portfolio/Fragment/login.dart';
import 'home_page.dart';
// import 'QuizScreen.dart';

class Apps extends StatelessWidget {
  const Apps({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Apps"),
        backgroundColor: Color.fromARGB(255, 10, 0, 150), // Set the app bar color
      ),
      body: Container(
        color: Colors.black, // Change this to your preferred background color
        child: ListView(
          children: [
            AppListItem(
              appName: "Quiz App",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              icon: Icons.question_answer,
              iconColor: const Color.fromARGB(255, 243, 33, 170), // Customize the icon color
            ),
            AppListItem(
              appName: "Weather App",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: Icons.cloud,
              iconColor: const Color.fromARGB(255, 81, 255, 0), // Customize the icon color
            ),
            AppListItem(
              appName: "Calculator App",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorScreen()),
                );
              },
              icon: Icons.calculate,
              iconColor: const Color.fromARGB(255, 175, 116, 76), // Customize the icon color
            ),
            // Add more AppListItems as needed
          ],
        ),
      ),
    );
  }
}

class AppListItem extends StatelessWidget {
  final String appName;
  final Function onTap;
  final IconData icon;
  final Color iconColor;

  const AppListItem({
    required this.appName,
    required this.onTap,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800], // Customize the card background color
      elevation: 4, // Add elevation for a subtle shadow
      margin: EdgeInsets.all(10), // Add margin for spacing
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor,
          child: Icon(
            icon,
            color: Colors.white, // Customize the icon color
          ),
        ),
        title: Text(
          appName,
          style: TextStyle(color: Colors.white), // Customize the text color
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
