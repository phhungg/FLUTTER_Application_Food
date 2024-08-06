import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/models/user_models.dart';
import 'package:flutter_application_/providers/theme_providers.dart';
import 'package:flutter_application_/providers/user_provider.dart';
import 'package:flutter_application_/screens/auth/login.dart';
import 'package:flutter_application_/screens/inner_screens.dart/loading_manager.dart';
import 'package:flutter_application_/screens/inner_screens.dart/view_recent.dart';
import 'package:flutter_application_/screens/inner_screens.dart/wishlist_screens.dart';
import 'package:flutter_application_/screens/map/covert_coordinates.dart';
import 'package:flutter_application_/screens/map/gg-maps.dart';
import 'package:flutter_application_/services/assets_manager.dart';
import 'package:flutter_application_/services/my_app_methods.dart';
import 'package:flutter_application_/widgets/app_name.dart';
import 'package:flutter_application_/widgets/custom_list_title.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:provider/provider.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({super.key});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  UserModels? userModels;
  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModels = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppMethods.showErrorOrWarningDialog(
          context: context,
          subtitle: "An error has been occured $error",
          fct: () {});
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: AppName(),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Image.asset(AssetsManager.profile),
        ),
      ),
      body: LoadingManager(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TitleText(
                    label: "Please login to have ultimate access",
                    fS: 17,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              userModels == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    userModels!.userImage,
                                  ),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText(label: userModels!.userName),
                              SubtitleText(label: userModels!.userEmail),
                            ],
                          )
                        ],
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(label: "General"),
                    CustomListTitle(
                      imagePath: AssetsManager.orderSvg,
                      function: () {},
                      text: "All Function",
                    ),
                    CustomListTitle(
                      imagePath: AssetsManager.wishlistSvg,
                      function: () {
                        Navigator.pushNamed(context, WishlistScreens.routeName);
                      },
                      text: "Wishlist",
                    ),
                    CustomListTitle(
                      imagePath: AssetsManager.recent,
                      function: () {
                        Navigator.pushNamed(context, ViewRecent.routeName);
                      },
                      text: "View Recently",
                    ),
                    CustomListTitle(
                      imagePath: AssetsManager.address,
                      function: () {
                        Navigator.pushNamed(context, GGmap.routeName);
                      },
                      text: "Address",
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TitleText(
                      label: "Settings",
                      fS: 18,
                    ),
                    SwitchListTile(
                      title: Text(themeProvider.getIsDarkTheme
                          ? "Dark Mode"
                          : "Light Mode"),
                      value: themeProvider.getIsDarkTheme,
                      onChanged: (value) {
                        themeProvider.setDarktheme(themevalue: value);
                      },
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () async {
                          if (user == null) {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          } else {
                            await MyAppMethods.showErrorOrWarningDialog(
                                context: context,
                                subtitle: "Are you sure ?",
                                isError: false,
                                fct: () async {
                                  await FirebaseAuth.instance.signOut();
                                  if (!mounted) return;
                                  Navigator.pushNamed(
                                      context, LoginScreen.routeName);
                                });
                          }
                        },
                        icon: Icon(
                          user == null
                              ? Icons.login_outlined
                              : Icons.logout_outlined,
                        ),
                        label: Text(user == null ? "Login" : "Logout"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
