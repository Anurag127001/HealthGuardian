import 'package:flutter/material.dart';

void main() {
  runApp(SettingsPage());
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff2F2E40),
          centerTitle: true,
          title: Text('Settings',style: TextStyle(color: Colors.white)),
        ),
        body: SettingsList(),
      ),
    );
  }
}

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        SettingCard(
          title: 'Change Phone Number/Email ID in My Account',
          onTap: () {
            // Add onTap logic here
          },
        ),
        SettingCard(
          title: 'Printing Clinical Notes and Vital Signs',
          onTap: () {
            // Add onTap logic here
          },
        ),
        SettingCard(
          title: 'HealthGuardian Access Zones',
          onTap: () {
            // Add onTap logic here
          },
        ),
        SettingCard(
          title: 'Set your clinic timings',
          onTap: () {
            // Add onTap logic here
          },
        ),
      ],
    );
  }
}

class SettingCard extends StatelessWidget {
  final String title;
  final Function onTap;

  const SettingCard({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        onTap: () => onTap(),
      ),
    );
  }
}
