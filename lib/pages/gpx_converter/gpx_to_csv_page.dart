import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';
import '../../utils/gpx/gpx_reader.dart';
import '../../utils/gpx/csv_writer.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gpxToCsv'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: const Icon(Icons.file_upload),
              label: Text('selectGpxFile'.tr()),
            ),
            if (selectedFilePath != null) ...[
              const SizedBox(height: 16),
              Text('selectedFile'.tr(args: [selectedFilePath ?? ''])),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  try {
                    // Read GPX file
                    final gpxReader = GpxReader();
                    final gpxContent =
                        await File(selectedFilePath!).readAsString();
                    final gpx = gpxReader.fromString(gpxContent);

                    // Convert to CSV
                    final csvWriter = CsvWriter();
                    final csvContent = csvWriter.asString(gpx);

                    // Get original filename without extension
                    final originalFileName =
                        selectedFilePath!.split(Platform.pathSeparator).last;
                    final nameWithoutExtension =
                        originalFileName.replaceAll(RegExp(r'\.gpx$'), '');
                    final newFileName =
                        '${nameWithoutExtension}_converted_by_pacelator.csv';

                    // Ask user for save location
                    final result = await FilePicker.platform.saveFile(
                      dialogTitle: 'saveCsvFile'.tr(),
                      fileName: newFileName,
                      type: FileType.custom,
                      allowedExtensions: ['csv'],
                    );

                    if (result != null) {
                      // Save the file
                      final file = File(result);
                      await file.writeAsString(csvContent);

                      // Show success message
                      if (mounted) {
                        messenger.showSnackBar(
                          SnackBar(
                              content: Text('fileConvertedSuccessfully'.tr())),
                        );
                      }
                    }
                  } catch (e) {
                    if (mounted) {
                      messenger.showSnackBar(
                        SnackBar(
                            content: Text('errorConvertingFile'
                                .tr(args: [e.toString()]))),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.transform),
                label: Text('convertToCsv'.tr()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
