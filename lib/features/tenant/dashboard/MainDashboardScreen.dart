import 'package:flutter/material.dart';
import 'package:nest_manager/features/tenant/dashboard/payment/presentation/screens/PaymentsScreen.dart';
import 'package:nest_manager/features/tenant/dashboard/profile/presentation/screens/ProfileScreen.dart';
import 'package:nest_manager/features/tenant/dashboard/ticket/presentation/screens/TicketsScreen.dart';
import 'package:nest_manager/features/tenant/dashboard/wallet/presentation/screens/WalletScreen.dart';

import 'home/presentation/screens/HomeScreen.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    PaymentsScreen(),
    TicketsScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        indicatorColor: Colors.green.withOpacity(0.2),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Tickets',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet),
            label: 'My Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}