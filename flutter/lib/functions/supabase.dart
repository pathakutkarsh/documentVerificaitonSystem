import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _supabase = Supabase.instance.client;

Future<List> getAllDocumentsByUserId(String userId) async {
  final data =
      await _supabase.from('documents').select('*').eq("user_id", userId);
  return data;
}

Future<Uint8List> downloadImageFromFileName(String fileName) async {
  String filepath = "/edited/${fileName.trim()}";
  final Uint8List file =
      await _supabase.storage.from('documents').download(filepath);
  return file;
}

Future<PostgrestFilterBuilder<dynamic>> createNewDocumentRequest(
    String id, bool aadhar, bool hsc, bool ssc) async {
  return await _supabase.from('request').insert({
    'id': id,
    'request_aadhar': aadhar,
    'request_hsc': hsc,
    'request_ssc': ssc
  });
}

Future<Map> getListofRequestedDocumentsFromID(String id) async {
  final List data = await _supabase.from('request').select('*').eq("id", id);
  return data[0];
}

Future uploadNewDocument(
    fileName, isValidated, isVerified, userId, requestedById, fileType) async {
  await _supabase.from('documents').insert(
    {
      'file_name': fileName,
      'is_validated': isValidated,
      'is_verified': isVerified,
      'file_bucket_id': fileName,
      'user_id': userId,
      'requested_by': requestedById,
      'edited_image_name': fileName,
      'file_type': fileType,
    },
  );
}

Future<String> uploadImageToBucket(String filePath, fileName) async {
  dynamic output = await _supabase.storage
      .from('documents')
      .upload('/uploaded/$fileName', File(filePath));
  return output;
}

Future<List> getAllDocumentsByRequesterID(String userId) async {
  final data =
      await _supabase.from('documents').select('*').eq("requested_by", userId);
  return data;
}

Future<AuthResponse> createNewUser(String email, String password) async {
  return await _supabase.auth.signUp(email: email, password: password);
}

Future signInUser(String email, String password) async {
  return await _supabase.auth
      .signInWithPassword(email: email, password: password);
}

Future<Session?> getUserSession() async {
  return await _supabase.auth.currentSession;
}

Future logoutuser() {
  return _supabase.auth.signOut();
}

Future<String> getUserId() async {
  return _supabase.auth.currentSession!.user.id;
}

Future addUserInfoToDatabase(
    userId, firstName, lastName, email, isCommercial) async {
  await _supabase.from('users').insert(
    {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'is_commercial': isCommercial,
    },
  );
}

Future<bool> isUserCommercial(userId) async {
  if (userId == null) {
    return false;
  }
  var response = await _supabase
      .from('users')
      .select('is_commercial')
      .eq('user_id', userId);
  print(response[0]['is_commercial']);
  return response[0]['is_commercial'];
}

dispose() {
  return _supabase.dispose();
}
