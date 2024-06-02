// Portfolio.dart

import 'package:flutter/material.dart';

class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color.fromARGB(255, 0, 0, 0), const Color.fromARGB(255, 33, 33, 33)!],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Project list",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            PortfolioItem(
              projectName: "Food Selling App",
              projectLink: "https://github.com/muntasir25/FoodSelling_Web",
              projectDescription: "Online Food selling App",
            ),
            SizedBox(height: 16),
            PortfolioItem(
              projectName: "Book Selling App",
              projectLink: "https://github.com/muntasir25/Book-selling-website",
              projectDescription: "Online Book selling App",
            ),
          ],
        ),
      ),
    );
  }
}

class PortfolioItem extends StatelessWidget {
  final String projectName;
  final String projectLink;
  final String projectDescription;

  const PortfolioItem({
    required this.projectName,
    required this.projectLink,
    required this.projectDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.grey[800],
      child: ListTile(
        title: Text(
          projectName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              projectDescription,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              projectLink,
              style: TextStyle(
                color: Colors.teal,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        onTap: () {
          // Add actions for when the portfolio item is tapped
        },
      ),
    );
  }
}
