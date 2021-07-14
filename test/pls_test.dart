import 'package:flutter_test/flutter_test.dart';
import 'package:pls/src/pls_entry.dart';
import 'package:pls/src/pls_playlist.dart';

void main() async {
  group('Parse pls file', () {
    final String fileString = """[playlist]
    numberofentries=2
    File1=http://example/stream/1
    Title1=EXAMPLE | FM
    Length1=-1
    File2=http://example2/stream/1
    Title1=EXAMPLE2 | FM
    Length1=-1
    Version=2
    """;

    final plsParser = PlsPlaylist.parse(fileString);

    test('Entries not null', () {
      expect(plsParser.entries, isNotNull);
    });

    test('Parses entry', () {
      expect(plsParser.entries!.length, 2);
    });

    test('Version not null', () {
      expect(plsParser.version, isNotNull);
    });

    test('NumberOfEntries not null', () {
      expect(plsParser.numberOfEntries, isNotNull);
    });

    test('Parses numberOfEntries', () {
      expect(plsParser.numberOfEntries, 2);
    });

    test('Parses version', () {
      expect(plsParser.version, 2);
    });

    final PlsEntry entry = plsParser.entries![0];

    test('Parses title', () {
      expect(
        entry.title,
        'EXAMPLE | FM',
        reason: "Parsed title doesn’t match the expected one",
      );
    });

    test('Parses file', () {
      expect(
        entry.file,
        'http://example/stream/1',
        reason: "File location doesn’t match the expected one",
      );
    });

    test('Parses author', () {
      expect(entry.length, -1,
          reason: "the parsed author doesn’t match the expected one");
    });
  });
}
