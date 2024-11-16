import 'package:flutter_test/flutter_test.dart';
import 'package:macro_calculator/utils/gpx/csv_writer.dart';
import 'package:macro_calculator/utils/gpx/gpx_reader.dart';

void main() {
  group('CsvWriter', () {
    late CsvWriter writer;
    late GpxReader reader;

    setUp(() {
      writer = CsvWriter();
      reader = GpxReader();
    });

    test('converts simple GPX to CSV', () {
      final gpxString = '''
<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" creator="test">
  <wpt lat="45.123" lon="-122.456">
    <ele>100.0</ele>
    <time>2023-01-01T10:00:00Z</time>
    <name>Test Point</name>
    <desc>Test Description</desc>
  </wpt>
</gpx>
''';

      final gpx = reader.fromString(gpxString);
      final csv = writer.asString(gpx);

      final expectedCsv = 'name,lat,lon,ele,desc,time\n'
          'Test Point,45.123,-122.456,100.0,Test Description,2023-01-01T10:00:00.000Z\n';

      expect(csv, expectedCsv);
    });

    test('handles special characters in fields', () {
      final gpxString = '''
<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" creator="test">
  <wpt lat="45.123" lon="-122.456">
    <name>Point, with comma</name>
    <desc>Description with "quotes"</desc>
  </wpt>
</gpx>
''';

      final gpx = reader.fromString(gpxString);
      final csv = writer.asString(gpx);

      final expectedCsv = 'name,lat,lon,ele,desc,time\n'
          '"Point, with comma",45.123,-122.456,,"Description with ""quotes""",\n';

      expect(csv, expectedCsv);
    });

    test('converts route points to CSV', () {
      final gpxString = '''
<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" creator="test">
  <rte>
    <rtept lat="45.123" lon="-122.456">
      <name>Route Point 1</name>
    </rtept>
    <rtept lat="45.124" lon="-122.457">
      <name>Route Point 2</name>
    </rtept>
  </rte>
</gpx>
''';

      final gpx = reader.fromString(gpxString);
      final csv = writer.asString(gpx);

      final expectedCsv = 'name,lat,lon,ele,desc,time\n'
          'Route Point 1,45.123,-122.456,,,\n'
          'Route Point 2,45.124,-122.457,,,\n';

      expect(csv, expectedCsv);
    });

    test('converts track points to CSV', () {
      final gpxString = '''
<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" creator="test">
  <trk>
    <trkseg>
      <trkpt lat="45.123" lon="-122.456">
        <name>Track Point 1</name>
      </trkpt>
      <trkpt lat="45.124" lon="-122.457">
        <name>Track Point 2</name>
      </trkpt>
    </trkseg>
  </trk>
</gpx>
''';

      final gpx = reader.fromString(gpxString);
      final csv = writer.asString(gpx);

      final expectedCsv = 'name,lat,lon,ele,desc,time\n'
          'Track Point 1,45.123,-122.456,,,\n'
          'Track Point 2,45.124,-122.457,,,\n';

      expect(csv, expectedCsv);
    });

    test('handles empty GPX file', () {
      final gpxString = '''
<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" creator="test">
</gpx>
''';

      final gpx = reader.fromString(gpxString);
      final csv = writer.asString(gpx);

      final expectedCsv = 'name,lat,lon,ele,desc,time\n';

      expect(csv, expectedCsv);
    });
  });
}
