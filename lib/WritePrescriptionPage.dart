// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'aesAlgorithm.dart'; // Import the AESAlgorithm class
// import 'package:google_fonts/google_fonts.dart';
//
//
// class WritePrescriptionPage extends StatefulWidget {
//   @override
//   _WritePrescriptionPageState createState() => _WritePrescriptionPageState();
// }
//
// class _WritePrescriptionPageState extends State<WritePrescriptionPage> {
//   final TextEditingController patientIdController = TextEditingController();
//   final TextEditingController aadharController = TextEditingController();
//   final TextEditingController emailComtroller = TextEditingController();
//
//   final TextEditingController prescriptionController = TextEditingController();
//   final TextEditingController checkupDateController = TextEditingController();
//   final TextEditingController doctorNameController = TextEditingController(); // Add doctorNameController
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//     iconTheme: const IconThemeData(
//     color: Colors.white, //change your color here
//     ),
//     backgroundColor: const Color(0xff2F2E40),
//     title: Text(
//     "Write Prescription",
//     style: GoogleFonts.lato(
//     fontWeight: FontWeight.bold,
//     textStyle: const TextStyle(color: Colors.white),
//     fontSize: 25,
//     ),
//     ),
//     ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//
//               TextField(
//                 controller: aadharController,
//                 decoration: InputDecoration(labelText: 'Patient Aadhar number'),
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 controller: emailComtroller,
//                 decoration: InputDecoration(labelText: 'Email'),
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 controller: patientIdController,
//                 decoration: InputDecoration(labelText: 'Patient Id number'),
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 controller: prescriptionController,
//                 decoration: InputDecoration(labelText: 'Prescription Details'),
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: checkupDateController,
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: 'Checkup Date',
//                   border: OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.calendar_today),
//                     onPressed: () {
//                       _selectDate(context);
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 controller: doctorNameController,
//                 decoration: InputDecoration(labelText: 'Doctor Name'), // Add doctor name field
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff2F2E40),
//                     foregroundColor: Colors.white),                onPressed: () {
//                   validateAndWritePrescription(context);
//                 },
//                 child: Text('Submit Prescription', style: TextStyle(color: Colors.white)),
//               ),
//               SizedBox(height: 16.0),
//
//
//
//
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff2F2E40),
//                     foregroundColor: Colors.white),
//                 onPressed: () {
//                   // Check if the entered email and patient ID match before navigating
//
//                   validatePatient(getEmail(),getPatientId()).then((isValid) {
//                     if (isValid) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => PrescriptionHistoryPage(
//                           email:getEmail(),
//                           patientID: getPatientId(),
//                         )),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Invalid email or patient ID.'),
//                         ),
//                       );
//                     }
//                   });
//
//
//                   },
//                 child: Text('Prescription History', style: TextStyle(color: Colors.white)),
//               ),
//
//
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String getEmail(){
//     return emailComtroller.text;
//   }
//
//   String getPatientId(){
//     return patientIdController.text;
//   }
//
//
//
//   void _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2015),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         checkupDateController.text = picked.toString().split(' ')[0]; // Extract only the date part
//       });
//     }
//   }
//   void validateAndWritePrescription(BuildContext context) async {
//     String enteredEmail = getEmail();
//     String enteredPatientID = getPatientId();
//
//     // Check if the entered email and patient ID match a document in the Patients collection
//     bool isValid = await validatePatient(enteredEmail, enteredPatientID);
//     if (isValid) {
//       String prescriptionDetails = prescriptionController.text;
//       String checkupDate = checkupDateController.text;
//       String doctorName = doctorNameController.text; // Retrieve doctor name
//
//       // Encrypt prescription details, checkup date, doctor name, and patient ID before storing
//       String encryptedPrescriptionDetails = AESAlgorithm.encryptData(prescriptionDetails);
//       String encryptedCheckupDate = AESAlgorithm.encryptData(checkupDate);
//       String encryptedDoctorName = AESAlgorithm.encryptData(doctorName);
//       String encryptedPatientID = AESAlgorithm.encryptData(enteredPatientID); // Encrypt patient ID
//
//       // Add encrypted prescription to a subcollection within the patient's document
//       await FirebaseFirestore.instance
//           .collection('Patients')
//           .doc(enteredEmail)
//           .collection('Prescriptions')
//           .add({
//         'patientID': encryptedPatientID, // Store encrypted patient ID
//         'prescriptionDetails': encryptedPrescriptionDetails,
//         'checkupDate': encryptedCheckupDate,
//         'doctorName': encryptedDoctorName,
//       });
//
//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Prescription added successfully!'),
//         ),
//       );
//     } else {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Invalid email or patient ID.'),
//         ),
//       );
//     }
//   }
//
//
//
//
//   Future<bool> validatePatient(String email, String patientID) async {
//     try {
//       DocumentSnapshot patientSnapshot =
//       await FirebaseFirestore.instance.collection('Patients').doc(email).get();
//       print('Patient snapshot exists: ${patientSnapshot.exists}');
//       if (patientSnapshot.exists) {
//         Map<String, dynamic> patientData = patientSnapshot.data() as Map<String, dynamic>;
//         String? storedPatientID = patientData['Patient ID']; // Adjusted field name
//         print('Stored Patient ID: $storedPatientID');
//         print('Entered Patient ID: $patientID');
//         return storedPatientID != null && storedPatientID == patientID;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print('Error validating patient: $e');
//       return false;
//     }
//   }
// }
//
// class PrescriptionHistoryPage extends StatelessWidget {
//   final String email;
//   final String patientID;
//
//   PrescriptionHistoryPage({required this.email, required this.patientID});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Prescription History'),
//       ),
//       body: PrescriptionList(
//         patientEmail: email,
//         patientID: patientID,
//       ),
//     );
//   }
// }
//
// class PrescriptionList extends StatelessWidget {
//   final String patientEmail;
//   final String patientID;
//
//   PrescriptionList({required this.patientEmail, required this.patientID});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('Patients')
//           .doc(patientEmail)
//           .collection('Prescriptions')
//           .where('patientID', isEqualTo: AESAlgorithm.encryptData(patientID)) // Encrypt patient ID for query
//           .orderBy('checkupDate', descending: true)
//           .snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//
//         if (snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No prescriptions available.'));
//         }
//
//         return ListView(
//           children: snapshot.data!.docs.map((doc) {
//             Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//             String encryptedPrescriptionDetails = data['prescriptionDetails'];
//             String encryptedCheckupDate = data['checkupDate'];
//             String encryptedDoctorName = data['doctorName']; // Retrieve encrypted doctor name
//
//             // Decrypt all values before displaying
//             String decryptedPrescriptionDetails = AESAlgorithm.decryptData(encryptedPrescriptionDetails) ?? 'Decryption Error';
//             String decryptedCheckupDate = AESAlgorithm.decryptData(encryptedCheckupDate) ?? 'Decryption Error';
//             String decryptedDoctorName = AESAlgorithm.decryptData(encryptedDoctorName) ?? 'Decryption Error'; // Decrypt doctor name
//
//             return ListTile(
//               tileColor: Colors.white,
//               contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 side: BorderSide(
//                   color: Colors.blueGrey.withOpacity(0.2),
//                   width: 1.0,
//                 ),
//               ),
//               leading: Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blueGrey.withOpacity(0.2),
//                 ),
//                 child: Center(
//                   child: Icon(
//                     Icons.medical_services,
//                     size: 30,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),
//               title: Text(
//                 decryptedPrescriptionDetails,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16.0,
//                   color: Colors.black87,
//                 ),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 8.0),
//                   Text(
//                     'Checkup Date: $decryptedCheckupDate',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   SizedBox(height: 4.0),
//                   Text(
//                     'Doctor Name: $decryptedDoctorName',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }
//
//
// Widget _buildTextField({
//   required TextEditingController controller,
//   required String labelText,
//   TextInputType keyboardType = TextInputType.text,
//   int maxLines = 1,
//   bool readOnly = false,
//   VoidCallback? onTap,
// }) {
//   return TextFormField(
//     controller: controller,
//     keyboardType: keyboardType,
//     maxLines: maxLines,
//     readOnly: readOnly,
//     onTap: onTap,
//     style: const TextStyle(color: Colors.black),
//     decoration: InputDecoration(
//       labelText: labelText,
//       border: const OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey),
//       ),
//       focusedBorder: const OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.blue),
//       ),
//       enabledBorder: const OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey),
//       ),
//       errorBorder: const OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.red),
//       ),
//       focusedErrorBorder: const OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.red),
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'aesAlgorithm.dart'; // Import the AESAlgorithm class
import 'package:google_fonts/google_fonts.dart';


class WritePrescriptionPage extends StatefulWidget {
  @override
  _WritePrescriptionPageState createState() => _WritePrescriptionPageState();
}
final TextEditingController prescriptionController = TextEditingController();

class _WritePrescriptionPageState extends State<WritePrescriptionPage> {
  final TextEditingController checkupDateController = TextEditingController();
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController aadharController = TextEditingController(); // Add Aadhar controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(
          "Write Prescription",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            textStyle: const TextStyle(color: Colors.white),
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: aadharController, // Add Aadhar controller
                  decoration: InputDecoration(labelText: 'Aadhar Number'), // Add Aadhar field
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: prescriptionController,
                  decoration: InputDecoration(labelText: 'Prescription Details'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: checkupDateController,
                  decoration: InputDecoration(labelText: 'Checkup Date'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: doctorNameController,
                  decoration: InputDecoration(labelText: 'Doctor Name'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2F2E40),
                      foregroundColor: Colors.white),                  onPressed: () {
                    validateAndWritePrescription(context);
                  },
                  child: Text('Submit Prescription', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2F2E40),
                      foregroundColor: Colors.white),                  onPressed: () {
                    String aadharNumber = aadharController.text;
                    fetchPrescriptions(aadharNumber).then((prescriptions) {
                      if (prescriptions.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrescriptionHistoryPage(
                              prescriptions: prescriptions,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('No prescriptions found for the provided Aadhar number.'),
                          ),
                        );
                      }
                    });
                  },
                  child: Text('Prescription History', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }


  void validateAndWritePrescription(BuildContext context) async {
    String prescriptionDetails = getPrescript();
    String checkupDate = checkupDateController.text;
    String doctorName = doctorNameController.text;
    String aadharNumber = aadharController.text;

    // Encrypt prescription details, checkup date, and doctor name
    String encryptedPrescriptionDetails = AESAlgorithm.encryptData(prescriptionDetails);
    String encryptedCheckupDate = AESAlgorithm.encryptData(checkupDate);
    String encryptedDoctorName = AESAlgorithm.encryptData(doctorName);

    bool isValid = await fetchPatient(aadharNumber);
    if (isValid) {
      // Store the prescription data in Firestore
      await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: aadharNumber).get().then((querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          await querySnapshot.docs.first.reference.collection('Prescriptions').add({
            'prescriptionDetails': encryptedPrescriptionDetails,
            'checkupDate': encryptedCheckupDate,
            'doctorName': encryptedDoctorName,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Prescription added successfully!'),
            ),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No patient found with the provided Aadhar number.'),
        ),
      );
    }
  }

  Future<bool> fetchPatient(String aadharNumber) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: aadharNumber).get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<List<Map<String, String>>> fetchPrescriptions(String aadharNumber) async {
    List<Map<String, String>> prescriptions = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: aadharNumber).get();
    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document which should be the only one as Aadhar Number should be unique
      DocumentSnapshot patientDoc = querySnapshot.docs.first;
      // Fetch prescriptions from subcollection
      QuerySnapshot prescriptionsSnapshot = await patientDoc.reference.collection('Prescriptions').get();
      prescriptionsSnapshot.docs.forEach((prescriptionDoc) {
        Map<String, String> prescription = {
          'prescriptionDetails': AESAlgorithm.decryptData(prescriptionDoc['prescriptionDetails']) ?? 'Decryption Error',
          'checkupDate': AESAlgorithm.decryptData(prescriptionDoc['checkupDate']) ?? 'Decryption Error',
          'doctorName': AESAlgorithm.decryptData(prescriptionDoc['doctorName']) ?? 'Decryption Error',
        };
        prescriptions.add(prescription);
      });
    }
    return prescriptions;
  }
}

String getPrescript(){
  return prescriptionController.text;
}

class PrescriptionHistoryPage extends StatelessWidget {
  final List<Map<String, String>> prescriptions;

  PrescriptionHistoryPage({required this.prescriptions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription History'),
      ),
      body: ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          Map<String, String> prescription = prescriptions[index];
          return ListTile(
            title: Text('Prescription Details: ${prescription['prescriptionDetails']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Checkup Date: ${prescription['checkupDate']}'),
                Text('Doctor Name: ${prescription['doctorName']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
