// // ignore_for_file: unused_local_variable

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../utils/secure_storage.dart';
// import 'package:http/http.dart' as http;

// class OutlateInstoreActivity extends StatefulWidget {
//   final String outlet_code;

//   OutlateInstoreActivity({Key? key, required this.outlet_code})
//       : super(key: key);

//   @override
//   State<OutlateInstoreActivity> createState() => _OutlateInstoreActivityState();
// }

// class _OutlateInstoreActivityState extends State<OutlateInstoreActivity> {
//   bool isLoading = true;
//   String? _takenImagePath1;
//   String? _takenImagePath2;
//   String? _takenImagePath3;
//   bool _loading1 = false;
//   bool _loading2 = false;
//   bool _loading3 = false;

//   List<OutletSurvey> _activityList = <OutletSurvey>[];
//   List<String?> selectedOptions = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   // Future<void> _saveInstoreacti() async {
//   //   print("checkModuleId::::${checkModuleId}");
//   //   print("checkModuleType::::${checkModuleType}");
//   //   print("checkListID::::${checkListID}");
//   //   print("test:::::::");

//   //   // Null check for checkListID
//   //   if (checkListID == null) {
//   //     // Handle the case when checkListID is null
//   //     return;
//   //   }

//   //   var t_code = await UserSecureStorage().gettcode();

//   //   // Initialize images list before using it
//   //   List<File> images = [];
//   //   if (_takenImagePath1 != null) {
//   //     images.add(File(_takenImagePath1!));
//   //   }
//   //   if (_takenImagePath2 != null) {
//   //     images.add(File(_takenImagePath2!));
//   //   }
//   //   if (_takenImagePath3 != null) {
//   //     images.add(File(_takenImagePath3!));
//   //   }

//   //   // Convert images to base64 strings
//   //   List<String> imageBase64Strings = [];
//   //   for (File image in images) {
//   //     List<int> imageBytes = await image.readAsBytes();
//   //     String base64Image = base64Encode(imageBytes);
//   //     imageBase64Strings.add(base64Image);
//   //   }

//   //   List<Map<String, dynamic>> chkListObject = [];

//   //   // Iterate over each question and answer pair
//   //   for (int index = 0; index < _activityList.length; index++) {
//   //     String checkListName = _activityList[index].cHECKLISTNAME.toString();
//   //     String questionType = _activityList[index].qUESTYPE.toString();
//   //     String answer = '';

//   //     // Determine the answer based on the question type
//   //     if (questionType == 'I') {
//   //       answer = _takenImagePath1.toString();
//   //       //answer = _takenImagePath1?.length.toString() ?? '';
//   //     } else if (questionType == 'R') {
//   //       answer = selectedOptions[index]
//   //           .toString(); // Ensure selectedOption is not null
//   //     }

//   //     // Add question and answer to chkListObject
//   //     chkListObject.add({
//   //       "CHECK_LIST_ID": checkListID,
//   //       "CheckListName": checkListName,
//   //       "CheckListRemark": answer,
//   //       "CHKLST_OPTION_VALUE": answer,
//   //     });
//   //   }

//   //   Map<String, dynamic> jsonData = {
//   //     "CHKLIST_OBJECT": chkListObject,
//   //     //"IMAGES": imageBase64Strings, // Include image data in JSON payload
//   //   };

//   //   String jsonString = jsonEncode(jsonData);

//   //   // Null check for t_code
//   //   if (t_code == null) {
//   //     // Handle the case when t_code is null
//   //     return;
//   //   }

//   //   var body = {
//   //     "LeadId":
//   //         "${widget.outlet_code ?? ''}", // Provide default value if outlet_code is null
//   //     "CHECKLIST_MODULE_ID":
//   //         checkModuleId ?? '', // Provide default value if checkModuleId is null
//   //     "CHECKLIST_MODULE_TYPE":
//   //         checkModuleType, // Provide default value if checkModuleType is null
//   //     "T_CODE": t_code,
//   //     "JsonList": jsonString,
//   //   };

//   //   print("Body:::::::${body}");

//   //   var res = await http.post(
//   //     Uri.parse(API.Ws_Save_CheckList),
//   //     headers: {
//   //       "Accept": "application/json",
//   //       "Content-Type": "application/x-www-form-urlencoded"
//   //     },
//   //     body: body,
//   //   );

//   //   var bodyIs = res.body;
//   //   var statusCode = res.statusCode;
//   //   print("statusCode:::::${statusCode}");
//   //   if (statusCode == 200) {
//   //     print("test1:::::::");
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text("Save successfully")),
//   //     );
//   //     debugPrint("res is  2222${res.body}");

//   //     // Handle response data here
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text("Something went wrong, try again")),
//   //     );
//   //   }
//   //   setState(() {
//   //     _takenImagePath1 = null;
//   //     _takenImagePath2 = null;
//   //     _takenImagePath3 = null;
//   //   });

