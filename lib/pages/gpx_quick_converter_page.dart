import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pacelator_toolbox/pages/gpx_converter/gpx_converter_page.dart';
import 'dart:io';

class GpxQuickConverterPage extends StatefulWidget {
  final String? initialFilePath;

  const GpxQuickConverterPage({
    super.key,
    this.initialFilePath,
  });

  @override
  State<GpxQuickConverterPage> createState() => _GpxQuickConverterPageState();
}

class _GpxQuickConverterPageState extends State<GpxQuickConverterPage> {
  String? _filePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filePath = widget.initialFilePath;
  }

  Future<void> _convertFile(GpxConvertFormat format) async {
    if (_filePath == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: 实现文件转换逻辑
      await Future.delayed(const Duration(seconds: 2)); // 模拟转换过程
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gpxConverter'.tr()),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // 文件信息区域
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _filePath != null
                            ? File(_filePath!).uri.pathSegments.last
                            : 'noFileSelected'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.folder_open),
                      onPressed: () async {
                        // TODO: 实现文件选择逻辑
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              // 转换按钮区域
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    _buildConvertButton(
                      context,
                      'CSV',
                      Icons.file_present,
                      GpxConvertFormat.csv,
                    ),
                    _buildConvertButton(
                      context,
                      'FIT',
                      Icons.fitness_center,
                      GpxConvertFormat.fit,
                    ),
                    _buildConvertButton(
                      context,
                      'KML',
                      Icons.map,
                      GpxConvertFormat.kml,
                    ),
                    _buildConvertButton(
                      context,
                      'KMZ',
                      Icons.map_outlined,
                      GpxConvertFormat.kmz,
                    ),
                    _buildConvertButton(
                      context,
                      'PDF',
                      Icons.picture_as_pdf,
                      GpxConvertFormat.pdf,
                    ),
                    _buildConvertButton(
                      context,
                      'TCX',
                      Icons.map,
                      GpxConvertFormat.tcx,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildConvertButton(
    BuildContext context,
    String label,
    IconData icon,
    GpxConvertFormat format,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        onPressed: _filePath == null ? null : () => _convertFile(format),
      ),
    );
  }
}
