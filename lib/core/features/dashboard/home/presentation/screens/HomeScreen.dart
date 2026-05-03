import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/HomeProvider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeProvider>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: Column(
        children: [

          /// 🔵 TOP HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F3E6A), Color(0xFF2E6FA3)],
              ),
            ),
            child: Column(
              children: [

                /// Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome back !", style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 4),
                        Text("Priya Mehta",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.notifications, color: Colors.white),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.white24,
                          child: const Text("PM", style: TextStyle(color: Colors.white)),
                        )
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 20),

                /// 💳 RENT CARD
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("₹12,000",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text("Due by April 5, 2025 · 7 days left"),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade100,
                          foregroundColor: Colors.green,
                        ),
                        child: const Text("Pay Now →"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🟢 CONTENT
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ✅ STATUS CARD
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "March Rent Paid!\n₹12,000 paid on Mar 3",
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🔲 ACTION GRID
                  GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      _ActionItem("My Rent", Icons.home),
                      _ActionItem("History", Icons.history),
                      _ActionItem("Raise Ticket", Icons.support),
                      _ActionItem("My KYC", Icons.verified),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 🏠 PROPERTY
                  const Text("My Property", style: TextStyle(fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.apartment, size: 40),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sunrise Apartments",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Unit 3A · 2BHK · Koramangala"),
                            ],
                          ),
                        ),
                        Text("Active", style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// 🔲 Action Item Widget
class _ActionItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ActionItem(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(icon),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}