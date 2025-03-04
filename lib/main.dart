import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_image_picker/widgets/floating_tab.dart';
// import 'screens/post_upload_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // ✅ Use GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FloatingTabs(),
    );
  }
}
