import 'package:evently_app/providers/user_Provider.dart';
import 'package:evently_app/ui/Screens/home_screen/home_screen.dart';
import 'package:evently_app/ui/auth/login_screen/login_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/assets/app_assets.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:evently_app/ui/widgets/language_switch.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:evently_app/model/my_user.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "registerScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisible = true;
  bool rePasswordVisible = true;
  var nameController = TextEditingController(text: "nadia");
  var passwordController = TextEditingController(text: "123456");
  var emailController = TextEditingController(text: "nadia@gmail.com");
  var rePasswordController = TextEditingController(text: "123456");
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.24),
          child: Text(
            appLocalization.register,
            style: TextStyle(fontSize: 22, color: AppColors.black),
          ),
        ),
      ),
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
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter name ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: appLocalization.name,
                      prefixIcon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: height * 0.02,
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
                      prefixIcon: Icon(Icons.email)),
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
                      return "The password should at least 6 digits";
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
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: rePasswordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter repassword ";
                    }
                    if (value != passwordController.text) {
                      return "The password does not match with repassword ";
                    }
                    return null;
                  },
                  obscureText: rePasswordVisible,
                  decoration: InputDecoration(
                      hintText: appLocalization.re_password,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          rePasswordVisible = !rePasswordVisible;
                          setState(() {});
                        },
                        child: Icon(rePasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                FilledButton(
                    onPressed: () {
                      register();
                    },
                    child: Text(
                      appLocalization.create_account,
                    )),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLocalization.already_have_account,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: Text(
                          appLocalization.login,
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
                  height: height * 0.02,
                ),
                LanguageSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showloading(context: context, message: "Loading...");
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser user = MyUser(
            email: emailController.text,
            name: nameController.text,
            id: credential.user?.uid ?? '');
        await FirebaseUtils.addUserTofirestore(user);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            context: context,
            message: "Register Successfully....",
            title: "Register",
            posName: "OK",
            posAction: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            });
        print("Register Successfully....");
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context, message: "No user found for that email.");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context,
              message: "Wrong password provided for that user.",
              title: "Error",
              posName: "OK");
          print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context,
              message:
                  "The supplied auth credential is incorrect, malformed or has expired",
              title: "Error",
              posName: "OK");
          print(
              "The supplied auth credential is incorrect, malformed or has expired.");
        } else if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context,
              message:
                  "A network error (such as timeout, interrupted connection or unreachable host) has occurred.",
              title: "Error",
              posName: "OK");
          print(
              "A network error (such as timeout, interrupted connection or unreachable host) has occurred.");
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context,
              message:
                  "The email address is already in use by another account.",
              title: "Error",
              posName: "OK");
          print("The email address is already in use by another account.");
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: "Error",
            posName: "OK");
        print(e.toString());
      }
    }
  }
}
