import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class GpxToCsvPage extends StatefulWidget {
  const GpxToCsvPage({super.key});

  @override
  State<GpxToCsvPage> createState() => _GpxToCsvPageState();
}

class _GpxToCsvPageState extends State<GpxToCsvPage> {
  String? selectedFilePath;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gpx'],
    );

    if (result != null) {
      setState(() {
        selectedFilePath = result.files.single.path;
      });
      // TODO: 处理GPX到CSV的转换
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPX to CSV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: const Icon(Icons.file_upload),
              label: const Text('Select GPX File'),
            ),
            if (selectedFilePath != null) ...[
              const SizedBox(height: 16),
              Text('Selected file: $selectedFilePath'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: 实现转换功能
                },
                icon: const Icon(Icons.transform),
                label: const Text('Convert to CSV'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
