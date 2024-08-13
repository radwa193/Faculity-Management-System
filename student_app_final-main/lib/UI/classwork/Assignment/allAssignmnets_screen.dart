// import 'package:flutter/material.dart';
// import 'package:management_app/models/assignment.dart';
//
// class AllAssignmentsScreen extends StatelessWidget {
//   AllAssignmentsScreen({Key? key}) : super(key: key);
//
//   List<Assignment> assignments = [
//     Assignment(
//       title: 'Linear Regression Code Assignment',
//       description: 'Implement a linear regression model using python',
//       deadline: '15/10/2024 12:00 PM',
//       grade: '     /10',
//     ),
//     Assignment(
//       title: 'Report Assignment',
//       description: 'Write a report on the topic "The impact of technology on education"',
//       deadline: '10/10/2024 12:00 PM',
//       grade: '     /10',
//     ),
//     Assignment(
//       title: 'Quiz Assignment',
//       description: 'Solve the quiz on the topic "Introduction to Machine Learning"',
//       deadline: '20/10/2024 12:00 PM',
//       grade: '     /10',
//     ),
//     Assignment(
//       title: 'Linear Regression Code Assignment',
//       description: 'Implement a linear regression model using python',
//       deadline: '15/10/2024 12:00 PM',
//       grade: '     /10',
//     ),
//     Assignment(
//       title: 'Report Assignment',
//       description: 'Write a report on the topic "The impact of technology on education"',
//       deadline: '10/10/2024 12:00 PM',
//       grade: '     /10',
//     ),
//     Assignment(
//       title: 'Quiz Assignment',
//       description: 'Solve the quiz on the topic "Introduction to Machine Learning"',
//       deadline: '20/10/2024 12:00 PM',
//       grade: '     /10',
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar : AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_outlined),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Row(
//             children: [
//               Text(
//                 'Assignmnets',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body : Container(
//           decoration: const BoxDecoration(
//               color: Colors.white
//           ),
//           child : Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemBuilder: (context , index) => assignmentItemBuilder(
//                         assignments[index]
//                     ),
//                     itemCount: assignments.length,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//     );
//   }
//   Widget assignmentItemBuilder(Assignment assignment) =>  Card(
//     child: Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.orange, // Border color
//           width: 1, // Border width
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               assignment.title,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               assignment.description,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               assignment.deadline,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 const Text(
//                   'Grade: ',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Text(
//                   assignment.grade,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
//
// }
