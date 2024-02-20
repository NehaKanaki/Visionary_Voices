import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:visionary_voices/screens/signin_screen.dart';

class Singlefilepicker extends StatefulWidget {
  const Singlefilepicker({super.key});

  @override
  State<Singlefilepicker> createState() => _SinglefilepickerState();
}

class _SinglefilepickerState extends State<Singlefilepicker> {
  PlatformFile? file;

  Future<void> picksinglefile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        file = result.files.first;
        file == null ? false : OpenAppFile.open(file!.path.toString());
      }
  }

  
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient:
                  LinearGradient(colors: [Color.fromARGB(255, 49, 168, 215),
                    Color.fromARGB(255, 58, 207, 100)])),
            ),
            title: const Text(
              'File Picker',
              style: TextStyle(
                  color: Color.fromARGB(255, 59, 54, 54),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            )
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                height: size.height,
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                          onPressed: picksinglefile,
                          style: const ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll(Color.fromARGB
                                (255, 61, 186, 228))),
                          icon: const Icon(Icons.insert_drive_file_sharp),
                          label: const Text(
                            'Pick File',
                            style: TextStyle(fontSize: 25),
                          )),

                        SizedBox(

                        child: ElevatedButton(

                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                          },
                            child: const Text('Logout'),
                        ),
                          ),
                              const SizedBox(
                                height: 20.0,
                              ),
                    ]
                )
                ),
              )
          ),
        ));
  }
}
