import 'package:flutter/material.dart';
import 'package:nest_manager/core/features/auth/presentation/provider/LoginProvider.dart';
import 'package:nest_manager/core/features/auth/presentation/provider/OtpProvider.dart';
import 'package:nest_manager/core/features/dashboard/home/presentation/provider/HomeProvider.dart';
import 'package:provider/provider.dart';

import 'core/features/auth/presentation/screens/LoginScreen.dart';

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
         ChangeNotifierProvider(
          create: (_) => LoginProvider(
            //UserRepository(apiService),
          ),
        ),
         ChangeNotifierProvider(
            create: (_) => OtpProvider(
              //  ProductRepository(apiService)
            )
        ),
        ChangeNotifierProvider(
            create: (_) => HomeProvider(
              //  ProductRepository(apiService)
            )
        ),
        /*
        ChangeNotifierProvider(
            create: (_) => NewProductProvider(
                NewProductRepository(apiService)
            )
        )*/
      ],

      /*child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),*/

      child: MaterialApp(

        debugShowCheckedModeBanner: false,
      //  theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        //  Initial screens
        initialRoute: '/login',

        //  Named routes
        routes: {
          //'/splash': (_) => const SplashScreen(),
          '/login': (_) => const LoginScreen(),
          /*'/main': (_) => const MainScreen(),
          '/profile': (_) => const ProfileScreen(),
          '/home': (_) => const HomeScreen(),
          '/userDetail': (_) => const UserDetailScreen(),
          '/product': (_) => const ProductScreen(),
          '/productDetail': (_) => const ProductDetailScreen(),
          '/productNew': (_) => const NewProductScreen(),
          '/productDetailNew': (_) => const ProductDetailScreen(),*/

        },
      ),
    );
  }
}


