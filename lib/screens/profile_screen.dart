import 'package:flutter/material.dart';
import 'login_screen.dart'; // عشان زر تسجيل الخروج يرجعنا

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // 1. صورة البروفايل مع زر التعديل
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black.withOpacity(0.1)),
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://i.pravatar.cc/150?img=11"), // نفس الصورة اللي في الهوم
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: Colors.white),
                        color: const Color(0xFF6A11CB),
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 15),
            const Text("أحمد محمد", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("ahmed@student.com", style: TextStyle(fontSize: 16, color: Colors.grey)),
            
            const SizedBox(height: 30),

            // 2. إحصائيات الطالب (Gamification)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ProfileStat(count: "12", label: "كورس مكتمل"),
                  _ProfileStat(count: "5", label: "شهادات"),
                  _ProfileStat(count: "240", label: "نقطة"),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Divider(),

            // 3. القائمة (List Tiles)
            _buildListTile(Icons.person_outline, "تعديل المعلومات", () {}),
            _buildListTile(Icons.language, "اللغة (العربية)", () {}),
            _buildListTile(Icons.notifications_outlined, "الإشعارات", () {}),
            _buildListTile(Icons.help_outline, "المساعدة والدعم", () {}),
            
            // زر تسجيل الخروج (مميز بلون أحمر)
            _buildListTile(Icons.logout, "تسجيل الخروج", () {
              // أكشن الخروج
              _showLogoutDialog(context);
            }, color: Colors.red),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // دالة لبناء عنصر في القائمة
  Widget _buildListTile(IconData icon, String title, VoidCallback onTap, {Color color = Colors.black87}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  // دالة لإظهار تنبيه تأكيد الخروج
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تنبيه"),
        content: const Text("هل أنت متأكد أنك تريد تسجيل الخروج؟"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء")),
          TextButton(
            onPressed: () {
              // الرجوع لصفحة الدخول وحذف كل الصفحات السابقة
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text("نعم، خروج", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ويدجت صغيرة للإحصائيات
class _ProfileStat extends StatelessWidget {
  final String count;
  final String label;

  const _ProfileStat({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6A11CB))),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}