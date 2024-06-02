// main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/Fragment/Blog.dart';
import 'package:provider/provider.dart';
import 'Fragment/personal_info_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Fragment/PersonalProfile.dart';
import 'Fragment/Portfolio.dart';
import 'Fragment/Apps.dart';
import 'Fragment/Skills.dart';
import 'Fragment/Experiences.dart';
import 'Fragment/About.dart';
import 'Fragment/Certificates.dart';
import 'Fragment/login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PersonalInfoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData(
        primaryColor: Colors.black87,
        hintColor: Colors.black87,
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          subtitle1: TextStyle(
            fontSize: 20,
            color: Colors.black87,
          ),
          subtitle2: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class HomeActivity extends StatelessWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Istiyak Hossain Khan",
            style: Theme.of(context).textTheme.headline6!,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                icon: Icon(Icons.person, color: Colors.white),
                text: 'About',
              ),
              Tab(
                icon: Icon(Icons.star, color: Colors.white),
                text: 'Skills',
              ),
              Tab(
                icon: Icon(Icons.work, color: Colors.white),
                text: 'Experiences',
              ),
              Tab(
                icon:
                    Icon(Icons.apps_outage_outlined, color: Colors.white),
                text: 'Apps',
              ),
              Tab(
                icon: Icon(Icons.card_membership, color: Colors.white),
                text: 'Certificates',
              ),
              Tab(
                icon:
                    Icon(Icons.file_upload_outlined, color: Colors.white),
                text: 'Upload your Info',
              ),
              Tab(
                icon: Icon(Icons.assignment, color: Colors.white),
                text: 'Portfolio',
              ),
              Tab(
                icon: Icon(Icons.assignment, color: Colors.white),
                text: 'Blog',
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Color.fromARGB(137, 87, 197, 64),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                  ),
                  child: UserAccountsDrawerHeader(
                    accountName: const Text(
                      "Istiyak Hossain Khan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    accountEmail: const Text(
                      "hossain15-14709@diu.edu.bd",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset("lib/Assets/images/MY PHOTO.jpg",
                      ),
                      
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.tealAccent,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    // Add logic for Home onTap
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.tealAccent,
                  ),
                  title: Text(
                    'Gmail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    launch('https://mail.google.com/mail/u/0/#inbox');
                  },
                ),
                
                ListTile(
                  leading: Icon(
                    Icons.facebook,
                    color: Colors.tealAccent,
                  ),
                  title: Text(
                    'Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    launch('https://www.facebook.com/ihkjidan.jidankhan');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_tree_sharp,
                    color: Colors.tealAccent,
                  ),
                  title: Text(
                    'Github',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    launch('https://github.com/zidan14709');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.tealAccent,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    // Add logic for Logout onTap
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            About(),
            Skills(),
            Experiences(),
            Apps(),
            Certificates(),
            PersonalProfile(),
            Portfolio(),
            Blog(),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
