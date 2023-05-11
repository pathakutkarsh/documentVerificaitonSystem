import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List> getAllDocumentsByUserId(String userId) async {
  final data =
      await supabase.from('documents').select('*').eq("user_id", userId);
  return data;
}

Future<Uint8List> downloadImageFromFileName(String fileName) async {
  final Uint8List file =
      await supabase.storage.from('documents/uploaded').download(fileName);
  return file;
}

createNewDocumentRequest(String id, bool aadhar, bool hsc, bool ssc) async {
  await supabase.from('request').insert({
    'id': id,
    'request_aadhar': aadhar,
    'request_hsc': hsc,
    'request_ssc': ssc
  });
}

Future<Map> getListofRequestedDocumentsFromID(String id) async {
  final List data = await supabase.from('request').select('*').eq("id", id);
  print(data);
  return data[0];
}

uploadNewDocument(
    fileName, isValidated, isVerified, userId, requestedById, fileType) async {
  await supabase.from('documents').insert(
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

uploadImageToBucket(String filePath, fileName) async {
  dynamic output = await supabase.storage
      .from('documents')
      .upload('/uploaded/$fileName', File(filePath));
  print(output);
}
