import 'package:flutter/material.dart';

class Skills extends StatelessWidget {
  const Skills({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skills"),
        backgroundColor: Color.fromARGB(255, 242, 242, 243),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/Assets/images/BG.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSkillTile(Icons.code, "Languages: C, C++"),
              _buildSkillTile(Icons.computer, "IDE: Unity"),
              _buildSkillTile(Icons.design_services, "UI Design: C"),
              _buildSkillTile(Icons.layers, "Architecture: Andriod"),
              _buildSkillTile(Icons.code, "Version Control: Git"),
              _buildSkillTile(Icons.api, "API Integration: firebase"),
              _buildSkillTile(Icons.bug_report, "Testing: Debugging"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillTile(IconData icon, String text) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.teal,
      ),
      title: Text(text, style: TextStyle(fontSize: 18, color: Colors.white54)),
    );
  }
}
