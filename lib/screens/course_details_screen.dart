import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  // نقدر نمرر اسم الكورس لاحقاً، حالياً بنخليه ثابت
  final String courseTitle;

  const CourseDetailsScreen({super.key, this.courseTitle = "أساسيات Flutter"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. صورة الخلفية الكبيرة في الأعلى
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blueAccent, // لون احتياطي لو ما حملت الصورة
              image: DecorationImage(
                image: NetworkImage("https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // طبقة سوداء خفيفة عشان الكلام يوضح
          Container(
            height: 300,
            color: Colors.black.withOpacity(0.4),
          ),

          // زر الرجوع في الأعلى
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),

          // 2. المحتوى الأبيض (ينزلق فوق الصورة)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65, // ياخذ 65% من الشاشة
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان الكورس والتقييم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: const Text("تطوير تطبيقات", style: TextStyle(color: Colors.white, fontSize: 12)),
                          backgroundColor: const Color(0xFF6A11CB),
                        ),
                        const Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 5),
                            Text("4.8", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    
                    Text(
                      courseTitle, // العنوان المتغير
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Icon(Icons.person, color: Colors.grey, size: 18),
                        SizedBox(width: 5),
                        Text("بواسطة: محمد علي", style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 20),
                        Icon(Icons.timer, color: Colors.grey, size: 18),
                        SizedBox(width: 5),
                        Text("25 ساعة", style: TextStyle(color: Colors.grey)),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // التبويبات (وصف / دروس)
                    const Text("عن الدورة", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text(
                      "في هذه الدورة ستتعلم كيفية بناء تطبيقات موبايل احترافية باستخدام Flutter من الصفر حتى الاحتراف. سنتطرق لبناء الواجهات والتعامل مع البيانات.",
                      style: TextStyle(color: Colors.grey, height: 1.6),
                    ),

                    const SizedBox(height: 30),

                    const Text("محتوى الدورة", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    
                    // قائمة الدروس
                    _buildLessonTile("1", "مقدمة في Flutter", "10:00", true),
                    _buildLessonTile("2", "تثبيت الأدوات", "15:30", false),
                    _buildLessonTile("3", "شرح هيكلة الملفات", "08:45", false),
                    _buildLessonTile("4", "بناء أول واجهة", "20:00", false),
                    const SizedBox(height: 80), // مسافة عشان الزر العائم ما يغطي الكلام
                  ],
                ),
              ),
            ),
          ),

          // 3. زر الاشتراك العائم في الأسفل
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // أكشن الاشتراك
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A11CB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                ),
                child: const Text("اشترك الآن - 50\$", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonTile(String number, String title, String duration, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFF6A11CB).withOpacity(0.1) : Colors.grey[100],
              shape: BoxShape.circle,
              border: Border.all(color: isCompleted ? const Color(0xFF6A11CB) : Colors.transparent),
            ),
            child: Center(
              child: isCompleted 
                ? const Icon(Icons.play_arrow, color: Color(0xFF6A11CB))
                : Text(number, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(duration, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const Spacer(),
          if (isCompleted) const Icon(Icons.check_circle, color: Colors.green, size: 20),
        ],
      ),
    );
  }
}