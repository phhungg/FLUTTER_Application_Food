import 'package:flutter/material.dart';
import 'package:flutter_application_/consts/my_validator.dart';
import 'package:flutter_application_/root_screens.dart';
import 'package:flutter_application_/screens/auth/forgot_password.dart';
import 'package:flutter_application_/screens/auth/register.dart';
import 'package:flutter_application_/screens/inner_screens.dart/loading_manager.dart';
import 'package:flutter_application_/services/my_app_methods.dart';
import 'package:flutter_application_/widgets/app_name.dart';
import 'package:flutter_application_/widgets/auth/google_button.dart';
import 'package:flutter_application_/widgets/subtitle_text.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = "/LoginScreens";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController txtemail;
  late final TextEditingController txtpassword;
  late final FocusNode txtemailfocus;
  late final FocusNode txtpasswordlfocus;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    txtemail = TextEditingController();
    txtpassword = TextEditingController();
    txtemailfocus = FocusNode();
    txtpasswordlfocus = FocusNode();
    super.initState();
  }

  void dispose() {
    txtemail.dispose();
    txtpassword.dispose();
    txtemailfocus.dispose();
    txtpasswordlfocus.dispose();
    super.dispose();
  }

  Future<void> _loginFct() async {
    // final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    // if (isValid) {}
    try {
      setState(() {
        isLoading = true;
      });
      await auth.signInWithEmailAndPassword(
        email: txtemail.text.trim(),
        password: txtpassword.text.trim(),
      );
      Fluttertoast.showToast(
        msg: "Login Successed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 17,
      );
      if (!mounted) return;
      Navigator.pushNamed(context, RootScreens.routeName);
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      await MyAppMethods.showErrorOrWarningDialog(
          context: context,
          subtitle: "An error has been occured ${error.message}",
          fct: () {});
    } catch (error) {
      if (!mounted) return;
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const AppName(
                    fs: 30,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TitleText(label: "Welcome back !"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: txtemail,
                          focusNode: txtemailfocus,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email Address",
                            prefixIcon: Icon(IconlyLight.message),
                          ),
                          validator: (value) {
                            return MyValidator.emailvalidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(txtpasswordlfocus);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtpassword,
                          focusNode: txtpasswordlfocus,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: "**************",
                            prefixIcon: const Icon(IconlyLight.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          validator: (value) {
                            return MyValidator.passwordValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            _loginFct();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                ForgotPassword.routeName,
                              );
                            },
                            child: const SubtitleText(
                              label: "Forgot Password",
                              textDecoration: TextDecoration.underline,
                              fst: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              _loginFct();
                            },
                            label: const Text(
                              "Login",
                              style: TextStyle(fontSize: 17),
                            ),
                            icon: const Icon(Icons.login_outlined),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SubtitleText(
                          label: "Or connect using".toUpperCase(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: kBottomNavigationBarHeight + 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child: FittedBox(child: GoogleButton()),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(12),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RootScreens.routeName);
                                    },
                                    child: const Text(
                                      "Guest",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SubtitleText(label: "Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RegisterScreen.routeName);
                              },
                              child: const SubtitleText(
                                label: "Sign Up",
                                textDecoration: TextDecoration.underline,
                                fst: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
