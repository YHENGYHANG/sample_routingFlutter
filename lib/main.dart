import 'package:flutter/material.dart';

import 'routes/app_routes.dart'; //import app_routes.dart so we can access the routes defined in app_routes.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Routing Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, //useMaterial3 is a property of ThemeData that enables the use of Material Design 3 features in the app. It is set to true, which means that the app will use Material Design 3 components and styles.
        colorSchemeSeed: Colors.blue, //colorSchemeSeed is a property of ThemeData that defines the primary color of the app. It is set to Colors.blue, which means that the app will use blue as its primary color.
        brightness: Brightness.light, //brightness is a property of ThemeData that defines the overall brightness of the app. It is set to Brightness.light, which means that the app will use a light color scheme.
      ),
      initialRoute: AppRoutes.main, //initialRoute is a property of MaterialApp that defines the first route to be displayed when the app starts. It is set to AppRoutes.mainScreen, which means that the MainScreen widget will be displayed first.
      routes: AppRoutes.routes, //routes is a property of MaterialApp that defines the available routes in the app. It is set to AppRoutes.routes, which means that the routes defined in the AppRoutes class will be used in the app.
    );
  }
}



















































// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   final List<Map<String, dynamic>> students = const [
//     {'name': 'John Doe', 'course': 'Computer Science', 'age': 20},
//     {'name': 'Jane Smith', 'course': 'Mathematics', 'age': 22},
//     {'name': 'Michael Johnson', 'course': 'Physics', 'age': 21},
//     {'name': 'Emily Davis', 'course': 'Chemistry', 'age': 19},
//     {'name': 'William Brown', 'course': 'Biology', 'age': 23},
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Custom Widget')),
//         body: ListView.builder(
//           itemCount: students.length,
//           itemBuilder: (context, index) {
//             return StudentCard(
//               name: students[index]['name'],
//               course: students[index]['course'],
//               age: students[index]['age'],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class StudentCard extends StatelessWidget {
//   final String name;
//   final String course;
//   final int age;

//   const StudentCard({
//     super.key,
//     required this.name,
//     required this.course,
//     required this.age,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [Text(name), Text(course)],
//         ),
//       ),
//     );
//   }
// }
