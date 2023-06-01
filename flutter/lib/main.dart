import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/variables.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/screens/dashboard.dart';
import 'package:document_verification_system/screens/login_screen.dart';
import 'package:document_verification_system/screens/all_department_dashboard.dart';
import 'package:document_verification_system/screens/settings_page.dart';
import 'package:document_verification_system/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isCommercial = false;
  var userId;

  await Supabase.initialize(
    url: "https://mjhtcnoxatlhfnduhupy.supabase.co",
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1qaHRjbm94YXRsaGZuZHVodXB5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM3NDMyNzAsImV4cCI6MTk5OTMxOTI3MH0.YdHD5jmJI4-cvAYt5pl5i5PomYy9YyPog69t7c_zDi0',
  ).then((value) async {
    userId = value.client.auth.currentUser?.id;
    isCommercial = await isUserCommercial(userId);
    setIsUserCommercial(isCommercial);
  });
  runApp(MyApp(
    isCommercial: isCommercial,
    userId: userId,
  ));
}

class MyApp extends StatelessWidget {
  final bool isCommercial;
  final userId;
  const MyApp({Key? key, required this.isCommercial, required this.userId})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Document Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: primary, secondary: base),
      ),
      initialRoute: userId != null
          ? isCommercial == true
              ? '/request'
              : '/dashboard'
          : '/',
      routes: {
        '/': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const Dashboard(),
        '/request': (context) => const AllDepartmentDashboard(),
      },
    );
  }
}
