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
  print(data);
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
  print("upload image output is as follows: $output");
  return output;
}

Future<List> getAllDocumentsByRequesterID(String userId) async {
  final data =
      await _supabase.from('documents').select('*').eq("requested_by", userId);
  return data;
}

Future createNewUser(String email, String password) async {
  return await _supabase.auth.signUp(email: email, password: password);
}

Future signInUser(String email, String password) async {
  return await _supabase.auth
      .signInWithPassword(email: email, password: password);
}

getUserSession() {
  return _supabase.auth.currentSession;
}

Future logoutuser() {
  return _supabase.auth.signOut();
}

String getUserId() {
  return _supabase.auth.currentUser!.id;
}
