import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class StorageService {
  final SupabaseClient _supabaseClient;

  StorageService(this._supabaseClient);

  /// Picks and uploads a file, then returns the URL.
  Future<String?> uploadFile() async {
    // Pick a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = result.files.single.name;

      // Upload file to Supabase Storage
      final response = await _supabaseClient.storage
          .from('Files')
          .upload('folder/$fileName', file);


      // Get the URL of the uploaded file
      final fileUrl = _supabaseClient.storage
          .from('Files')
          .getPublicUrl('folder/$fileName');
      print(fileUrl);

      return fileUrl;
    } else {
      print('No file selected');
      return null;
    }
  }
}

void main() {
  // Initialize Supabase client
  Supabase.initialize(
    url: 'your-project-url',
    anonKey: 'your-anon-key',
  );


}