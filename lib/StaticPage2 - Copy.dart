import 'package:flutter/material.dart';
import 'StaticPage3.dart';

class Static2 extends StatelessWidget {
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
              imagePath: 'assets/images/a1aes.jpg',
              text:
              "All your data is safeguarded with 256-bit encryption. HealthGuardian employs top-tier security standards to protect your information, ensuring it remains secure.",
            ),
            SizedBox(height: 15),
            PrivacyContainer(
              imagePath: 'assets/images/a2sec.jpg',
              text:
              "With HealthGuardian, your privacy is paramount. We never compromise on safeguarding your health data, ensuring it remains confidential and secure.",
            ),
            SizedBox(height: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Static3()),
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

  const PrivacyContainer({Key? key, required this.imagePath, required this.text}) : super(key: key);

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
