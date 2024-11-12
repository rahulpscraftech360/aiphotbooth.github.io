import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> saveUserData(String name, String photoUrl) async {
    final response = await supabase.from('users').insert({
      'name': name,
      'photo_url': photoUrl,
    });

    if (response.error != null) {
      print(
          "Error: ${response.error?.message}"); // Using ?. to avoid calling on null
    } else {
      print("User data saved successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Supabase Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await saveUserData("John Doe", "https://example.com/photo.jpg");
          },
          child: Text("Save User Data"),
        ),
      ),
    );
  }
}
