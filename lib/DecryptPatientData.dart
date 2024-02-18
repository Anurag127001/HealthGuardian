
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'aesAlgorithm.dart';

List<String> patientdetails = [
  'Full Name',
  'Age',
  'Gender',
  'Contact Number',
  'Patient Id',
  'Email',
  'Address',
  'Blood Group',
  'Medical History',
];

class AESDecryptionPage extends StatefulWidget {
  @override
  _AESDecryptionPageState createState() => _AESDecryptionPageState();
}

class _AESDecryptionPageState extends State<AESDecryptionPage> {
  CollectionReference encryptedDataCollection =
  FirebaseFirestore.instance.collection('Patients');
  TextEditingController aadharController = TextEditingController();
  List<String> decryptedDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCCCDCC),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(
          "Your Records",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: aadharController,
              decoration: InputDecoration(labelText: 'Enter Aadhar Number'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2F2E40),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                _decryptAndShowData();
              },
              child: Text('Tap to view Records'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: decryptedDataList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(patientdetails[index]),
                    subtitle: Text(decryptedDataList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _decryptAndShowData() async {
    String enteredAadharNumber = aadharController.text.trim();

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await encryptedDataCollection
        .where('Aadhar Number', isEqualTo: enteredAadharNumber)
        .limit(1)
        .get() as QuerySnapshot<Map<String, dynamic>>;

    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic>? encryptedData = querySnapshot.docs.first.data();
      decryptedDataList.clear();
      if (encryptedData != null) {
        decryptedDataList.addAll([
          AESAlgorithm.decryptData(encryptedData['Full Name'] ?? ''),
          _decryptAge(encryptedData['Age']),
          AESAlgorithm.decryptData(encryptedData['Gender'] ?? ''),
          AESAlgorithm.decryptData(encryptedData['Contact Number'] ?? ''),
          encryptedData['Patient ID'] ?? '',
          encryptedData['Email'] ?? '',
          AESAlgorithm.decryptData(encryptedData['Address'] ?? ''),
          AESAlgorithm.decryptData(encryptedData['Blood Group'] ?? ''),
          AESAlgorithm.decryptData(encryptedData['Medical History'] ?? ''),
        ]);
      }

      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No data found for the provided Aadhar number.'),
        ),
      );
    }
  }

  String _decryptAge(dynamic ageData) {
    if (ageData is int) {
      return ageData.toString();
    } else {
      return AESAlgorithm.decryptData(ageData.toString());
    }
  }
}
