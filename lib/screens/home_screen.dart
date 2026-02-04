import 'package:flutter/material.dart';
// استدعاء الصفحات اللي سويناها قبل شوي
import 'courses_screen.dart';
import 'community_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; 

  // قائمة الصفحات اللي بنبدل بينها
  final List<Widget> _pages = [
    const HomeBody(),        // الصفحة الرئيسية (التصميم حقنا)
    const CoursesScreen(),   // صفحة الكورسات
    const CommunityScreen(), // صفحة المجتمع
    const ProfileScreen(),   // صفحة الحساب
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], 
      
      // هنا السحر: الجسم يتغير بناءً على الاندكس المختار
      body: SafeArea(
        child: _pages[_selectedIndex], 
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        elevation: 3,
        indicatorColor: const Color(0xFF6A11CB).withOpacity(0.1),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined), 
            selectedIcon: Icon(Icons.home_filled, color: Color(0xFF6A11CB)),
            label: 'الرئيسية'
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined), 
            selectedIcon: Icon(Icons.book, color: Color(0xFF6A11CB)),
            label: 'كورساتي'
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline), 
            selectedIcon: Icon(Icons.chat_bubble, color: Color(0xFF6A11CB)),
            label: 'المجتمع'
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline), 
            selectedIcon: Icon(Icons.person, color: Color(0xFF6A11CB)),
            label: 'حسابي'
          ),
        ],
      ),
    );
  }
}

// ==========================================================
// هذا هو تصميم الصفحة الرئيسية القديم، فصلناه عشان الترتيب
// ==========================================================
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الجزء العلوي (الترحيب + البحث)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF6A11CB),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("مرحباً، أحمد 👋", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        Text("ماذا تريد أن تتعلم اليوم؟", style: TextStyle(color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: "ابحث عن كورس، مدرس...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // التصنيفات
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("التصنيفات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryChip("الكل", true),
                      _buildCategoryChip("برمجة", false),
                      _buildCategoryChip("تصميم", false),
                      _buildCategoryChip("تسويق", false),
                      _buildCategoryChip("لغات", false),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // الكورسات المقترحة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("كورسات مقترحة لك", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                _buildCourseCard("أساسيات Flutter", "محمد علي", Colors.blueAccent),
                _buildCourseCard("تطوير الويب الشامل", "سارة خالد", Colors.orangeAccent),
                _buildCourseCard("الذكاء الاصطناعي", "فهد العمر", Colors.teal),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF6A11CB) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCourseCard(String title, String instructor, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.play_circle_fill, color: color, size: 30),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              Text("المدرس: $instructor", style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}