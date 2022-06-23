import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FilePages extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const FilePages({
    Key? key,
    required this.files,
    required this.onOpenedFile,
  }) : super(key: key);

  @override
  State<FilePages> createState() => _FilePagesState();
}

class _FilePagesState extends State<FilePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Files"),
        centerTitle: true,
      ),
      body: Center(
          child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: widget.files.length,
              itemBuilder: (context, index) {
                final file = widget.files[index];
                return buildFile(file);
              })),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize = mb >= 1 ? mb.toStringAsFixed(2) : kb.toStringAsFixed(2);
    // ignore: unused_local_variable
    final extention = file.extension ?? 'none';
    // final color = getColor(extension);
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                //  color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '.$extension',
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            file.name,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
          ),
          Text(
            fileSize,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ]),
      ),
    );
  }
}
