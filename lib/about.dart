import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2F2E40),
        centerTitle: true,
        title: Text('About',style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Card(
            elevation: 50,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white38),
              margin: EdgeInsets.only(top: 70,left: 15,right: 15),
              child: Text('HealthGuardian offers a secure, centralized platform for managing your health data. '
                  'With robust encryption, access restricted to verified users, and strict security measures, your information is safeguarded at every step. '
                  'Compliant with data protection regulations, we prioritize trust and transparency. '
                  'Join us for peace of mind in managing your health securely.'
              ,style: TextStyle(fontSize: 20,),textAlign: TextAlign.justify
              ),
            ),
          )
        ],
      ),
    );
  }
}
