import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List> getAllDocumentsByUserId(String userId) async {
  final data =
      await supabase.from('documents').select('*').eq("user_id", userId);
  return data;
}
