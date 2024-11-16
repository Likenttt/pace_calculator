import 'model/gpx.dart';
import 'model/wpt.dart';

/// Convert Gpx into CSV
class CsvWriter {
  /// Convert Gpx into CSV as String
  String asString(Gpx gpx) {
    final buffer = StringBuffer();

    // Write header
    buffer.writeln('name,lat,lon,ele,desc,time');

    // Write waypoints
    for (final wpt in gpx.wpts) {
      buffer.writeln(_wptToCsvRow(wpt));
    }

    // Write route points
    for (final rte in gpx.rtes) {
      for (final wpt in rte.rtepts) {
        buffer.writeln(_wptToCsvRow(wpt));
      }
    }

    // Write track points
    for (final trk in gpx.trks) {
      for (final seg in trk.trksegs) {
        for (final wpt in seg.trkpts) {
          buffer.writeln(_wptToCsvRow(wpt));
        }
      }
    }

    return buffer.toString();
  }

  String _wptToCsvRow(Wpt wpt) {
    // Escape and quote strings that may contain commas
    final name = _escapeField(wpt.name);
    final desc = _escapeField(wpt.desc);
    final time = wpt.time?.toIso8601String() ?? '';

    return [
      name,
      wpt.lat.toString(),
      wpt.lon.toString(),
      wpt.ele?.toString() ?? '',
      desc,
      time,
    ].join(',');
  }

  String _escapeField(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }

    // If the field contains commas, quotes, or newlines, wrap it in quotes
    // and escape any existing quotes
    if (value.contains(RegExp(r'[,"\n]'))) {
      return '"${value.replaceAll('"', '""')}"';
    }

    return value;
  }
}
