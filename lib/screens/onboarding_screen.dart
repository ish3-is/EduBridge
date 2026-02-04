import 'package:flutter/material.dart';
import 'login_screen.dart'; // تأكدنا من استدعاء ملف الدخول هنا

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // للتحكم في الصفحات
  final PageController _controller = PageController();
  int _currentPage = 0;

  // البيانات
  List<Map<String, dynamic>> onboardingData = [
    {
      "title": "تعلّم بذكاء",
      "body": "اكتشف طرقاً جديدة للتعلم التفاعلي وتطوير مهاراتك بسهولة.",
      "icon": Icons.school_outlined,
    },
    {
      "title": "تواصل مع الخبراء",
      "body": "ابنِ شبكة علاقات قوية مع المعلمين والزملاء في مجالك.",
      "icon": Icons.connect_without_contact,
    },
    {
      "title": "حقق أهدافك",
      "body": "تتبع تقدمك ووصل لقمة طموحك الأكاديمي والمهني.",
      "icon": Icons.emoji_events_outlined,
    },
  ];

  // دالة الانتقال لصفحة الدخول (عشان ما نكرر الكود)
  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // زر "تخطي" في الأعلى
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _goToLogin, // تم الربط هنا
                child: const Text(
                  "تخطي",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
            
            // منطقة الصفحات المنزلقة
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardingContent(
                  title: onboardingData[index]["title"],
                  body: onboardingData[index]["body"],
                  icon: onboardingData[index]["icon"],
                ),
              ),
            ),

            // منطقة النقاط والزر السفلي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // النقاط (Dots)
                  Row(
                    children: List.generate(
                      onboardingData.length,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  
                  // الزر العائم (التالي / ابدأ)
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == onboardingData.length - 1) {
                        _goToLogin(); // إذا آخر صفحة -> روح للدخول
                      } else {
                        _controller.nextPage( // وإلا -> الصفحة التالية
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A11CB),
                      shape: const CircleBorder(), 
                      padding: const EdgeInsets.all(15),
                    ),
                    child: Icon(
                      _currentPage == onboardingData.length - 1 
                          ? Icons.check 
                          : Icons.arrow_forward_ios, 
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة رسم النقاط
  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFF6A11CB) : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

// تصميم المحتوى الداخلي
class OnboardingContent extends StatelessWidget {
  final String title, body;
  final IconData icon;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.body,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFF6A11CB).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 100, color: const Color(0xFF6A11CB)),
        ),
        const SizedBox(height: 40),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
          ),
        ),
      ],
    );
  }
}