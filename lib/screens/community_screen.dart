import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _messageController = TextEditingController();

  // قائمة رسائل وهمية عشان الشاشة ما تكون فاضية
  List<Map<String, dynamic>> messages = [
    {"text": "السلام عليكم، أحد فاهم درس الـ State Management؟", "isMe": false, "time": "10:00 AM", "user": "خالد"},
    {"text": "وعليكم السلام، إيه بسيط جداً.. شوف شرح محمد علي ممتاز.", "isMe": true, "time": "10:05 AM", "user": "أنا"},
    {"text": "ممكن الرابط لو سمحت؟", "isMe": false, "time": "10:07 AM", "user": "خالد"},
    {"text": "تفضل هذا هو الرابط.. بالتوفيق!", "isMe": true, "time": "10:10 AM", "user": "أنا"},
    {"text": "شكراً جزيلاً ❤️", "isMe": false, "time": "10:12 AM", "user": "خالد"},
  ];

  // دالة إرسال الرسالة
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          "text": _messageController.text,
          "isMe": true,
          "time": "${DateTime.now().hour}:${DateTime.now().minute}",
          "user": "أنا"
        });
        _messageController.clear(); // مسح الحقل بعد الإرسال
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("مجتمع المبرمجين 💻", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // 1. منطقة عرض الرسائل
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return _buildMessageBubble(
                  msg['text'], 
                  msg['isMe'], 
                  msg['user'],
                  msg['time']
                );
              },
            ),
          ),

          // 2. منطقة الكتابة (في الأسفل)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -2))
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "اكتب رسالتك هنا...",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: const Color(0xFF6A11CB),
                  radius: 22,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // تصميم فقاعة الرسالة (مثل الواتساب)
  Widget _buildMessageBubble(String text, bool isMe, String user, String time) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75), // العرض لا يتجاوز 75%
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF6A11CB) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isMe ? const Radius.circular(15) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe) ...[
              Text(user, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 12)),
              const SizedBox(height: 5),
            ],
            Text(
              text,
              style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 15),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(color: isMe ? Colors.white70 : Colors.grey, fontSize: 10),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}