// screens/subscription_screen.dart
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'streak_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isPremium = false;
  String? planType;
  String? purchaseDate;
  int remainingDays = 0;

  int selectedPlan = 0; // 0 = Monthly, 1 = Yearly

  final monthlyPrice = "4,900";
  final yearlyPrice = "49,000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5EE),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Subscription",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Premium Status
              if (isPremium) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEE7A7A),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 70,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Premium Member",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Subscribed to $planType Plan",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Purchased on: $purchaseDate",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "$remainingDays days remaining",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],

              const Text(
                "Choose your plan",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Cancel anytime • No hidden fees",
                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 24),

              // Monthly Plan
              _buildPlanCard(
                index: 0,
                title: "Monthly",
                price: monthlyPrice,
                period: "month",
                description: "Full access • Cancel anytime",
                isPopular: false,
              ),

              const SizedBox(height: 16),

              // Yearly Plan
              _buildPlanCard(
                index: 1,
                title: "Yearly",
                price: yearlyPrice,
                period: "year",
                description: "Save 16% • Best Value",
                isPopular: true,
              ),

              const SizedBox(height: 40),

              const Text(
                "What you'll get:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildFeature("Unlimited access to all lessons & quizzes"),
              _buildFeature("Advanced Kanji, Grammar & Vocabulary"),
              _buildFeature("Ad-free learning experience"),
              _buildFeature("Progress analytics & insights"),
              _buildFeature("Offline mode"),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false,
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const StreakScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
        selectedItemColor: const Color(0xFFEE7A7A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: "Premium",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_rounded),
            label: "Streak",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required int index,
    required String title,
    required String price,
    required String period,
    required String description,
    required bool isPopular,
  }) {
    bool isSelected = selectedPlan == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedPlan = index);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFEE7A7A) : Colors.transparent,
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPopular)
              const Align(
                alignment: Alignment.topRight,
                child: Chip(
                  label: Text(
                    "Best Value",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  backgroundColor: Color(0xFFEE7A7A),
                ),
              ),
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "MMK /$period",
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(description, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showConfirmationDialog(title),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? const Color(0xFFEE7A7A)
                      : Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Subscribe Now",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(String plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Subscribe to $plan Plan?"),
        content: Text(
          "You are about to subscribe to the $plan plan.\n\nPrice: ${plan == "Monthly" ? monthlyPrice : yearlyPrice} MMK",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processPayment(plan);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEE7A7A),
            ),
            child: const Text("Confirm & Pay"),
          ),
        ],
      ),
    );
  }

  void _processPayment(String plan) {
    // Simulate payment process
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Redirecting to Payment App..."),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog

      setState(() {
        isPremium = true;
        planType = plan;
        purchaseDate = DateTime.now().toString().substring(0, 10);
        remainingDays = plan == "Monthly" ? 30 : 365;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Payment Successful! Welcome to Premium!"),
          backgroundColor: Color(0xFFEE7A7A),
        ),
      );
    });
  }

  Widget _buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFFEE7A7A), size: 24),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
