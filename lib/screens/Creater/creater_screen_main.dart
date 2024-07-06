// import 'package:flutter/material.dart';
// import 'package:travelapp/custom_widgests/custom_text.dart';
// import 'package:travelapp/screens/Creater/add_blog_screen.dart';
// import 'package:travelapp/screens/Creater/trips_add_screen.dart';

// class CreaterScreen extends StatelessWidget {
//   const CreaterScreen({Key? key}) : super(key: key); // Fixed super.key syntax

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 350,
//       width: double.infinity,
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 50,
//           ),
//           const CustomText(
//             text: 'Create your choice',
//             size: 20,
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.add_box,
//               size: 40,
//             ),
//             title: const CustomText(text: 'Add Trip'),
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const AddTripscrren()));
//             },
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.add_box,
//               size: 40,
              
//             ),
//             title: const CustomText(text: 'Add Blogs'),
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const AddBlogpage()));
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
