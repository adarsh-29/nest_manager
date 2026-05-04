import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import 'core/routs/Routs.dart';
import 'features/tenant/auth/presentation/provider/LoginProvider.dart';
import 'features/tenant/auth/presentation/provider/OtpProvider.dart';
import 'features/tenant/auth/presentation/screens/LoginScreen.dart';
import 'features/tenant/auth/presentation/screens/OtpScreen.dart';
import 'features/tenant/dashboard/MainDashboardScreen.dart';
import 'features/tenant/dashboard/home/presentation/provider/HomeProvider.dart';
import 'features/tenant/dashboard/home/presentation/screens/HomeScreen.dart';
import 'features/tenant/dashboard/payment/presentation/provider/PaymentsProvider.dart';
import 'features/tenant/dashboard/payment/presentation/screens/PaymentsScreen.dart';
import 'features/tenant/dashboard/profile/presentation/provider/ProfileProvider.dart';
import 'features/tenant/dashboard/profile/presentation/screens/ProfileScreen.dart';
import 'features/tenant/dashboard/ticket/presentation/provider/TicketsProvider.dart';
import 'features/tenant/dashboard/ticket/presentation/screens/TicketsScreen.dart';
import 'features/tenant/dashboard/wallet/presentation/provider/WalletProvider.dart';
import 'features/tenant/dashboard/wallet/presentation/screens/WalletScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider( create: (_) => LoginProvider(
            //UserRepository(apiService),
          ),
        ),
         ChangeNotifierProvider(create: (_) => OtpProvider(
              //  ProductRepository(apiService)
            )
        ),
        ChangeNotifierProvider(create: (_) => HomeProvider(
              //  ProductRepository(apiService)
            )
        ),
        ChangeNotifierProvider(create: (_) => PaymentsProvider(
              //  NewProductRepository(apiService)
            )
        ),
        ChangeNotifierProvider(create: (_) => TicketsProvider(
              //  NewProductRepository(apiService)
            )
        ),
        ChangeNotifierProvider(create: (_) => WalletProvider(
              //  NewProductRepository(apiService)
            )
        ),
        ChangeNotifierProvider(create: (_) => ProfileProvider(
          //  NewProductRepository(apiService)
        )
        ),

      ],

      /*child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),*/

      child: MaterialApp(

        debugShowCheckedModeBanner: false,
      //  theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        //  Initial screens
        initialRoute: AppRoutes.login,

        //  Named routes
        routes: {
          //'/splash': (_) => const SplashScreen(),
          AppRoutes.login: (_) => const LoginScreen(),
          AppRoutes.otp: (_) => const OtpScreen(),
          AppRoutes.mainDashboard: (_) => const MainDashboardScreen(),
          AppRoutes.home: (_) => const HomeScreen(),
          AppRoutes.payments: (_) => const PaymentsScreen(),
          AppRoutes.tickets: (_) => const TicketsScreen(),
          AppRoutes.wallet: (_) => const WalletScreen(),
          AppRoutes.profile: (_) => const ProfileScreen(),


        },
      ),
    );
  }
}


