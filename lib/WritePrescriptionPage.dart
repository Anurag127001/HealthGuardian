import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'aesAlgorithm.dart';

class AESEncryptionPage extends StatefulWidget {
  @override
  _AESEncryptionPageState createState() => _AESEncryptionPageState();
}

class _AESEncryptionPageState extends State<AESEncryptionPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _aadharNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();

  CollectionReference _patientsCollection =
      FirebaseFirestore.instance.collection('Patients');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(
          "Enter Patient's Details",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            textStyle: TextStyle(color: Colors.white),
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextFormField(
                controller: _contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _aadharNumberController,
                decoration: InputDecoration(labelText: 'Aadhar Number'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: _bloodGroupController,
                decoration: InputDecoration(labelText: 'Blood Group'),
              ),
              TextFormField(
                controller: _medicalHistoryController,
                decoration: InputDecoration(labelText: 'Medical History'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2F2E40),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await _checkAndSubmitData();
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkAndSubmitData() async {
    String fullName = _fullNameController.text;
    int age = int.tryParse(_ageController.text) ?? 0;
    String gender = _genderController.text;
    int contactNumber = int.tryParse(_contactNumberController.text) ?? 0;
    String aadharNumber = _aadharNumberController.text;
    String email = _emailController.text;
    String address = _addressController.text;
    String bloodGroup = _bloodGroupController.text;
    String medicalHistory = _medicalHistoryController.text;

    bool isAadharNumberExists = await _checkAadharNumberExists(aadharNumber);
    if (isAadharNumberExists) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User with this Aadhar Number already exists!'),
      ));
      return;
    }

    // Encrypting data
    String encryptedFullName = AESAlgorithm.encryptData(fullName);
    String encryptedGender = AESAlgorithm.encryptData(gender);
    String encryptedAddress = AESAlgorithm.encryptData(address);
    String encryptedBloodGroup = AESAlgorithm.encryptData(bloodGroup);
    String encryptedMedicalHistory = AESAlgorithm.encryptData(medicalHistory);
    String encryptedContactNumber =
        AESAlgorithm.encryptData(contactNumber.toString());
    String encryptedAge = AESAlgorithm.encryptData(age.toString());

    // Storing encrypted data in Firestore
    await _storeEncryptedData(email, aadharNumber, {
      'Full Name': encryptedFullName,
      'Age': encryptedAge,
      'Gender': encryptedGender,
      'Contact Number': encryptedContactNumber,
      'Aadhar Number': aadharNumber, // Storing Aadhar Number as it is
      'Email': email,
      'Address': encryptedAddress,
      'Blood Group': encryptedBloodGroup,
      'Medical History': encryptedMedicalHistory,
    });
  }

  Future<bool> _checkAadharNumberExists(String aadharNumber) async {
    QuerySnapshot querySnapshot = await _patientsCollection
        .where('Aadhar Number', isEqualTo: aadharNumber)
        .limit(1)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> _storeEncryptedData(String email, String aadharNumber,
      Map<String, dynamic> encryptedData) async {
    await _patientsCollection.doc(email).set(encryptedData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data encrypted and saved successfully!'),
    ));
  }
}