//   //   // Reset selected options for radio buttons
//   //   setState(() {
//   //     selectedOptions.clear();
//   //     _initializeSelectedOptions(); // Reinitialize selectedOptions list
//   //   });
//   // }

//   void _initializeSelectedOptions() {
//     for (var activity in _activityList) {
//       selectedOptions.add(null);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 20),
//           child: GestureDetector(
//             onTap: () async {},
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: const Color.fromARGB(255, 16, 36, 53),
//               ),
//               height: MediaQuery.of(context).size.height * 0.055,
//               child: const Center(
//                 child: Text(
//                   'Submit',
//                   textScaleFactor: 1.2,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: _activityList.length,
//         itemBuilder: (context, index) {
//           var activity = _activityList[index];
//           if (activity.qUESTYPE == 'I') {
//             return buildImageActivity(activity, index);
//           } else {
//             return const SizedBox(); // Return an empty container for other types
//           }
//         },
//       ),
//     );
//   }

//   Widget buildImageActivity(activity, int index) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             activity.cHECKLISTNAME ?? '',
//             style: const TextStyle(
//               color: Colors.blueAccent,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   openCamera(context, activity);
//                 },
//                 child:
//                     const Icon(Icons.camera_alt_rounded, color: Colors.black),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//             ],
//           ),
//           if (_takenImagePath1 != null && index == 0)
//             Center(
//               child: _buildViewButton(context, _takenImagePath1!, _loading1, 1),
//             ),
//           if (_takenImagePath2 != null && index == 1)
//             Center(
//               child: _buildViewButton(context, _takenImagePath2!, _loading2, 2),
//             ),
//           if (_takenImagePath3 != null && index == 2)
//             Center(
//               child: _buildViewButton(context, _takenImagePath3!, _loading3, 3),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildViewButton(
//       BuildContext context, String? imagePath, bool loading, int imageNumber) {
//     return loading
//         ? const CircularProgressIndicator() // Show loader when loading
//         : Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (imagePath != null) // Check if imagePath is not null
//                 TextButton(
//                   onPressed: () {
//                     showImagePopup(context, imagePath);
//                   },
//                   child: const Text('View'),
//                 ),
//               const SizedBox(width: 10), // Add some spacing between buttons
//               TextButton(
//                 onPressed: () {
//                   deleteImage(imageNumber);
//                 },
//                 child: const Text('Delete'),
//               ),
//             ],
//           );
//   }

//   void deleteImage(int imageNumber) {
//     setState(() {
//       if (imageNumber == 1) {
//         _takenImagePath1 = null;
//       } else if (imageNumber == 2) {
//         _takenImagePath2 = null;
//       } else if (imageNumber == 3) {
//         _takenImagePath3 = null;
//       }
//     });
//   }

//   void openCamera(BuildContext context, activity) async {
//     if (activity.qUESTYPE == 'I') {
//       final pickedFile = await showModalBottomSheet<PickedFile>(
//         context: context,
//         builder: (context) => Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.camera_alt),
//               title: const Text('Take a picture'),
//               onTap: () async {
//                 final picker = ImagePicker();
//                 final pickedFile =
//                     await picker.getImage(source: ImageSource.camera);
//                 Navigator.pop(context, pickedFile);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.image),
//               title: const Text('Choose from gallery'),
//               onTap: () async {
//                 final picker = ImagePicker();
//                 final pickedFile =
//                     await picker.pickImage(source: ImageSource.gallery);
//                 Navigator.pop(context, pickedFile);
//               },
//             ),
//           ],
//         ),
//       );

//       if (pickedFile != null) {
//         setState(() {
//           if (activity == _activityList[0]) {
//             _takenImagePath1 = pickedFile.path;
//           } else if (activity == _activityList[1]) {
//             _takenImagePath2 = pickedFile.path;
//           } else if (activity == _activityList[2]) {
//             _takenImagePath3 = pickedFile.path;
//           }
//         });
//       }
//     } else {
//       // Handle other types of activities here
//     }
//   }

//   void showImagePopup(BuildContext context, String imagePath) {
//     setState(() {
//       if (_takenImagePath1 == imagePath) {
//         _loading1 = true; // Set loading state to true for image 1
//       } else if (_takenImagePath2 == imagePath) {
//         _loading2 = true; // Set loading state to true for image 2
//       } else if (_takenImagePath3 == imagePath) {
//         _loading3 = true; // Set loading state to true for image 3
//       }
//     });
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Captured Image'),
//           content: Image.file(File(imagePath)),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 setState(() {
//                   if (_takenImagePath1 == imagePath) {
//                     _loading1 = false; // Reset loading state for image 1
//                   } else if (_takenImagePath2 == imagePath) {
//                     _loading2 = false; // Reset loading state for image 2
//                   } else if (_takenImagePath3 == imagePath) {
//                     _loading3 = false; // Reset loading state for image 3
//                   }
//                 });
//               },
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
