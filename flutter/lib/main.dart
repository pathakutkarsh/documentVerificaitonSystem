import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://mjhtcnoxatlhfnduhupy.supabase.co",
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1qaHRjbm94YXRsaGZuZHVodXB5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM3NDMyNzAsImV4cCI6MTk5OTMxOTI3MH0.YdHD5jmJI4-cvAYt5pl5i5PomYy9YyPog69t7c_zDi0',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Document Scanner',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: primary, secondary: base)),
        home: const SignupScreen());
  }
}
