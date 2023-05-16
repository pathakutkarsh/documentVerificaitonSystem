import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/screens/dashboard.dart';
import 'package:document_verification_system/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    rePasswordController.dispose();
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
                        "Sign Up",
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
                    padding: const EdgeInsets.only(
                        left: size_30,
                        right: size_30,
                        top: size_60,
                        bottom: size_6),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      controller: firstnameController,
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
                        labelText: 'First Name',
                        hintText: "Please enter your First Name",
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
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: size_30, vertical: size_6),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      controller: lastnameController,
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
                        labelText: 'Last Name',
                        hintText: "Please enter your Last Name",
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
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: size_30, vertical: size_6),
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
                        hintText: "Please enter your Email Address",
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
                        } else
                          null;
                      },
                      onChanged: (value) {
                        print(value);
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
                        hintText: "Please enter a Password",
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
                      onChanged: (value) {
                        print(value);
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
                      controller: rePasswordController,
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
                        labelText: 'Re-Enter Password',
                        hintText: "Please Re-Enter Password",
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
                        if (passwordController.value.text.compareTo(value!) !=
                            0) {
                          return "Password Not matching";
                        } else
                          null;
                      },
                      onChanged: (value) {
                        print(value);
                        print(rePasswordController.value);
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
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              Dialog(
                                child: Text('Hold Up while we create Account '),
                              ),
                            ],
                          ),
                        );
                      });
                  if ((RegExp(r'\S+@\S+\.\S+')
                          .hasMatch(emailController.value.text)) &&
                      passwordController.value.text ==
                          (rePasswordController.value.text)) {
                    createNewUser(emailController.value.text,
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
                        .whenComplete(() => Navigator.pushReplacementNamed(
                            context, '/dashboard'));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            title: Text('Email or Password Invalid'),
                          );
                        });
                  }

                  // Navigator.pushReplacementNamed(context, '/dashboard');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Dashboard(),
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
                      "Create Account",
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
                const Text("Already Have an Account?"),
                TextButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
