import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pst1/Screens/textFieldBuilder.dart';
import 'package:pst1/Styles/app_colors.dart';
import 'package:pst1/models/file_pages.dart';

import 'app_theme.dart';

class Compose extends StatefulWidget {
  const Compose({Key? key}) : super(key: key);

  @override
  State<Compose> createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  bool showToCcBcc = false;
  //object creation for FilePages
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController bccController = TextEditingController();
  TextEditingController subController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();

    final newFile = File('${appStorage.path}/ ${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  void openFiles(List<PlatformFile> files) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FilePages(files: files, onOpenedFile: openFile),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Compose"),
        backgroundColor: AppColors.lightblueshade,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.attach_file,
              color: Colors.white,
            ),
            // onPressed: () {},

            onPressed: () async {
              // // do something
              final result = await FilePicker.platform
                  .pickFiles(allowMultiple: true, type: FileType.any);
              // allowedExtensions: [
              //   'pdf',
              //   'mp4',
              //   'docx',
              //   'jpg',
              //   'png',
              //   'jpeg',
              // ]);

              if (result == null) return;
              // open single file
              //final file = result.files.first;
              //openFile(file);
              // print('Name: ${file.name} ');
              // print('Bytes: ${file.bytes} ');
              // print('Name: ${file.size} ');
              // print('Extension: ${file.extension} ');
              // print('Path: ${file.path}');

              // final newFile = await saveFilePermanently(file);
              // print("from path: ${file.path}");
              // print("To path: ${newFile.path}");
              openFiles(result.files);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: InkWell(
                        onTap: (() {}),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.contact_page_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Add from contacts")
                          ],
                        ),
                      )),
                      PopupMenuItem(
                          child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: const [
                            Icon(
                              Icons.stop,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Discard")
                          ],
                        ),
                      )),
                      PopupMenuItem(
                          child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: const [
                            Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Setting")
                          ],
                        ),
                      )),
                    ],
                child: const Icon(Icons.expand_circle_down)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: buildTextField(Icons.assignment_ind_outlined, "From",
                      false, true, fromController),
                ),
                IconButton(
                    onPressed: () {
                      showToCcBcc = true;
                      setState(() {});
                    },
                    icon: const Icon(Icons.abc))
              ],
            ),
            buildTextField(
                Icons.assignment_ind_outlined, "To", false, true, toController),
            showToCcBcc == true
                ? Column(
                    children: [
                      buildTextField(Icons.assignment_ind_outlined, "Cc", false,
                          true, ccController),
                      buildTextField(Icons.assignment_ind_outlined, "Bcc",
                          false, true, bccController),
                    ],
                  )
                : const Text(" "),
            buildTextField(
                Icons.subject_outlined, "Subject", false, true, subController),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: "Compose Email",
                    hintStyle: AppTheme.searchTextStyle,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
