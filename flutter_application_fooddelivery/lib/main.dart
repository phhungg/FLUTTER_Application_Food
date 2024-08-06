import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/consts/app_containts.dart';
import 'package:flutter_application_/consts/theme_data.dart';
import 'package:flutter_application_/providers/cart_provider.dart';
import 'package:flutter_application_/providers/items_categorys.dart';
import 'package:flutter_application_/providers/theme_providers.dart';
import 'package:flutter_application_/providers/user_provider.dart';
import 'package:flutter_application_/providers/view_prod_provider.dart';
import 'package:flutter_application_/providers/wishlist_provider.dart';
import 'package:flutter_application_/root_screens.dart';
import 'package:flutter_application_/screens/auth/forgot_password.dart';
import 'package:flutter_application_/screens/auth/login.dart';
import 'package:flutter_application_/screens/auth/register.dart';
import 'package:flutter_application_/screens/inner_screens.dart/cart_details.dart';
import 'package:flutter_application_/screens/inner_screens.dart/view_recent.dart';
import 'package:flutter_application_/screens/inner_screens.dart/wishlist_screens.dart';
import 'package:flutter_application_/screens/map/gg-maps.dart';
import 'package:flutter_application_/screens/search_screns.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: AppContaints.apiKey,
          appId: AppContaints.appId,
          messagingSenderId: AppContaints.messagingSenderId,
          projectId: AppContaints.projectId,
          storageBucket: AppContaints.storagebucket,
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: SelectableText(snapshot.error.toString()),
              ),
            ),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                return ThemeProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return ItemsCategory();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return CartProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return WishlistProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return ViewProdProvider();
              },
            ),
            ChangeNotifierProvider(create: (_) {
              return UserProvider();
            })
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Flutter Demo",
                theme: Style.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context),
                home: const RootScreens(),
                routes: {
                  CartDetails.routeName: (context) => CartDetails(),
                  WishlistScreens.routeName: (context) =>
                      const WishlistScreens(),
                  ViewRecent.routeName: (context) => const ViewRecent(),
                  RegisterScreen.routeName: (context) => const RegisterScreen(),
                  ForgotPassword.routeName: (context) => const ForgotPassword(),
                  SearchScreens.routeName: (context) => const SearchScreens(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  RootScreens.routeName: (context) => const RootScreens(),
                  GGmap.routeName: (context) => const GGmap(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
