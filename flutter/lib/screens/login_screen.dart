import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/screens/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        shadowColor: Colors.transparent,
        primary: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(size_100),
              ),
              child: Container(
                color: primary,
                height: screenHeight(context) * 0.175,
                width: screenWidth(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(size_12),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: size_40,
                            color: base,
                            backgroundColor: Colors.transparent),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: kIsWeb
                  ? EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.3)
                  : const EdgeInsets.all(0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: size_30, vertical: size_60),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: primary),
                            borderRadius: BorderRadius.circular(size_7)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: primary),
                            borderRadius: BorderRadius.circular(size_7)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: primary),
                            borderRadius: BorderRadius.circular(size_7)),
                        labelText: 'Email',
                        hintText: "Please enter your Email address",
                        labelStyle: const TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: size_16,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: size_12,
                        ),
                      ),
                      validator: (value) {
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
                          return "Please enter a valid email address";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: size_30, vertical: size_6),
                    child: TextFormField(
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: primary),
                            borderRadius: BorderRadius.circular(size_7)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: primary),
                            borderRadius: BorderRadius.circular(size_7)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: primary),
                            borderRadius: BorderRadius.circular(size_7)),
                        labelText: 'Password',
                        hintText: "Please enter your Password",
                        labelStyle: const TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: size_16,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: size_12,
                        ),
                      ),
                      validator: (value) {
                        if (value!.length <= 7) {
                          return "Please enter a password greater than 8 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: size_60, bottom: size_12),
              child: InkWell(
                onTap: () {
                  if (emailController.value.text.isNotEmpty &&
                      passwordController.value.text.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: LinearProgressIndicator(),
                          title: Text('Hold Up while we Authenticate'),
                        );
                      },
                    );
                    signInUser(emailController.value.text,
                            passwordController.value.text)
                        .onError((error, stackTrace) => {
                              Navigator.pop(context),
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(error.toString()),
                                    );
                                  }),
                            })
                        .whenComplete(() => {
                              Navigator.pushReplacementNamed(
                                  context, '/dashboard')
                            });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text('Invalid Email and Password'),
                        );
                      },
                    );
                  }

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => RequestDocument(),
                  //   ),
                  // );
                },
                child: Container(
                  width: 240,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: base,
                          fontSize: size_16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Do not have a account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text("Sign up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
