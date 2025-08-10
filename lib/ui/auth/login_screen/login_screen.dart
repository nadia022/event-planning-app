import 'package:evently_app/providers/user_Provider.dart';
import 'package:evently_app/ui/Screens/home_screen/home_screen.dart';
import 'package:evently_app/ui/auth/forget_password_screen/forget_password_screen.dart';
import 'package:evently_app/ui/auth/register_screen/register_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/assets/app_assets.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:evently_app/ui/widgets/language_switch.dart';
import 'package:evently_app/ui/widgets/theme_switch.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;
  var passwordController = TextEditingController(text: "123456");
  var emailController = TextEditingController(text: "nadia@gmail.com");
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var appLocalization = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(height * 0.02),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppAssets.eventlyVerticalLogo),
                  SizedBox(
                    height: height * 0.035,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter email ";
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return "please enter valid email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: appLocalization.email,
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter password ";
                      }
                      if (value.length < 6) {
                        return "The password should at least  6 digits";
                      }
                      return null;
                    },
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                        hintText: appLocalization.password,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                            onTap: () {
                              passwordVisible = !passwordVisible;
                              setState(() {});
                            },
                            child: Icon(passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility))),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ForgetPasswordScreen.routeName);
                        },
                        child: Text(
                          appLocalization.forget_password,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryColorLight,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  FilledButton(
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        appLocalization.login,
                      )),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appLocalization.do_not_have_account,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: Text(
                            appLocalization.create_account,
                            style: TextStyle(
                              color: AppColors.primaryColorLight,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: width * 0.4,
                        color: AppColors.primaryColorLight,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          appLocalization.or,
                          style: TextStyle(
                              fontSize: 16, color: AppColors.primaryColorLight),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: width * 0.4,
                        color: AppColors.primaryColorLight,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                              color: AppColors.primaryColorLight, width: 1),
                        ),
                        minimumSize: Size(361, 56)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.google_logo,
                          height: height * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.03),
                          child: Text(
                            appLocalization.login_with_google,
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.primaryColorLight),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  LanguageSwitch(),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ThemeSwitch(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showloading(context: context, message: "Loading...");
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = await FirebaseUtils.readUserFromFirestore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            context: context,
            message: "Register Successfully....",
            title: "Login",
            posName: "OK",
            posAction: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context, message: "No user found for that email.");
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context,
              message: "Wrong password provided for that user.",
              title: "Error",
              posName: "OK");
        } else if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context,
              message:
                  "The supplied auth credential is incorrect, malformed or has expired",
              title: "Error",
              posName: "OK");
        } else if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context,
              message:
                  "A network error (such as timeout, interrupted connection or unreachable host) has occurred.",
              title: "Error",
              posName: "OK");
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: "Error",
            posName: "OK");
      }
    }
  }

//   Future signInWithGoogle() async {

//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth =  googleUser?.authentication;

//   if(googleUser==null){
//     return ;
//   }

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   // Once signed in, return the UserCredential
//   await FirebaseAuth.instance.signInWithCredential(credential);
// }

// Future<UserCredential> signInWithGoogle() async {
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   if (googleUser == null) {
//     // المستخدم لغى العملية
//     throw Exception("Sign-In cancelled");
//   }

//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
}
