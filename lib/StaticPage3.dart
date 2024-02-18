import 'package:flutter/material.dart';

import 'Login.dart';

class Static3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffCCCDCC),
      appBar: AppBar(
        backgroundColor: const Color(0xff2F2E40),
        centerTitle: true,
        title: Text(
          'Privacy Information',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10), // Adjusted bottom padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 15),
            PrivacyContainer(
              imagePath: 'assets/images/img_5.png',
              text:
                  "We never sell your data to anyone, as we prioritize your privacy and take data protection very seriously.",
            ),
            SizedBox(height: 15),
            PrivacyContainer(
              imagePath: 'assets/images/img_4.png',
              text:
                  "Your information shared on HealthGuardian remains confidential. Only you have access to it, and you have full control over who can view it.",
            ),
            SizedBox(height: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserTypeSelectionPage()),
                  );
                },
                child: Icon(
                  Icons.arrow_forward,
                  size: 50,
                  color: Color(0xff2f2e40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyContainer extends StatelessWidget {
  final String imagePath;
  final String text;

  const PrivacyContainer(
      {Key? key, required this.imagePath, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 80),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
