import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      // SafeArea giúp app không bị che khuất bởi tai thỏ
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildBanner(),
              const SizedBox(height: 20),
              _buildMenuGrid(),
              const SizedBox(height: 20),
              _buildSectionTitle("Kiến thức chuyên môn"),
              const SizedBox(height: 10),
              _buildExpertiseList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Tra cứu"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, color: Colors.blue), label: "Thêm"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Dược thư"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cá nhân"),
        ],
      ),
    );
  }

  // Các hàm xây dựng widget con
  Widget _buildHeader() => Row(
    children: [
      const CircleAvatar(radius: 25, child: Icon(Icons.person)),
      const SizedBox(width: 10),
      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Chào buổi sáng,"),
        Text("Dược sĩ Minh Anh", style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
      const Spacer(),
      const Icon(Icons.notifications_none),
    ],
  );

  Widget _buildSearchBar() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
    child: const TextField(decoration: InputDecoration(hintText: "Tìm thuốc...", border: InputBorder.none, prefixIcon: Icon(Icons.search))),
  );

  Widget _buildBanner() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(20)),
    child: const Row(children: [
      Expanded(child: Text("Gợi ý thuốc thông minh", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
      Icon(Icons.medical_services, size: 50, color: Colors.white),
    ]),
  );

  Widget _buildMenuGrid() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _menuItem(Icons.search, "Tra cứu"),
      _menuItem(Icons.compare_arrows, "Tương tác"),
    ],
  );

  Widget _menuItem(IconData icon, String label) => Column(children: [
    Icon(icon, color: Colors.blue),
    Text(label, style: const TextStyle(fontSize: 12)),
  ]);

  Widget _buildSectionTitle(String title) => Row(children: [
    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
  ]);

  Widget _buildExpertiseList() => SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) => Container(
        width: 150,
        margin: const EdgeInsets.only(right: 10),
        color: Colors.grey.shade300,
        child: const Center(child: Text("Bài viết...")),
      ),
    ),
  );
}