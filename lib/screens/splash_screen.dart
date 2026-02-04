import 'package:flutter/material.dart';
import 'dart:async'; // عشان نستخدم التايمر
import 'onboarding_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // 1. إعداد الأنيميشن (التحريك)
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // مدة الحركة
      vsync: this,
    );

    // حركة الظهور (Fade)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // حركة الانزلاق من تحت لفوق (Slide)
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // تشغيل الحركة
    _controller.forward();

    // 2. المؤقت للانتقال للصفحة التالية
  Timer(const Duration(seconds: 4), () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const OnboardingScreen()),
  );
});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // تصميم الخلفية المتدرجة (Gradient) العصري
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6A11CB), // بنفسجي غامق عصري
              Color(0xFF2575FC), // أزرق تقني
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أنيميشن الشعار (أيقونة مؤقتة)
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: const Icon(
                  Icons.school_rounded, // أيقونة تعبر عن التعليم
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // أنيميشن النص
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                "EduBridge",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5, // تباعد أحرف يعطي فخامة
                  fontFamily: 'Arial', // خط مؤقت لين نضيف خطوط قوقل
                ),
              ),
            ),
             const SizedBox(height: 10),
             FadeTransition(
              opacity: _fadeAnimation,
               child: Text(
                "جسرُك نحو المستقبل",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8), // أبيض شفاف شوي
                ),
              ),
             ),
          ],
        ),
      ),
    );
  }
}