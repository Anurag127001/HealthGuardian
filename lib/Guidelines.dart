import 'package:flutter/material.dart';
import 'doctorsDashboard.dart';

class GuidelinesPage extends StatefulWidget {
  @override
  _GuidelinesPageState createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2F2E40),
        centerTitle: true,
        title: Text(
          'Guidelines',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guidelines',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1.Healthcare service providers must strive to improve patient personal data collection processes to ensure that only accurate and necessary information is collected from the patient.\n\n'
                      '2.Healthcare service providers must ensure that relevant processes are established to improve the accuracy of the patient information being collected.\n\n'
                      '3.Health information should be collected only after obtaining the patient’s explicit consent and only to the extent necessary for delivering healthcare services.\n\n'
                      '4.Personal information should be collected only by lawful and fair means (without being unreasonably intrusive).\n\n'
                      '5.Unsolicited information (received without asking) must be destroyed unless it would have been lawfully collected in the course of practice.\n\n'
                      '6.As per Rule 5(2) and Rule 5(3) of SPDI rules, information should be collected for a lawful purpose connected with a function or activity alone; the collection of such sensitive personal data or information should be considered necessary for that purpose. The subject should also be informed about the nature of information being collected, the identity of the collecting agency, and the intended use of the information.\n\n'
                      '7.The personal data being collected should be necessary for the purpose of performing the function or activity.\n\n'
                      '8.The personal data being sought and collected must be relevant, accurate, not excessive, and not intrusive.\n\n'
                      '9.The personal data should be collected directly from the patient it relates to, as far as it is practical.\n\n'
                      '10.Relevant processes should be established to inform the patient about how the data may be used, who may access it, and the consequences of not providing it.\n'
                      '11.As per Rule 8, the entity must implement relevant security practices and standards.\n\n'
                      '12.have a comprehensive and documented information security programme.\n\n'
                      '13.and establish information security policies that contain managerial, technical, operational, and physical security control measures that are commensurate with the information assets.\n\n'
                      '14.As per Rule 5(4), sensitive personal data or information should not be retained for longer than is required for the purposes for which the information may lawfully be used or is otherwise required under any other law for the time being in force.\n\n',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Agree to terms and conditions',
                style: TextStyle(fontSize: 16),
              ),
              Checkbox(
                value: _agreedToTerms,
                onChanged: (value) {
                  setState(() {
                    _agreedToTerms = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_agreedToTerms) {
            // Proceed to next screen or perform action
            // print('User agreed to terms and conditions. Proceeding...');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Doctorpage()));
          } else {
            // Show a message or alert to agree to terms
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Please agree to terms and conditions'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
