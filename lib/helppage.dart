

import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color(0xff2F2E40),
        centerTitle: true,
        title: Text('Help',style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          HelpOption(
            title: 'Medical Newsletters',
            icon: Icons.article_outlined,
            onTap: () {
              // Implement action for Medical Newsletters
            },
          ),
          HelpOption(
            title: 'Case Studies',
            icon: Icons.cast_for_education,
            onTap: () {
              // Implement action for Case Studies
            },
          ),
          HelpOption(
            title: 'Consult',
            icon: Icons.chat_outlined,
            onTap: () {
              // Implement action for Consult
            },
          ),
          HelpOption(
            title: 'Feedback',
            icon: Icons.feedback_outlined,
            onTap: () {
              // Implement action for Feedback
            },
          ),
          HelpOption(
            title: 'Reach',
            icon: Icons.phone_outlined,
            onTap: () {
              // Implement action for Reach
            },
          ),
          HelpOption(
            title: 'Terms',
            icon: Icons.description_outlined,
            onTap: () {
              // Implement action for Terms
            },
          ),
        ],
      ),
    );
  }
}

class HelpOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const HelpOption({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30.0),
            SizedBox(width: 12.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}


