import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pacelator_toolbox/pages/gpx_converter/gpx_converter_page.dart';
import 'package:pacelator_toolbox/utils/gpx/csv_writer.dart';
import 'package:pacelator_toolbox/utils/gpx/gpx_reader.dart';
import 'package:pacelator_toolbox/utils/gpx/kml_writer.dart';

class FileExportHelper {
  static Future<void> saveFile({
    required String content,
    required String sourceFilePath,
    required String extension,
    required String dialogTitle,
    required BuildContext context,
    required bool mounted,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      // Get original filename without extension
      final originalFileName =
          sourceFilePath.split(Platform.pathSeparator).last;
      final nameWithoutExtension =
          originalFileName.replaceAll(RegExp(r'\.gpx$'), '');
      final newFileName =
          '${nameWithoutExtension}_converted_by_pacelator$extension';

      // Ask user for save location
      final result = await FilePicker.platform.saveFile(
        dialogTitle: dialogTitle,
        fileName: newFileName,
        type: FileType.custom,
        allowedExtensions: [extension.replaceAll('.', '')],
      );

      if (result != null) {
        final file = File(result);
        await file.writeAsString(content);

        if (mounted) {
          messenger.showSnackBar(
            SnackBar(content: Text('fileConvertedSuccessfully'.tr())),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(
              content: Text('errorConvertingFile'.tr(args: [e.toString()]))),
        );
      }
      rethrow;
    }
  }
}

class GpxConverter {
  final String extension;
  final String Function(String) convertContent;

  const GpxConverter({
    required this.extension,
    required this.convertContent,
  });

  Future<void> convert(
    String gpxContent,
    String selectedFilePath,
    BuildContext context,
    bool mounted,
  ) async {
    final convertedContent = convertContent(gpxContent);
    await FileExportHelper.saveFile(
      content: convertedContent,
      sourceFilePath: selectedFilePath,
      extension: extension,
      dialogTitle: 'save${extension.toUpperCase()}File'.tr(),
      context: context,
      mounted: mounted,
    );
  }

  static GpxConverter forFormat(GpxConvertFormat format) {
    switch (format) {
      case GpxConvertFormat.csv:
        return GpxConverter(
          extension: '.csv',
          convertContent: (content) {
            final gpxReader = GpxReader();
            final gpx = gpxReader.fromString(content);
            final csvWriter = CsvWriter();
            return csvWriter.asString(gpx);
          },
        );
      case GpxConvertFormat.fit:
        return GpxConverter(
          extension: '.fit',
          convertContent: (content) {
            // TODO: Implement FIT conversion
            return "";
          },
        );
      case GpxConvertFormat.kml:
        return GpxConverter(
          extension: '.kml',
          convertContent: (content) {
            final gpxReader = GpxReader();
            final gpx = gpxReader.fromString(content);
            final kmlWriter = KmlWriter();
            return kmlWriter.asString(gpx);
          },
        );
      case GpxConvertFormat.kmz:
        return GpxConverter(
          extension: '.kmz',
          convertContent: (content) {
            // TODO: Implement KMZ conversion
            return "";
          },
        );
      case GpxConvertFormat.pdf:
        return GpxConverter(
          extension: '.pdf',
          convertContent: (content) {
            // TODO: Implement PDF conversion
            return "";
          },
        );
      case GpxConvertFormat.tcx:
        return GpxConverter(
          extension: '.tcx',
          convertContent: (content) {
            // TODO: Implement TCX conversion
            return "";
          },
        );
      case GpxConvertFormat.coordinates:
        return GpxConverter(
          extension: '.txt',
          convertContent: (content) {
            // TODO: Implement coordinates conversion
            return "";
          },
        );
    }
  }
}
