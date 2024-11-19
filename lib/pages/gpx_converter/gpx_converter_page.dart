import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pacelator_toolbox/pages/pace_calculator_page.dart';
import 'package:pacelator_toolbox/utils/gpx/gpx_converter.dart';
import 'package:pacelator_toolbox/utils/helpers.dart';

enum GpxConvertFormat { csv, fit, kml, kmz, pdf, tcx, coordinates }

class GpxConverterPage extends StatefulWidget {
  final GpxConvertFormat targetFormat;

  const GpxConverterPage({
    super.key,
    required this.targetFormat,
  });

  @override
  State<GpxConverterPage> createState() => _GpxConverterPageState();
}

class _GpxConverterPageState extends State<GpxConverterPage> {
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

  GpxConverter _getConverter() {
    return GpxConverter.forFormat(widget.targetFormat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'gpxTo${widget.targetFormat.name.toLowerCase().firstCapital()}'
                .tr()),
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
                    final gpxContent =
                        await File(selectedFilePath!).readAsString();
                    final converter = _getConverter();
                    await converter.convert(
                      gpxContent,
                      selectedFilePath!,
                      context,
                      mounted,
                    );
                  } catch (e) {
                    if (mounted) {
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                              'errorConvertingFile'.tr(args: [e.toString()])),
                        ),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.transform),
                label: Text(
                    'convertTo${widget.targetFormat.name.toLowerCase().firstCapital()}'
                        .tr()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
