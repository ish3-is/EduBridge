import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // استدعاء ملف الشاشة اللي سويناه

void main() {
  runApp(const EduBridgeApp());
}

class EduBridgeApp extends StatelessWidget {
  const EduBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إخفاء شريط Debug المزعج
      title: 'EduBridge',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true, // تفعيل تصميم قوقل الجديد
      ),
      home: const SplashScreen(), // هنا حددنا نقطة الانطلاق
    );
  }
}